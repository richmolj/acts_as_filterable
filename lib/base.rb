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
          @to_be_filtered ||= Hash.new []
        end
        
        def filter_for_numerics(*args)
          unless args.empty?
            to_be_filtered[:numbers] |= args
          end
        end
        
        def filters
          @filters ||= begin
            filter = Hash.new []
            filter[:numbers] = /[^0-9]*/
            filter
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