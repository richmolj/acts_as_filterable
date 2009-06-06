require "test_helper"

class ActsAsFilterableIntegrationTest < Test::Unit::TestCase

  context "An ActiveRecord model using acts_as_filterable" do
    setup do
      @model = ContactDetail.new do |cd|
        cd.name = "joe smith"
        cd.phone_number = "2223334444"
        cd.discount = "0.25"
      end
    end

    should "be savable with valid data" do
      @model.save.should be(true)
    end
    
    context "with formatted phone number data" do
      setup do
        @model.phone_number = "(222) 333-4444"
        @model.valid?
      end
    
      should "strip all formatting" do
        @model.phone_number.should be("2223334444")
      end
      
      should "return a coercable numeric value" do
        @model.phone_number.to_f.should be(2223334444)
      end
    
    end
    
  end

end
