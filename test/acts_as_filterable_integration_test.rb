require "test_helper"

# ActiveRecord
describe ActsAsFilterable do
  before do
    @model = ContactDetail.new do |cd|
      cd.name = "joe smith"
      cd.phone_number = "2223334444"
      cd.discount = 0.25
    end
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

  it "should not change the attribute value" do
    @model.phone_number = "2223334444"
    @model.valid?
    @model.phone_number.must_equal("2223334444")
  end

end

# Random class
describe ActsAsFilterable do
  before do
    @class = Foo.new
  end

  it "should apply all filters on assignment" do
    @class.name = ' john Hall  '
    @class.name.must_equal 'john hall**'
  end
end