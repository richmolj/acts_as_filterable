module ActsAsFilterable
  module ActiveRecordExt 
    autoload :Base, "acts_as_filterable/base"
    autoload :Commands, "acts_as_filterable/commands"   
  end
end

ActiveRecord::Base.send :include, ActsAsFilterable::ActiveRecordExt::Base