### Sending Customized JSON responses with JBuilder ###

# Jbuilder is a tool we will use to customize the JSON responses we send back 
# from our rails server.

# When we make a request for data in our Rails controllers, by default, we get 
# all attributes back from the database. We've been using this default behavior 
# so far by writing things like render json: @users at the end of our controller 
# actions. This has some unfortunate side effects—for one, we'll send down 
# everything, including potentially sensitive information, to the client. 
# Consider the following example:

# users schema:
# schema.rb

create_table "users", force: :cascade do |t|
  t.string "username", null: false
  t.string "password_digest", null: false
  t.string "session_token", null: false
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.index ["session_token"], name: "index_users_on_session_token", unique: true
  t.index ["username"], name: "index_users_on_username", unique: true
end

# Api::UsersController
def show
  @user = User.find(params[:id])
  render json: @user
end

# By default, if we send the @user as a JSON response, we'll end up with 
# something like this:

{
  "id": 1
  "username": "howardmohr93",
  "password_digest": "$2a$10$qFkvLzrkjk/Hw3fAPAd6..3OXaCUnQMKQR4xIKb/ypsGx/eRJrwV2",
  "session_token": "RMZ7Ox8xnHQbLid6FRMKBg",
  "created_at": "2019-02-20 12:20:29 -0800",
  "updated_at": "2019-02-20 12:20:29 -0800"
}

# This is bad. Not only are we sending information that the client doesn't need 
# to know, we're also sending the password_digest and session_token, which is 
# a potential security vulnerability. Maybe we could try something like this:

# Api::UsersController

def show
  @user = User.find(params[:id])
  response = {}
  response[:id] = @user.id
  response[:username] = @user.username
  
  render json: response
end

# We construct a hash that contains only the data we want to send, and render 
# it as JSON. Not terrible, but suppose we also want to fetch a list of 
# comments associated with this user?

# Api::UsersController

def show
   @user = User.find(params[:id])
   response = {}
   response[:id] = @user.id
   response[:username] = @user.username
   response[:comments] = {}
   @user.comments.each do |comment|
       comment_response = {}
       comment_response[:id] = comment.id
       comment_response[:author_id] = comment.author_id
       comment_response[:body] = comment.body
       comment_response[:created_at] = comment.created_at
       response[:comments][comment.id] = comment_response
   end

   render json: response
end

# This might work, but we're stuffing a lot of logic into our controller. As 
# the responses we send become more complicated, things will get pretty messy.

# We can do better. Enter Jbuilder.

# With Jbuilder, rails allows us to use our views folder to create JSON 
# templates for our responses. Rather than building HTML views, we can instead 
# create JSON "views" using Jbuilder and ruby code.

# When making a Jbuilder template, you'll simply place a file with the 
# extension .json.jbuilder. where you've previously been putting your ERB 
# files. The same way that ERB is compiled to an HTML template, Jbuilder 
# templates will be compiled by Rails and you'll be left with JSON.

# Using a Jbuilder view, the above monstrosity can be written simply as:

# Api::UsersController

def show
    @user = User.find(params[:id])
    render :show
end

# /app/views/api/users/show.json.jbuilder
json.extract! @user, :id, :username
json.comments do
    @user.comments.each do |comment|
        json.set! comment.id do
            json.extract! comment, :id, :author_id, :body, :created_at
        end
    end
end

# Using the above view, the JSON response will look like this:

{
    "id": 1
    "username": "howardmohr93",
    "comments": {
        "1": {
            "id": "1",
            "author_id": "1",
            "body": "Can't complain",
            "created_at": "2019-02-20 13:33:06 -0800"
        },
        "2": {
            "id": "2",
            "author_id": "1",
            "body": "Not too bad, pass the butter please",
            "created_at": "2019-02-20 13:35:58 -0800"
        },
        "3": {
            "id": "3",
            "author_id": "1",
            "body": "You might as well have another sandwich and watch Johnny Carson",
            "created_at": "2019-02-20 13:38:36 -0800"
        }
    }
}

# Not too bad. Since rails evaluates Jbuilder views similarly to how it handles 
# HTML templates, we can access instance variables (like @user) defined in 
# the controller that renders the view, as well as any of their associations. 
# Jbuilder views can use regular ruby code, but also use special methods 
# defined by Jbuilder. The Jbuilder docs have detailed information about each 
# of these methods, but we'll cover a few of the most common ones here:

### Some Common JBuilder Methods ###

## json.<some_key> ##
# To specify a key in the response, we can use the syntax: json.some_key 
# some_value. The value can either be any valid data type, or a block that 
# defines a nested scope.

# jbuilder:
json.username "Bob"

# response:
{ "username": "Bob" }


# jbuilder:
json.title "The first post"
json.author do
    json.username "Bob"
end

# response:
{
    "title": "The first post",
    "author": {
        "username": "Bob"
    }
}

## json.extract! ##
# json.extract! lets us extract attributes from an instance directly:

#  jbuilder:
json.extract! @user, :fullname, :company, :email

# response:
{
    "fullname": "Howard Mohr",
    "company": "Minnesota, inc.",
    "email": "cantcomplain@pbs.org"
}

## json.set! ##
# We can use json.set! to set keys that we need to first evaluate as variables:

# jbuilder: 
json.set! @user.id do
    json.extract! @user, :fullname, :company, :email
end

# response:
{
    1: {
        "fullname": "Howard Mohr",
        "company": "Minnesota, inc.",
        "email": "cantcomplain@pbs.org"
    }
}

### Configuring rails to look for JBuilder views ###

# You also want to set the default format of resources (in the config/routes.rb 
# file) to :json. Then Rails will automatically look for a .json file when 
# you pass a template name to #render (render :index for example).

# routes.rb

Rails.application.routes.draw do
+  namespace :api, defaults: { format: :json } do
-  namespace :api do
    resources :pokemon, only: [:index, :show, :create, :destroy]
  end
end

# As shown in the directory structure below, you can also use partials with 
# Jbuilder just as you have with ERB.

instagram_clone
  └─ app
      └─ ...
      └─ views
          └─ photos
              └─ index.json.jbuilder
              └─ show.json.jbuilder
              └─ _photo.json.jbuilder