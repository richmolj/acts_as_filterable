require "test_helper"

class ActsAsFilterableIntegrationTest < Test::Unit::TestCase

  context "An ActiveRecord model using acts_as_filterable" do
    setup do
      @model = ContactDetail.new do |cd|
        cd.first_name = "rob"
        cd.last_name = "ares"
        cd.phone_number = "2223334444"
        cd.discount = "0.25"
        cd.email_address = "someone@example.com"
      end
    end

    should "be savable with valid data" do
      @model.save.should be(true)
    end
    
    context "with formatted phone number data" do
      setup do
        @model.phone_number = "(222) 333-4444"
      end
    
      should "strip all formatting and return a coercable numeric value" do
        @model.save.should be(true)
        @model.phone_number.should be("2223334444")
      end
    
    end
    
    context "with formatted numeric data" do
      setup do
        @model.discount = "(222) 333-4444"
      end

      should "description" do
        
      end
    end
    
    
  end

end
