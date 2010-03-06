require "test_helper"

describe ActsAsFilterable::ActiveRecordExt::Base do
  before do
    @model = ContactDetail.new do |cd|
      cd.name = "joe smith"
      cd.phone_number = "2223334444"
      cd.discount = 0.25
    end
  end

  it "should add an #apply_filters instance method" do
    @model.send(:apply_filters).wont_equal(nil)
  end

  it "should know about the types of filters that will be applied to the attributes" do
    ContactDetail.must_respond_to(:filtered_attributes)
  end

  it "should add a macro to filter non-numeric values from string fields" do
    ContactDetail.must_respond_to(:filter_for_digits)
  end

  it "should add a macro to filter values to lowercase from string fields" do
    ContactDetail.must_respond_to(:filter_for_lowercase)
  end

  it "should be savable with valid data" do
    @model.save.must_equal(true)
  end

  it "should strip all formatting" do
    @model.phone_number = "(222) 333-4444"
    @model.valid?
    @model.phone_number.must_equal("2223334444")
  end

  it "should return a coercable numeric value" do
    @model.phone_number = "(222) 333-4444"
    @model.valid?
    @model.phone_number.to_i.must_equal(2223334444)
  end

  it "should not raise any errors due to a nil attribute value" do
    @model.phone_number = nil
    @model.valid?.must_equal(true)
  end

  it "should not attempt to change the attribute value" do
    @model.phone_number = nil
    @model.valid?
    @model.phone_number.must_equal(nil)
  end

  it "should not raise formatting errors" do
    ContactDetail.filter_for_digits :discount
    @model.valid?.must_equal(true)
  end

  it "should not attempt to change the attribute value" do
    ContactDetail.filter_for_digits :discount
    @model.valid?
    @model.discount.must_equal(0.25)
  end

  it "should not change the attribute value" do
    @model.phone_number = "2223334444"
    @model.valid?
    @model.phone_number.must_equal("2223334444")
  end

  it "should hold seperate collections of filtered_attributes" do
    User.filtered_attributes.wont_be_same_as ContactDetail.filtered_attributes
  end

  it "should not add attributes to other models errantly" do
    ContactDetail.filtered_attributes[:digits].flatten.wont_include([:handle].flatten)
  end

end
