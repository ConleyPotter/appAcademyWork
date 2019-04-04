### Queries are Lazy ###

# Querying methods like group, having, includes, joins, select and where return 
# an object of type ActiveRecord::Relation. The Relation object looks a lot 
# like an Array; like an Array you can iterate through it or index into it.

# There is one major difference from an Array: the contents of Relation are not 
# fetched until needed. This is called laziness:

users = User.where('likes_dogs = ?', true) # no fetch yet!

# performs fetch here
users.each { |user| puts "Hello #{user.name}" }
# does not perform fetch; result is "cached"
users.each { |user| puts "Hello #{user.name}" }

# The Relation is not evaluated (a database query is not fired) until the 
# results are needed. In this example, on the first line where users is assigned, 
# the result is not yet needed. Only when we call each the first time do we 
# actually need the results and the query is forced.

### Caching ###

# After the query is run, the results are cached by Relation; they are stored 
# for later re-use. Subsequent calls to each will not fire a query; they will 
# instead use the prior result. This is an advantage because we can re-use the 
# result without constantly hitting the database over-and-over.

# This can sometimes result in unexpected behavior. First, note that when 
# accessing a relation (e.g. user1.posts), a Relation object is returned. 
# The relation is itself cached inside model object (e.g. user1) so that future 
# invocations of the association will not hit the DB.

# Fires a query; `posts` relation stored in `user1`.
p user1.posts
# => []
p user1.posts.object_id
# => 70232180387400

Post.create!(
  # THIS LINE IS KEY, BECAUSE IT TIES THE POST TO THE USER IN THE DATABASE
  #   |
  title: 'Title',
  user_id: user1.id, 
  body: 'Body body body'
)

# Does not fire a query; uses cached `posts` relation, which itself
# has cached the results.
p user1.posts
# => []
p user1.posts.object_id
# => 70232180387400

# Here user1.posts fires a query the first time. The second time, user1.posts 
# uses the prior result. The cached result, however, is out of date; in 
# between the first time we called user1.posts and the second time, we added a 
# new Post for the user. This is not reflected in the user1.posts variable.

# This behavior can be surprising, but it actually is not a common issue. You 
# can always force an association to be reloaded (ignoring any cached value) by 
# calling user1.posts(true). You may also call user1.reload to throw away all 
# cached association relations. However, this is seldom necessary.

### Laziness and Stacking Queries ###

# Caching results makes sense: it saves DB queries. But why is laziness a good 
# thing?

# Laziness allows us to build complex queries. Let's see an example:

georges = User.where('first_name = ?', 'George')
georges.where_values_hash
# => {first_name: 'George'}

george_harrisons = georges.where('last_name = ?', 'Harrison')
george_harrisons.where_values_hash
# => {first_name: 'George', last_name: 'Harrison'}

p george_harrisons

# In this somewhat silly example, we call where twice. The first call to where 
# returns a Relation which knows to filter by first_name (the condition is 
# stored in the where_values_hash attribute). Next, we call where on this 
# Relation; this produces a new Relation object which will know to filter by 
# both first_name and last_name (you can see that where_values_hash was 
# extended).

# Note that the additional where created a new Relation; the original georges 
# is not changed.

# The first Relation returned by the first where is never evaluated. Instead, 
# we build a second Relation from it. Here laziness helps us; it lets us build 
# up a query by chaining query methods, none of which are executed until the 
# chain is finished being built and evaluated.

# Just like where has a where_values_hash attribute, there are similar (private) 
# accessors for includes_values, joins_values, etc. You won't ever access the 
# attributes directly, but you can see how Relation builds up the query by 
# storing each of the conditions. When the Relation needs to be evaluated, 
# ActiveRecord looks at each of these values to build the SQL to execute.

### Forcing Evaluation ###

# If you wish to force the evaluation of a Relation, you may call load. This 
# will force evaluation if it hasn't been done already. Using to_a will return 
# an actual array.

# Some other methods, like count will also force the evaluation of a query.

### Count vs Length vs Size ###

# While all three of these methods will return the number of records in the 
# evaluated query, they do so in slightly different ways. When we call count on 
# a relation, we will execute a SQL query (SELECT COUNT(*) FROM ...). Calling 
# length, on the other hand, will load the entire collection into memory, 
# convert it to an array, and then call Array#length on it. If used incorrectly, 
# this could be an incredibly expensive operation (imagine if we have millions 
# of users and call User.all.length).

# If all we care about is returning the number of records, and nothing else, 
# count will be preferred because it allows us to avoid loading the collection 
# into memory. However, if we are going to load the collection into memory 
# anyway, length will be preferred because we can avoid having to do another 
# query altogether (since the collection will be cached in memory anyway). 
# size is sort of a combination of both methods - if the collection is already 
# loaded, it will count the elements without making a new query and, if not, 
# will execute an additional query.

