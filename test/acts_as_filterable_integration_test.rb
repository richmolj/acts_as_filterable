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

    should "add an #apply_filters instance method" do
      @model.send(:apply_filters).should_not be_nil
    end

    should "know about the types of filters that will be applied to the attributes" do
      ContactDetail.should be_respond_to(:to_be_filtered)
    end
    
    should "make it's filters available" do
      ContactDetail.should be_respond_to(:filters)
    end
    
    should "default filters that don't exist to an empty array" do
      ContactDetail.filters[:test].should be_empty
    end
    
    should "freeze the macro collection so it cannot be mutated" do
      ContactDetail.filters.store(:test, /./).should raise_error
    end
    
    should "add a macro to filter non-numeric values from string fields" do
      ContactDetail.should be_respond_to(:filter_for_numerics)
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
