require_relative 'db_connection'
require 'active_support/inflector'
require "byebug"
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @sql_data ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @sql_data[0].map(&:to_sym)
  end

  def self.finalize!

    column_names = columns
    column_names.each do |column_name|
      
      define_method("#{column_name}") { self.attributes["#{column_name}".to_sym] }

      define_method("#{column_name}=") do |new_column_value| 
        self.attributes["#{column_name}".to_sym] = new_column_value
      end

    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.downcase.pluralize
  end

  def self.all
    data = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name};
    SQL
    self.parse_all(data)
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    data = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM  
        #{self.table_name}
      WHERE
        id = ?;
    SQL
    return nil if data.empty?
    hash_with_symbols = {}
    data.first.each_key do |key|
      hash_with_symbols[key.to_sym] = data.first[key]
    end
    self.new(hash_with_symbols)
  end

  def initialize(params = {})
    column_names = self.class.columns
    params.each_key do |key|
      key = key.to_sym
      raise "unknown attribute '#{key}'" unless column_names.include?(key)
      self.send("#{key}=", params[key])
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    column_names = self.class.columns
    column_names.map do |column_name|
      self.send(column_name)
    end
  end

  def insert
    attributes = attribute_values
    column_names = self.class.columns.map(&:to_s).join(", ")
    question_marks = Array.new(attributes.length) { "?" }
    DBConnection.execute(<<-SQL, *attributes)
      INSERT INTO
        #{self.class.table_name} (#{column_names})
      VALUES
        (#{question_marks.join(", ")})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    attributes = attribute_values
    column_names = self.class.columns.map { |el| "#{el} = ?"}.join(", ")
    data = DBConnection.execute(<<-SQL, *attributes, id)
    UPDATE
      #{self.class.table_name}
    SET
      #{column_names}
    WHERE
      id = ?
    SQL

  end

  def save
    attributes = attribute_values
    if attributes.first.nil?
      insert
    else
      update
    end
  end

end
