const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../../models/User');
const keys = require('../../config/keys');

const validateRegisterInput = require('../validation/register');

// here we'll be taking in the `data` from our mutation
const register = async (data) => {
  try {
    const { message, isValid } = validateRegisterInput(data);

    // if the data we received isn't valid through up the error message from validator
    if (!isValid) {
      throw new Error(message);
    }

    const { name, email, password } = data;

    // we want to wait until our model can tell us whether a user exists with that email
    const existingUser = await User.findOne({ email });

    if (existingUser) {
      throw new Error('This user already exists');
    }
    const hashedPassword = await bcrypt.hash(password, 10);

    // create a new user with all our arguments
    const user = new User(
      {
        name,
        email,
        password: hashedPassword,
      },
      (err) => {
        if (err) throw err;
      },
    );

    // save our user
    user.save();

    const token = jwt.sign({ id: user._id }, keys.secretOrKey);

    return { token, loggedIn: true, ...user._doc, password: null };
  } catch (err) {
    throw err;
  }
};

module.exports = { register };
