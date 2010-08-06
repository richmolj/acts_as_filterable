require 'rubygems'
require "minitest/spec"
require "active_record"

begin
  require 'redgreen'
rescue LoadError
end

require "acts_as_filterable"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :contact_details, :force => true do |t|
    t.string :name
    t.string :phone_number
    t.string :fax_number
    t.float :discount
  end

  create_table :users, :force => true do |t|
    t.string :handle
    t.string :phone_number
  end
end

ActsAsFilterable.configure do |config|
  config.add_filter :bad_colleges do |value|
    "bowdoin college sucks"
  end

  config.add_filter :stars do |value|
    "#{value}**"
  end
end

class ContactDetail < ActiveRecord::Base
  include ActsAsFilterable

  filter_for_digits :phone_number, :fax_number
end

class User < ActiveRecord::Base
  include ActsAsFilterable

  filter_for_digits :phone_number
  filter_for_lowercase :handle
end

class Foo
  include ActsAsFilterable

  attr_accessor :name

  filter_for_lowercase :name
  filter_for_whitespace :name
  filter_for_stars :name
end

MiniTest::Unit.autorun