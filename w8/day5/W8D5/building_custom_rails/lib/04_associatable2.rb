require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    define_singleton_method(:through_options) do
      self.assoc_options[through_name] 
    end

    define_singleton_method(:source_options) do
      self.assoc_options[through_name].model_class.assoc_options[source_name]
    end

    through_options = self.through_options
    source_options = self.source_options
    debugger
    
    DBConnection.instance.execute(<<-SQL)
      SELECT
        #{source_options.table_name}.*
      FROM
        #{through_options.table_name}
      JOIN
        #{source_options.table_name} ON #{through_options.table_name}.#{source_options.foreign_key} = #{source_options.table_name}.#{source_options.primary_key}
      WHERE
        #{through_options.table_name}.id = ?;
    SQL
  end
end


# SELECT
#   houses.*
# FROM
#   humans
# JOIN
#   houses ON humans.house_id = houses.id
# WHERE
#   humans.id = ?

# SELECT
#   houses.*
# FROM
#   houses
# JOIN
#   houses ON houses.id = humans.house_id 
# JOIN
#   cats ON cats.owner_id = humans.id
# WHERE
#   cats.id = ?;