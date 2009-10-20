require "test_helper"

class FilterTest < Test::Unit::TestCase

  context "When applying the" do
    
    context "digit filter, it" do
      setup do
        @filter = User.filters[:digits]
      end
      
      should "strip any non-digit values from the string" do
        @filter.call("45tr.,2").should be("452")
      end
      
      should "not lose digit values" do
        @filter.call("432099132").should be("432099132")
      end
      
      should "return a coercable numerica value" do
        @filter.call("4").to_i.should be(4)
      end
      
      should "not create extra string objects when replacing values" do
        value = "54tr"
        @filter.call(value).should === value
      end
    
      should "not create extra string objects when no values are to be replaced" do
        value = "54"
        @filter.call(value).should === value
      end
    
    end
    
    context "lowercase filter, it" do
      setup do
        @filter = User.filters[:lowercase]
      end

      should "lowercase all alpha values" do
        @filter.call("FAIl STRING").should be("fail string")
      end
      
      should "not create extra string objects when replacing values" do
        value = "TRANSLATE"
        @filter.call(value).should === value
      end
    
      should "not create extra string objects when no values are to be replaced" do
        value = "43"
        @filter.call(value).should === value
      end
    end

    context "uppercase filter, it" do
      setup do
        @filter = User.filters[:uppercase]
      end

      should "uppercase all alpha values" do
        @filter.call("lowercase string").should be("LOWERCASE STRING")
      end
      
      should "not create extra string objects when replacing values" do
        value = "translate"
        @filter.call(value).should === value
      end
    
      should "not create extra string objects when no values are to be replaced" do
        value = "43"
        @filter.call(value).should === value
      end
    end

    context "whitesapce filter, it" do
      setup do
        @filter = User.filters[:whitespace]
      end

      should "replace all un-neccessary whitespace" do
        @filter.call("\t hai!    this is neat\n\nok?  \t").should be("hai! this is neat ok?")
      end
      
      should "trim the ends of the string" do
        @filter.call(" this ").should be("this")
      end
      
      should "not create extra string objects when replacing values" do
        value = "TRANSLATE"
        @filter.call(value).should === value
      end
    
      should "not create extra string objects when no values are to be replaced" do
        value = "43"
        @filter.call(value).should === value
      end
    end


  end

end
