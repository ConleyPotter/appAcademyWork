require_relative '02_searchable'
require 'active_support/inflector'
require "byebug"
# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    "#{self.class_name.downcase}s"
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] || "#{name}_id".to_sym
    @class_name = options[:class_name] || name.to_s.singularize.camelcase
    @primary_key = options[:primary_key] || :id
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] || "#{self_class_name.downcase}_id".to_sym
    @class_name = options[:class_name] || name.to_s.singularize.camelcase
    @primary_key = options[:primary_key] || :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    assoc_options
    @assoc_options[name] = options
    define_method(name) do
      class_name = options.model_class
      foreign_key_value = self.send(options.foreign_key)
      class_name.where(options.primary_key => foreign_key_value).first
    end
  end
  
  def has_many(name, options = {})
  options = HasManyOptions.new(name, self.to_s, options)
    define_method(name) do
      class_name = options.model_class
      primary_key_value = self.send(options.primary_key)
      class_name.where(options.foreign_key => primary_key_value)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
