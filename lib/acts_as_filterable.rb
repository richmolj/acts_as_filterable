module ActsAsFilterable
  
  module ActiveRecordExt
    
    autoload :Base, "base"  
  end
  
end

ActiveRecord::Base.send(:include, ActsAsFilterable::ActiveRecordExt::Base)