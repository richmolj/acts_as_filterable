require "test_helper"

def assert_identity_after_filter(filter, value)
  identity = value.object_id
  filter.call(value)
  identity.must_equal value.object_id
end

describe ActsAsFilterable::Configuration do
  before do
    @config = ActsAsFilterable::Configuration
    @filter = @config.filters[:digits]
  end

  it "should contain some filters initially" do
    @config.filters[:digits].nil?.wont_equal(true)
    @config.filters[:lowercase].nil?.wont_equal(true)
  end

  it "should strip any non-digit values from the string" do
    value = "45tr.,2"
    @filter.call(value).must_equal("452")
  end

  it "should not lose digit values" do
    value = "432099132"
    value = @filter.call(value)
    value.must_equal("432099132")
  end

  it "should return a coercable numerica value" do
    value = "4"
    value = @filter.call(value)
    value.to_i.must_equal(4)
  end

  it "should not create extra string objects when replacing values" do
    assert_identity_after_filter @filter, "54tr"
  end

  it "should not create extra string objects when no values are to be replaced" do
    assert_identity_after_filter @filter, "54"
  end

  it "should lowercase all alpha values" do
    value = "FAIl STRING"
    @config.filters[:lowercase].call(value)
    value.must_equal("fail string")
  end

  it "should not create extra string objects when replacing values" do
    assert_identity_after_filter @config.filters[:lowercase], "TRANSLATE"
  end

  it "should not create extra string objects when no values are to be replaced" do
    assert_identity_after_filter @config.filters[:lowercase], "43"
  end

  it "should uppercase all alpha values" do
    value = "lowercase string"
    @config.filters[:uppercase].call(value)
    value.must_equal("LOWERCASE STRING")
  end

  it "should not create extra string objects when replacing values" do
    assert_identity_after_filter @config.filters[:uppercase], "translate"
  end

  it "should not create extra string objects when no values are to be replaced" do
    assert_identity_after_filter @config.filters[:uppercase], "43"
  end

  it "should replace all un-neccessary whitespace" do
    value = "\t hai!    this is neat\n\nok?  \t"
    @config.filters[:whitespace].call(value)
    value.must_equal("hai! this is neat ok?")
  end

  it "should trim the ends of the string" do
    value = " this "
    @config.filters[:whitespace].call(value)
    value.must_equal("this")
  end

  it "should not create extra string objects when replacing values" do
    assert_identity_after_filter @config.filters[:whitespace], "TRANSLATE"
  end

  it "should not create extra string objects when no values are to be replaced" do
    assert_identity_after_filter @config.filters[:whitespace], "43"
  end

  it "should respond to custom user-defined filters" do
    value = "foo"
    value = @config.filters[:bad_colleges].call(value)
    value.must_equal("bowdoin college sucks")
  end

end