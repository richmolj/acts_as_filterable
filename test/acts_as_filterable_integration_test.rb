require "test_helper"

class ActsAsFilterableIntegrationTest < Test::Unit::TestCase

  context "An ActiveRecord model using acts_as_filterable" do
    setup do
      @model = ContactDetail.new do |cd|
        cd.first_name = "rob"
        cd.last_name = "ares"
        cd.phone_number = "2223334444"
        cd.fax_number = "2223334444"
        cd.email_address = "someone@example.com"
      end
    end

    should "be savable with valid data" do
      @model.save.should be(true)
    end
    
    should "fail validation when " do
      
    end
    
  end

end
