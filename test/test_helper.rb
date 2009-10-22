require "test/unit"
require "activerecord"
require "shoulda"
require "matchy"

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
  
  create_table :user, :force => true do |t|
    t.string :handle
    t.string :phone_number
  end
end

class ContactDetail < ActiveRecord::Base
  filter_for_digits :phone_number, :fax_number
end

class User < ActiveRecord::Base
  filter_for_digits :phone_number
  filter_for_lowercase :handle
end

class Test::Unit::TestCase
end
