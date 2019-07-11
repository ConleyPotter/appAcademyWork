// Setting Up the User //

// We'll start by discussing the heart of authentication: the User. For the 
// rest of this reading we'll be implementing GraphQL with a Mongo and Express 
// backend but the following ideas would work just as well with any other 
// backend. So our User model will probably resemble something like this:

const UserSchema = new Schema({
  email: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  }
});

// For the rest of this reading we'll assume our underlying model will have an 
// email and a password but of course all this would work for a model with a 
// username too. Now based off the above model we'd want our GraphQL type to 
// remove one field, and add three new ones.

// user_type.js
const UserType = new GraphQLObjectType({
  name: "UserType",
  fields: () => ({
    // Mongoose automatically generates an ID field for our models so we'll want to be able to return it
    _id: { type: GraphQLID },
    email: { type: GraphQLString },
    // we'll be able to return a boolean to indicate if the user is logged In
    loggedIn: { type: GraphQLBoolean },
    // Adding token will allow us to generate and return an authentication token
    token: { type: GraphQLString }
  })
});

// You might notice we don't have a field for password in our UserType. That is 
// because we will not need GraphQL to ever return a user's password from a 
// query. Now that your User type is properly setup you can work on the backend 
// mutations.

// Authentication Mutations //

// We'll require three additional libraries for authentication in our backend:

// 1. jsonwebtoken - to generate tokens to put into our incoming and outgoing requests.
// 2. bcryptjs - to salt and hash incoming passwords.
// 3. validator - for writing our database validations

// You'll also need to add a new string to wherever you are currently keeping 
// your configuration keys. This string will be what we use to encode or decode 
// a user's authentication token. We recommend using a UUID, or some other 
// long random string generator, for this purpose.

// config/keys.js

module.exports = {
  MONGO_URI: "blahblah",
  secretOrKey: "1234567-jsdakhjds-ajsjkdjkdsa"
};

// Server Validation //

// Like always we will want to make sure we run validations on any incoming 
// information from a user before attempting to do anything with that info. We 
// can use the validator library for just that. For organizational purposes 
// you'll want to place these validations in a separate directory dedicated to 
// that purpose.

// So we'll start by writing a function that can be used to check any input 
// before it is passed to validator. We first create a function to make sure 
// the incoming string is in fact a String:

// validations/valid_text.js

const validText = str => {
  return typeof str === "string" && str.trim().length > 0;
};


// Once we know the input we received is in fact a String then we can run 
// validations. Validator provides us with a number of built-in functions we 
// can use to validate our input. These include isEmail, isEmpty, isLength, 
// and equals. Here is an example of how we might validate the inputs for 
// logging in:

module.exports = function validateInputs(data) {
  data.email = validText(data.email) ? data.email : "";
  data.name = validText(data.name) ? data.name : "";
  data.password = validText(data.password) ? data.password : "";

  if (!Validator.isEmail(data.email)) {
    return { message: "Email is invalid", isValid: false };
  }

  if (Validator.isEmpty(data.email)) {
    return { message: "Email field is required", isValid: false };
  }

  if (Validator.isEmpty(data.name)) {
    return { message: "Name field is required", isValid: false };
  }

  if (Validator.isEmpty(data.password)) {
    return { message: "Password field is required", isValid: false };
  }

  return {
    message: "",
    isValid: true
  };
};

// From our validateInputs function we will return an object which specifies 
// whether the given input is valid. If it is not, we include a message to 
// render client side errors. If it is valid, then don't need to return a message.

// Adding Authentication Services //

// Now that we've got the our User type, and validation setup we can start 
// writing the code that will actually do the authentication for us. Now we'll 
// write the heavy lifting of User authentication: the mutations with their 
// resolve functions. However, authentication breaks down into many different steps.

// For registering a new User we need to:

// 1. Validate our inputs using the validateInputs function.
// 2. Hash the incoming password
// 3. Construct and save a new user with everything that was passed in
// 4. Create our authentication token using jsonwebtoken
// 5. Set loggedIn to true
// 6. Return all the information to our resolver except the hashed password

// For logging in an existing User we need to:

// 1. Validate our inputs using the validateInputs function.
// 2. Find a user based on the passed in email.
// 3. Validate the password upon the User we found using BCrypt
// 4. Create our authentication token using jsonwebtoken
// 5. Set loggedIn to true
// 6. Return all the information to our resolver except the hashed password

// A lot of those steps are similar but slightly different. If we wrote all 
// that code in our mutations file it would be a mess! Instead we recommend 
// creating a separate file to handle all your authentication logic then 
// importing the functions you wrote.

// For example for registering a new User our register function would look 
// something like this:

// services/auth.js

// we use async/await in order to ensure this function will fully complete every step before returned
const register = async data => {
  try {
    // make sure our inputs our valid
    const { message, isValid } = validateRegisterInput(data);

    if (!isValid) {
      throw new Error(message);
    }

    const { name, email, password } = data;
    // make sure this sure doesn't already exist
    const existingUser = await User.findOne({ email });

    if (existingUser) {
      throw new Error("This user already exists");
    }
    // hash our password
    const hashedPassword = await bcrypt.hash(password, 10);
    // create a new User
    const user = new User(
      {
        name,
        email,
        password: hashedPassword
      },
      err => {
        if (err) throw err;
      }
    );

    user.save();
    // create our authentication token using the secretOrkey we created before
    const token = jwt.sign({ id: user._id }, key);

    // return to our mutation the token, verifying this User is logged in
    // as well as the rest of the user's info, and blanking out the password
    return { token, loggedIn: true, ...user._doc, password: null };
  } catch (err) {
    throw err;
  }
};

// So the above function handles all the logic involved in registering a User. 
// Since we need this function to complete each promise before returning we make 
// sure to use the async/await syntax. With that done the register mutation 
// can be completed by using the above function in the resolver:

// schema/mutations.js
const mutation = new GraphQLObjectType({
  name: "Mutation",
  fields: {
    register: {
      // we make sure to return the User type. This type will also now
      // have fields for returning the token and loggedIn value.
      type: UserType,
      args: {
        name: { type: new GraphQLNonNull(GraphQLString) },
        email: { type: new GraphQLNonNull(GraphQLString) },
        password: { type: new GraphQLNonNull(GraphQLString) }
      },
      resolve(parentValue, data) {
        return AuthService.register(data);
      }
    }
  }
});

// And that is all that is needed in order to register a User and kick off the 
// authentication cycle in GraphQL. Logged in will work much the same way as 
// register. The last piece of the puzzle in backend authentication is how we 
// will utilize the token. We'll be talking a lot more about that when we come 
// to frontend authentication - but we will need one more function in our 
// backend besides register and login.

// The following is a function that will take in a User's token and will then 
// verify that token belongs to a valid User:

const verifyUser = async data => {
  try {
    // it take in the authentication token
    const { token } = data;
    // we verify that token against our secretKey in order to get the User's original ID
    const decoded = jwt.verify(token, key);
    const { id } = decoded;

    // then we use that ID in order to see if that User does in fact exist
    // in our database
    const loggedIn = await User.findById(id).then(user => {
      return user ? true : false;
    });

    return { loggedIn };
  } catch (err) {
    return { loggedIn: false };
  }
};

// Again, we'll make use of this function when we move to the frontend.