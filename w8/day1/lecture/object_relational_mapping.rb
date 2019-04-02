require 'sqlite3'
require 'singleton'

# [[1, 'All My Sons', 1947, 1]...]

# this code isn't super useful to us yet
# what if this came back as an instance of a play object instead?

### ORM ###

# the interface for interacting with a play "object" in the sqlite db

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end


class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    # heredoc below
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO 
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)   -- if we know we are the only one using this method, we
                    -- will just make sure we always insert data in the same
                    -- order
    SQL

    # SQL inject attacks
    # playwright_id == "3; DROP TABLE plays" 
    # a very common type of internet attack to watch out for
    # the question marks will escape out of malicious chars like ';'
    # this is called sanitizing our data

    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    # heredoc below
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end