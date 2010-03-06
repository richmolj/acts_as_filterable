require "test_helper"

def assert_identity_after_filter(filter, value)
  identity = value.object_id
  filter.call(value)
  identity.must_equal value.object_id
end

describe ActsAsFilterable::Filters do
  before do
    @filter = ActsAsFilterable::Filters[:digits]
  end

  it "should default filters that don't exist to an empty array" do
    ActsAsFilterable::Filters[:test].empty?.must_equal(true)
  end

  it "should contain some filters initially" do
    ActsAsFilterable::Filters[:numeric].nil?.wont_equal(true)
    ActsAsFilterable::Filters[:lowercase].nil?.wont_equal(true)
  end

  it "should freeze the macro collection so it cannot be mutated" do
    proc { ActsAsFilterable::Filters.store(:test, /./) }.must_raise TypeError, RuntimeError
  end

  it "should strip any non-digit values from the string" do
    value = "45tr.,2"
    ActsAsFilterable::Filters[:digits].call(value)
    value.must_equal("452")
  end

  it "should not lose digit values" do
    value = "432099132"
    ActsAsFilterable::Filters[:digits].call(value)
    value.must_equal("432099132")
  end

  it "should return a coercable numerica value" do
    value = "4"
    ActsAsFilterable::Filters[:digits].call(value)
    value.to_i.must_equal(4)
  end

  it "should not create extra string objects when replacing values" do
    assert_identity_after_filter ActsAsFilterable::Filters[:digits], "54tr"
  end

  it "should not create extra string objects when no values are to be replaced" do
    assert_identity_after_filter ActsAsFilterable::Filters[:digits], "54"
  end

  it "should lowercase all alpha values" do
    value = "FAIl STRING"
    ActsAsFilterable::Filters[:lowercase].call(value)
    value.must_equal("fail string")
  end

  it "should not create extra string objects when replacing values" do
    assert_identity_after_filter ActsAsFilterable::Filters[:lowercase], "TRANSLATE"
  end

  it "should not create extra string objects when no values are to be replaced" do
    assert_identity_after_filter ActsAsFilterable::Filters[:lowercase], "43"
  end

  it "should uppercase all alpha values" do
    value = "lowercase string"
    ActsAsFilterable::Filters[:uppercase].call(value)
    value.must_equal("LOWERCASE STRING")
  end

  it "should not create extra string objects when replacing values" do
    assert_identity_after_filter ActsAsFilterable::Filters[:uppercase], "translate"
  end

  it "should not create extra string objects when no values are to be replaced" do
    assert_identity_after_filter ActsAsFilterable::Filters[:uppercase], "43"
  end

  it "should replace all un-neccessary whitespace" do
    value = "\t hai!    this is neat\n\nok?  \t"
    ActsAsFilterable::Filters[:whitespace].call(value)
    value.must_equal("hai! this is neat ok?")
  end

  it "should trim the ends of the string" do
    value = " this "
    ActsAsFilterable::Filters[:whitespace].call(value)
    value.must_equal("this")
  end

  it "should not create extra string objects when replacing values" do
    assert_identity_after_filter ActsAsFilterable::Filters[:whitespace], "TRANSLATE"
  end

  it "should not create extra string objects when no values are to be replaced" do
    assert_identity_after_filter ActsAsFilterable::Filters[:whitespace], "43"
  end

end
