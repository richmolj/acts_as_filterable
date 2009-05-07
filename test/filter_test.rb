require "test_helper"

class FilterTest < Test::Unit::TestCase

  context "A Filter" do
    
    setup do
      @filter = ActsAsFilterable::ActiveRecordExt::Filter.new(:phone, proc { |model| true })
    end

    should "be creatable" do
      @filter.should_not be_nil
    end
  
    should "be able to invoke filters on a model field" do
      @filter.should be_respond_to(:process)
    end

  end

end
