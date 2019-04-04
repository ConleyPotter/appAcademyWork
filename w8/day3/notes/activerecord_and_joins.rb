### ActiveRecord::Base::joins ###

# When we were writing raw SQL we learned that the JOIN clause was a powerful 
# tool that allowed us to combine rows from different tables to find information 
# about related data in these tables. For example, if I wanted to find all of 
# the comments made by a user with the user_name 'tamboer' I could make a query 
# like this:

SELECT
  comments.*
FROM
  comments
JOIN
  users ON users.id = comments.author_id
WHERE
  users.user_name = 'tamboer';

# To fire the exact same query using ActiveRecord methods we would write 
Comment.joins(:author).where(users: { user_name: 'tamboer' })

# Let's break this line down. First we start with the Comment model. This 
# already tells ActiveRecord that the FROM clause of our query should use the 
# comments table. Then we call the joins method and pass in :author as an 
# argument.

# NOTE: When you are using the joins method you do not pass in the name of a 
# table. Instead, you are passing in the name of an association that has been 
# defined. Since the association has already been defined with a class name, 
# foreign key, and primary key, ActiveRecord can determine exactly how to join 
# your two tables together.

# Then finally in our call to the where method we pass a hash of 
{ users: { user_name: 'tamboer' } } 

# We've seen simpler uses of where in which we just pass a key-value pair, 
# with the key referencing a column name and the value being the value we want to 
# match. When we pass a nested hash like this, the outermost key is the name of 
# a table and the innermost hash has a key that is a column name in that table. 
# When we join two tables together, we want to be specific about which table the 
# column names we are matching come from. We could also replace our original 
# call to where with where("users.user_name = 'tamboer'"). It's important to 
# note that even though we used the name of the association in our call to 
# joins we still use the real name of the table when we are referencing one of 
# its columns.

## More complex Joins ##

# If you want to join more than one table to another, the syntax for the 
# ActiveRecord::Base::joins method doesn't get much more complicated. If you 
# have a through association defined on a model, it's as simple as just using 
# the name of the association.

User.joins(:post_feedback) # generates this query:

SELECT
  users.*
FROM
  users
JOIN
  posts ON posts.author_id = users.id
JOIN
  comments ON comments.post_id = posts.id

# The :post_feedback association has already been set up to go from the users 
# table, through the posts table, and to the comments table. If we didn't have 
# this through association defined for us we could write User.joins(posts: :comments). 
# Check out the Active Record Guides on joins for more info on this syntax!
# http://guides.rubyonrails.org/active_record_querying.html#joining-tables

# We can also call the joins method on an ActiveRecord::Relation object. 
# For example:

post = Post.find(1)
post.comments.joins(:author)
# The line above generates the query
# SELECT comments.* FROM comments JOIN users ON users.id = comments.author_id 
# WHERE comments.post_id = 1

# The WHERE comments.post_id = 1 portion of that query came from the fact that 
# we used the comments association on a post with an id of 1. This filtering 
# remains even when we add our call to joins afterwards. Gotta love laziness 
# and stacking!

### Using Select with Join ###

# If we don't add a call to select on to our call to joins we'll only have 
# access to columns from the primary table in our query.

users = User.joins(:posts)
users[0].user_name # => 'ruggeri'
users[0].title # => undefined method 'title' for User object

# This is because the select statement was defaulted to users.*. If we wanted 
# the User objects we got back from our query to have access to attributes 
# from the posts table we would have to explicitly say that.

users = User.joins(:posts).select("users.*, posts.*")
users[0].user_name # => "ruggeri"
users[0].title # => "First post!"

# If you just examine the user object, you won't see the title attribute.

users[0]
=> id: 1,
 user_name: "ruggeri",
 first_name: "Ned",
 last_name: "Ruggeri",
 created_at: Tue, 03 Apr 2018 14:39:57 UTC +00:00,
 updated_at: Tue, 03 Apr 2018 14:39:57 UTC +00:00>

# This is because the inspect method for User objects only show attributes that 
# are column names from the users table. But if we use the #attributes method 
# we can see all of the attributes that our user has access to.

users[0].attributes
=>{"id"=>1,
   "user_name"=>"ruggeri",
   "first_name"=>"Ned",
   "last_name"=>"Ruggeri",
   "created_at"=>Tue, 03 Apr 2018 14:39:57 UTC +00:00,
   "updated_at"=>Tue, 03 Apr 2018 14:39:57 UTC +00:00,
   "title"=>"First post!",
   "body"=>"First posting is fun!",
   "author_id"=>1}

# We can also alias attributes in a call to select. This is especially useful 
# if we have columns from two different tables with the same name. Let's use 
# created_at as a trivial example.

Post.create!(author_id: 1, title: "Who loves active record?", body: "If you like active record say yeah!")
users = User.joins(:posts).select("users.*, posts.created_at as post_creation_time")

users[0].attributes
=> {"id"=>1,
 "user_name"=>"ruggeri",
 "first_name"=>"Ned",
 "last_name"=>"Ruggeri",
 "created_at"=>Tue, 03 Apr 2018 14:39:57 UTC +00:00,
 "updated_at"=>Tue, 03 Apr 2018 14:39:57 UTC +00:00,
 "post_creation_time"=>"2018-04-03 14:39:57.563795"}

 users[1].attributes
 {"id"=>1,
 "user_name"=>"ruggeri",
 "first_name"=>"Ned",
 "last_name"=>"Ruggeri",
 "created_at"=>Tue, 03 Apr 2018 14:39:57 UTC +00:00,
 "updated_at"=>Tue, 03 Apr 2018 14:39:57 UTC +00:00,
 "post_creation_time"=>"2018-04-03 20:04:13.596728"}

#  First we should note that we have an attribute called "post_creation_time" 
# that we can now access on our user objects because that's what we gave as 
# an alias in our call to select. Second we should note that users0 and users1 
# both have the attributes of our ruggeri user but they have different values 
# for post_creation_time. Don't forget that if we're joining the users table to 
# the posts table it is possible to have two rows that refer to the same user 
# with different posts. In raw SQL the resulting table from selecting * and 
# joining users to posts would look something like this:

# IMG in file

# The first row becomes the first element in our ActiveRecord::Relation object 
# and the second row become the second element in our object.

# Check out the Active Record Guides on joins for more info!
# http://guides.rubyonrails.org/active_record_querying.html#joining-tables