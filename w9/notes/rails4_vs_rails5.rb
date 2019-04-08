### Models ###

## ApplicationRecord ##

# In Rails 5, we have an application_record.rb in our models/ folder containing 
# an intermediary class called ApplicationRecord, which inherits from 
# ActiveRecord::Base. In Rails 4, each of our models directly inherited from 
# ActiveRecord::Base.

# In Rails 5, we would declare a model like this:

class Cat < ApplicationRecord
end

# Whereas in Rails 4, we would inherit from ActiveRecord directly:

class Cat < ActiveRecord::Base
#...
end

# This change accomplishes two things:

# - It follows the naming pattern set up by ApplicationController.
# - It prevents us from having to monkey-patch ActiveRecord::Base itself.

# You can read more on this here.
# http://blog.bigbinary.com/2015/12/28/application-record-in-rails-5.html

## Validation of belongs_to associations ##

# It's very common for belongs_to associations to be required. In Rails 4, this 
# meant adding a separate validation on the presence of the association. Rails 5, 
# however, automatically validates these associations for us.

## Allowing for optional belongs_to associations ##

# To make belongs_to associations optional, we need to add optional: true to 
# the association's options hash.

# In the following example, the presence of a home is automatically being 
# validated:

class Cat < ApplicationRecord
  belongs_to :home,
    primary_key: :id,
    foreign_key: :home_id,
    class_name: :Home
end

# If we specifically wanted to allow for the home association to be optional, 
# we'd have to do the following:

class Cat < ApplicationRecord
  belongs_to :home,
    primary_key: :id,
    foreign_key: :home_id,
    class_name: :Home,
    optional: true 
end

## Double Errors on belongs_to Associations ##

# Because Rails now automatically validates belongs_to associations, we don't 
# want to explicitly add the validations ourselves. We don't want to do so 
# because this puts us in a position where there will actually be two errors 
# for the lack of a single association. Take the following example:

class Cat < ApplicationRecord
  validates :home, presence: true

  belongs_to :home,
    primary_key: :id,
    foreign_key: :home_id,
    class_name: :Home
end

# If we try to save an invalid cat, we'll get the following errors:

irb(main):001:0> c = Cat.new(name: 'Callie')
=> #<Cat id: nil, name: "Callie", home_id: nil, created_at: nil, updated_at: nil>
irb(main):002:0> c.save!
   (0.1ms)  begin transaction
   (0.1ms)  rollback transaction
ActiveRecord::RecordInvalid: Validation failed: Home cant be blank, Home must exist

# Notice the Home can't be blank and the Home must exist. That's problematic 
# when users see these errors.

# However, if we remove the superfluous validate :home, presence: true:

class Cat < ApplicationRecord
  belongs_to :home,
    primary_key: :id,
    foreign_key: :home_id,
    class_name: :Home
end

# We get the correct, single error:

irb(main):001:0> c = Cat.new(name: 'Callie')
=> #<Cat id: nil, name: "Callie", home_id: nil, created_at: nil, updated_at: nil>
irb(main):002:0> c.save!
   (0.2ms)  begin transaction
   (0.1ms)  rollback transaction
ActiveRecord::RecordInvalid: Validation failed: Home must exist

## through Association Ordering ##

# If you have a through association defined before the association that it goes 
# through, you'll need to switch the ordering. For example, if I were to have 
# this:

class Cat < ApplicationRecord
  has_many :friends,
    through: :owner,
    source: :friends

  belongs_to :owner,
    class_name: :User
end

# I'll get a warning about placing the :friends association before the :owner. 
# I should instead order my associations like this:

class Cat < ApplicationRecord
  belongs_to :owner,
    class_name: :User

  has_many :friends,
    through: :owner,
    source: :friends
end

### Controllers and Views ###

## head :no_content Errors Replace MissingTemplate Errors in Rails 5 ##

# In Rails 4, forgetting to add a Rails view for a controller action would 
# raise a MissingTemplate error. Rails 5 just returns a head :no_content 
# instead. (If you don't know what head :no_content is, please read this.)

## render :text is Deprecated in Rails 5 ##

# Use render :plain instead. render :text will not work.

### Other Changes ###

## rails Replaces rake ##

# Instead of rake db:somecommand, you can now do rails db:somecommand.

# Note that using rake still works, but using rails standardizes Rails commands 
# in the terminal.

## Migrations ##

# Previously, migrations inherited from ActiveRecord::Migration. In Rails 5, 
# migrations are versioned. If your project is using Rails 5.1, migrations you 
# generate will inherit from ActiveRecord::Migration[5.1].

# Whenever Rails 5 runs migrations, it checks the class of the current migration 
# file being run. If it’s 5.0+, it uses the new migration API which has changes 
# like automatically adding null: false to timestamps. You can read more here.
# http://blog.bigbinary.com/2016/03/01/migrations-are-versioned-in-rails-5.html

## Gems for Testing ##

# shoulda-matchers
# Previously, the shoulda-matchers gem required a specific branch to be 
# compatible with Rails 5. As of version 3.1.1, shoulda-matchers master branch 
# is now compatible!

# rails-controller-testing
# In Rails 4.x, we can test instance variables assigned in a controller#action 
# and which template a particular controller#action renders using assigns and 
# assert_template methods.

# Rails 4.x
class ProductsControllerTest < ActionController::TestCase
  def test_index_template_rendered
    get :index
    assert_template :index
    assert_equal Product.all, assigns(:products)
  end
end

# In Rails 5.x, these two methods have now been removed from the core and moved 
# to a separate gem rails-controller-testing. You must add this gem if you plan 
# on using those two methods.

### Newly Included Technologies ###

# Rails 5 comes with several new technologies – ActionCable, ActiveJob, and 
# api_mode to name a few – but this document focuses on aspects of Rails that 
# we teach that have changed behaviors. If you'd like a complete list of 
# differences between Rails 5.1.2 and any earlier version of Rails, feel free 
# to peruse the changelogs.
# http://weblog.rubyonrails.org/releases/