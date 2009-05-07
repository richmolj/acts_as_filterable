require "test_helper"

class FiltersTest < Test::Unit::TestCase

  context "A Filter" do
    
    should "return default filters when calling all" do
      ActsAsFilterable::ActiveRecordExt::Filters.all.should be_instance_of(Hash)
    end
      
    should "allow new filters to be added at runtime" do
      ActsAsFilterable::ActiveRecordExt::Filters.append(:dumb) do |v| 
        v.gsub! /[0-9]/, "X"
      end
      ActsAsFilterable::ActiveRecordExt::Filters.all.should be_member(:dumb)
    end
      
    should "only allow procs to be added to the filter map" do
      lambda { ActsAsFilterable::ActiveRecordExt::Filters.append(:broke, "dsads") }.should raise_error
    end  
    
  end
  
end
