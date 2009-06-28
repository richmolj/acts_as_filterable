require "test_helper"

class ActsAsFilterableIntegrationTest < Test::Unit::TestCase

  context "An ActiveRecord model using acts_as_filterable" do
    setup do
      @model = ContactDetail.new do |cd|
        cd.name = "joe smith"
        cd.phone_number = "2223334444"
        cd.discount = 0.25
      end
    end

    should "add an #apply_filters instance method" do
      @model.send(:apply_filters).nil?.should_not be(true)
    end

    should "know about the types of filters that will be applied to the attributes" do
      ContactDetail.respond_to?(:to_be_filtered).should be(true)
    end
    
    should "make it's filters available" do
      ContactDetail.respond_to?(:filters).should be(true)
    end
    
    should "default filters that don't exist to an empty array" do
      ContactDetail.filters[:test].empty?.should be(true)
    end
    
    should "contain some filters initially" do
      ContactDetail.filters[:numeric].nil?.should_not be(true)
    end
    
    should "freeze the macro collection so it cannot be mutated" do
      ContactDetail.filters.store(:test, /./).should raise_error
    end
    
    should "add a macro to filter non-numeric values from string fields" do
      ContactDetail.respond_to?(:filter_for_numerics).should be(true)
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
    
    context "with a nill attribute value" do
      setup do
        @model.phone_number = nil
      end
      
      should "not raise any errors due to a nil attribute value" do
        lambda { @model.valid? }.should_not raise_error
      end
      
      should "not attempt to change the attribute value" do
        @model.valid?
        @model.phone_number.nil?.should be(true)
      end
    end
    
    context "with non-character attributes" do
      setup do
        ContactDetail.filter_for_numerics :discount
      end
      
      should "not raise any errors due to a non-character attribute value" do
        lambda { @model.valid? }.should_not raise_error
      end
      
      should "not attempt to change the attribute value" do
        @model.valid?
        @model.discount.should be(0.25)
      end
      
    end
    
    context "with an attribute value that contains no non-numeric values to be stripped" do
      setup do 
        @model.phone_number = "2223334444"
        @model.valid?
      end
      
      should "not change the attribute value" do
        @model.phone_number.should be("2223334444")
      end
    end
    
  end

end
