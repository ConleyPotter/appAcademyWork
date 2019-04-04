### N + 1 Queries ###

### The N+1 selects problem ###

# Let's write some code to get the number of comments per Post by a User:

# app/models/user.rb
class User < ApplicationRecord
  # ...

  def n_plus_one_post_comment_counts
    posts = self.posts
    # SELECT *
    #   FROM posts
    #  WHERE posts.author_id = ?
    #
    # where `?` gets replaced with `user.id`

    post_comment_counts = {}
    posts.each do |post|
      # This query gets performed once for each post. Each db query
      # has overhead, so this is very wasteful if there are a lot of
      # `Post`s for the `User`.
      post_comment_counts[post] = post.comments.length
      # SELECT *
      #   FROM comments
      #  WHERE comments.post_id = ?
      #
      # where `?` gets replaced with `post.id`
    end

    post_comment_counts
  end
end

# This code looks fine at the first sight. But the problem lies with the total 
# number of queries executed. The above code executes 1 query (to find the 
# user's posts) + "N" queries (one per post to find the comments) for N+1
# queries in total.

# This is inefficient. Consider if a user had 10,000 posts: we'd make 10,000 
# queries for comments. We will next see a way to perform one query for all the 
# comments, instead of N queries. Even though we will receive the same number of 
# comments rows total, doing all the work in one query is much more efficient. 
# Each query to the database has some fixed overhead associated with it, so 
# batching up work into one query is a major efficiency win.

## Solution to N+1 queries problem ##

# The solution to this problem is to fetch all the Comments for all the Posts in 
# one go, rather than fetch them one-by-one for each Post.

# Active Record lets you specify associations to prefetch. When you use these 
# associations later, the data will already have been fetched and won't need to 
# be queried for. To do this, use the includes method. If you use includes to 
# prefetch data (e.g., posts = user.posts.includes(:comments)), a subsequent 
# call to access the association (e.g., posts[0].comments) won't fire another 
# DB query; it'll use the prefetched data.

# Revisiting the above case, we could rewrite post_comment_counts to use eager 
# loading:

# app/model/user.rb
class User < ApplicationRecord
  # ...

  def includes_post_comment_counts
    # `includes` *prefetches the association* `comments`, so it doesn't
    # need to be queried for later. `includes` does not change the
    # type of the object returned (in this example, `Post`s); it only
    # prefetches extra data.
    posts = self.posts.includes(:comments)
    # Makes two queries:
    # SELECT *
    #   FROM posts
    #  WHERE post.author_id = ?
    #
    # where `?` is replaced with `user.id`.
    #
    # ...and...
    #
    # SELECT *
    #   FROM comments
    #  WHERE comments.post_id IN ?
    #
    # where `?` is replaced with `self.posts.map(&:id)`, the `Array`
    # of `Post` ids.

    post_comment_counts = {}
    posts.each do |post|
      # doesn't fire a query, since already prefetched the association
      # way better than N+1
      #
      # NB: if we write `post.comments.count` ActiveRecord will try to
      # be super-smart and run a `SELECT COUNT(*) FROM comments WHERE
      # comments.post_id = ?` query. This is because ActiveRecord
      # understands `#count`. But we already fetched the comments and
      # don't want to go back to the DB, so we can avoid this behavior
      # by calling `Array#length`.
      post_comment_counts[post] = post.comments.length
    end

    post_comment_counts
  end
end

# The above code will execute just 2 queries, as opposed to N+1 queries. 
# When there are many posts, this is a major win.

# Normally you should wait until you see performance problems before returning 
# to optimize code ("premature optimization is the root of all evil"). However, 
# N+1 queries are so egregious that you should avoid them from the beginning. 
# Consider N+1 queries an error; they are never the right solution.

## Complex includes ##

# You can eagerly load as many associations as you like:

comments = user.comments.includes(:post, :parent_comment)

# Then both the post and parent_comment associations are eagerly loaded. 
# Neither comments[0].post nor comments[0].parent_comment will hit the DB; 
# they've been prefetched.

