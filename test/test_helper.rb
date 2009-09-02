require "test/unit"
require "activerecord"
require "shoulda"
require "matchy"

gem "sqlite3-ruby"

require "acts_as_filterable"

ActiveRecord::Base.logger = Logger.new("/tmp/acts_as_filterable.log")
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "/tmp/acts_as_filterable.sqlite")
ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :contact_details, :force => true do |t|
    t.string :name
    t.string :phone_number
    t.string :fax_number
    t.float :discount
  end
end

class ContactDetail < ActiveRecord::Base
  filter_for_digits :phone_number, :fax_number
end

class Test::Unit::TestCase
end