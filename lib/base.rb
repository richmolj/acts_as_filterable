module ActsAsFilterable
  
  module ActiveRecordExt
    
    module Base
      
      def self.included(klazz)
        klazz.extend ClassMethods
        klazz.before_validation :apply_filters
      end
  
      private 
      
      module ClassMethods
        def to_be_filtered
          @to_be_filtered ||= {}
        end
        
        def filter_for(*args)
          type = args.first
          return if type.nil? or not filters.member?(type)
          args.delete_at(0)
          to_be_filtered[type] = args unless args.empty?
        end
        
        def filters
          @filters ||= begin
            { :phone => /[^0-9]*/ }.freeze
          end
        end
        
      end
      
      def apply_filters
        self.class.to_be_filtered.each do |k, v|
          v.each do |attr|
            send(attr).gsub!(self.class.filters[k], "") unless send(attr).blank?
          end
        end
      end
            
    end
  
  end
  
end