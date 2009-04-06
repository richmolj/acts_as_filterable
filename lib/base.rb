module ActsAsFilterable
  
  module ActiveRecordExt
    
    module Base
  
      def self.included(klazz)
        klazz.extend ClassMethods
        klazz.before_validation :apply_filters
      end
  
      private 
      
      module ClassMethods
        attr_reader :filtered_attributes  
        
        def filtered(*attributes)
          @filtered_attributes = attributes
        end
      end
      
      def apply_filters
        self.class.filtered_attributes.each do |attr|
          send(attr.to_sym).gsub!(/[^0-9\.]/, "") if respond_to?(attr.to_sym)
        end
      end
  
    end
  
  end
  
end