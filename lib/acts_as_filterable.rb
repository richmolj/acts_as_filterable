module ActsAsFilterable
  module ActiveRecordExt 
    autoload :Base, "acts_as_filterable/base"
  end
end

ActiveRecord::Base.send :include, ActsAsFilterable::ActiveRecordExt::Base