# We can also do "nested" prefetches:

posts = user.posts.includes(:comments => [:author, :parent_comment])
first_post = posts[0]

# This not only prefetches first_post.comments, it also will prefetch 
# first_post.comments[0] and even first_post.comments[0].author and 
# first_post.comments[0].parent_comment.

### Joining Tables ###

# Let's see how we can use joins to solve our N + 1 problem.

# We've seen how to eagerly load associated objects to dodge the N+1 queries 
# problem. There is another problem we may run into: includes returns lots of 
# data: it returns every Comment on every Post that the User has written. This 
# may be many, many comments. In the case of counting comments per post, the 
# Comments themselves are useless, we just want to count them.

# We're doing too much in Ruby: we want to push some of the counting work to SQL 
# so that the database does it, and we receive just Post objects with associated 
# comment counts. This is another major use of joins:

# app/models/user.rb
class User
  # ...

  def joins_post_comment_counts
    # We use `includes` when we need to prefetch an association and
    # use those associated records. If we only want to *aggregate* the
    # associated records somehow, `includes` is wasteful, because all
    # the associated records are pulled down into the app.
    #
    # For instance, if a `User` has posts with many, many comments, we
    # would pull down every single comment. This may be more rows than
    # our Rails app can handle. And we don't actually care about all
    # the individual rows, we just want the count of how many there
    # are.
    #
    # When we want to do an "aggregation" like summing the number of
    # records (and don't care about the individual records), we want
    # to use `joins`.

    posts_with_counts = self
      .posts
      .select("posts.*, COUNT(*) AS comments_count") # more in a sec
      .joins(:comments)
      .group("posts.id") # "comments.post_id" would be equivalent
    # in SQL:
    #   SELECT posts.*, COUNT(*) AS comments_count
    #     FROM posts
    #    JOINS comments
    #       ON comments.post_id = posts.id
    #    WHERE posts.author_id = #{self.id}
    # GROUP BY posts.id
    #
    # As we've seen before using `joins` does not change the type of
    # object returned: this returns an `Array` of `Post` objects.
    #
    # But we do want some extra data about the `Post`: how many
    # comments were left on it. We can use `select` to pick up some
    # "bonus fields" and give us access to extra data.
    #
    # Here, I would like to have the database count the comments per
    # post, and store this in a column named `comments_count`. The
    # magic is that ActiveRecord will give me access to this column by
    # dynamically adding a new method to the returned `Post` objects;
    # I can call `#comments_count`, and it will access the value of
    # this column:

    posts_with_counts.map do |post|
      # `#comments_count` will access the column we `select`ed in the
      # query.
      [post.title, post.comments_count]
    end
  end
end


### OUTER JOINs ###

# The default for joins is to perform an INNER JOIN. In the previous example 
# we will not return any posts with zero comments because there will be no 
# comment row to join the post against.

# If we want to include posts with zero comments, we need to do an outer join. 
# We can do this like so:

#In Rails 5+
posts_with_counts = self
  .posts
  .select('posts.*, COUNT(comments.id) AS comments_count')
  .left_outer_joins(:comments) #still the name of the association
  .group('posts.id') # "comments.post_id" would be equivalent



#Before Rails 5 (just for old time's sake)
posts_with_counts = self
  .posts
  .select('posts.*, COUNT(comments.id) AS comments_count') # more in a sec
  .joins('LEFT OUTER JOIN comments ON posts.id = comments.post_id') # raw sql, so comments here is the name of the table
  .group('posts.id') # "comments.post_id" would be equivalent

### References ###

# http://blog.arkency.com/2013/12/rails4-preloading/
# http://stackoverflow.com/questions/97197/what-is-the-n1-selects-problem
# http://stackoverflow.com/questions/6246826/how-do-i-avoid-multiple-queries-with-include-in-rails
# http://blog.bigbinary.com/2013/07/01/preload-vs-eager-load-vs-joins-vs-includes.html