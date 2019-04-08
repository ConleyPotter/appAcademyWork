require_relative 'db_connection'
require_relative '01_sql_object'
require "byebug"

module Searchable
  def where(params)
    where_clause = params.keys.map { |key| "#{key} = ?"}.join(" AND ")
    where_values = params.values
    data = DBConnection.instance.execute(<<-SQL, *where_values)
      SELECT
        *
      FROM 
        #{self.table_name}
      WHERE
        #{where_clause}
    SQL

    array_of_hashes = []

    data.each_with_index do |hash, idx|
      hash_with_symbols = {}
      hash.each_key do |key|
        hash_with_symbols[key.to_sym] = data[idx][key]
      end
      array_of_hashes << hash_with_symbols
    end
    
    array_of_hashes.map { |hash| self.new(hash) }
  end
end

class SQLObject
  extend Searchable
end
