require "filters"

module ActsAsFilterable
  
  module ActiveRecordExt
    
    module Base
      
      # when this module is added to ActiveRecord
      # we add the filterable macros and add a before_validation filter
      # that will apply each filter before validations are run.  
      def self.included(klazz)
        klazz.extend ClassMethods
        klazz.before_validation :apply_filters_before_validation
      end
  
      private 
      
      module ClassMethods    
        def processing_specifications
          @processing_specifications ||= {}
        end
        
        # TODO: the implicit block will be cached and sent on to create on 
        # the fly filters that allows the user to author their own filters.
        def filters(field_name, type)
          processing_specifications[field_name] = Filters.all[type] 
        end
      end
      
      def apply_filters_before_validation
        self.class.processing_specifications.each do |attr, filter|
          filter.call(send(attr.to_sym))
        end
      end
  
    end
  
  end
  
end