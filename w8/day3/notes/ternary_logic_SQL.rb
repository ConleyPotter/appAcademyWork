### NULL and Ternary Logic in SQL ###

# SQL uses ternary logic. This means that a conditional statement can evaluate to 
# TRUE, FALSE or NULL. Whaaaa? :open_mouth: That is strange.

# How in the world do you get a conditional statement to return NULL? You compare 
# something to NULL, that's how!

# Incidentally, NULL compared to anything (including NULL) is NULL, and NULL is 
# falsy, so WHERE clauses that compare to NULL will always return nothing. 
# This is why you see IS NULL and IS NOT NULL in SQL queries instead of = NULL 
# or != NULL.

### The Interpolation Problem ###

# Consider now what happens when you try to interpolate something that might be 
# NULL into a where clause. A classic case of this would be excluding an 
# individual from a set.

User.where('id != ?', user.id)

# This works fine so long as the user is saved to the DB and has an id. If 
# they're not saved though, this will evaluate to id != NULL and return no 
# results. At the same time, we can't say id IS NOT ? because that will fail 
# if there is an id.

# We're darned if we do and darned if we don't!

### Rails Magic ###

# You might be wondering why we've never come across this problem before. 
# There's a reason for that, and it's name is magic. Whenever we've used nil 
# inside a where before this, Rails just knew how to deal with it:

User.where(email: nil)

# This works just fine because Rails detects that email is being compared to 
# NULL and sets up the correct verbage for SQL. We're having trouble now because 
# we need to negate the comparison so we're using a SQL fragment. This locks 
# Rails into our pre-set SQL so it can't work its magic.

# So how do we make this work? How do we bring back the magic?

# We need the magic of where, but the power of !. We need where.not!

User.where.not(id: user.id)

# Now Rails is free to do its IS NOT magic without our SQL fragment in the way, 
# and our query works as intended.