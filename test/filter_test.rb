require "test_helper"

class FilterTest < Test::Unit::TestCase

  def assert_identity_after_filter(filter, value)
    identity = value.object_id
    filter.call(value)
    identity.should == value.object_id
  end

  context "When applying the" do
    
    context "digit filter, it" do
      setup do
        @filter = ActsAsFilterable::Filters[:digits]
      end
      
      should "strip any non-digit values from the string" do
        value = "45tr.,2"
        @filter.call(value)
        value.should be("452")
      end
      
      should "not lose digit values" do
        value = "432099132"
        @filter.call(value)
        value.should be("432099132")
      end
      
      should "return a coercable numerica value" do
        value = "4"
        @filter.call(value)
        value.to_i.should be(4)
      end
      
      should "not create extra string objects when replacing values" do
        assert_identity_after_filter @filter, "54tr"
      end
    
      should "not create extra string objects when no values are to be replaced" do
        assert_identity_after_filter @filter, "54"
      end
    
    end
    
    context "lowercase filter, it" do
      setup do
        @filter = ActsAsFilterable::Filters[:lowercase]
      end

      should "lowercase all alpha values" do
        value = "FAIl STRING"
        @filter.call(value)
        value.should be("fail string")
      end
      
      should "not create extra string objects when replacing values" do
        assert_identity_after_filter @filter, "TRANSLATE"
      end
    
      should "not create extra string objects when no values are to be replaced" do
        assert_identity_after_filter @filter, "43"
      end
    end

    context "uppercase filter, it" do
      setup do
        @filter = ActsAsFilterable::Filters[:uppercase]
      end

      should "uppercase all alpha values" do
        value = "lowercase string"
        @filter.call(value)
        value.should be("LOWERCASE STRING")
      end
      
      should "not create extra string objects when replacing values" do
        assert_identity_after_filter @filter, "translate"
      end
    
      should "not create extra string objects when no values are to be replaced" do
        assert_identity_after_filter @filter, "43"
      end
    end

    context "whitesapce filter, it" do
      setup do
        @filter = ActsAsFilterable::Filters[:whitespace]
      end

      should "replace all un-neccessary whitespace" do
        value = "\t hai!    this is neat\n\nok?  \t"
        @filter.call(value)
        value.should be("hai! this is neat ok?")
      end
      
      should "trim the ends of the string" do
        value = " this "
        @filter.call(value)
        value.should be("this")
      end
      
      should "not create extra string objects when replacing values" do
        assert_identity_after_filter @filter, "TRANSLATE"
      end
    
      should "not create extra string objects when no values are to be replaced" do
        assert_identity_after_filter @filter, "43"
      end
    end

  end

end
