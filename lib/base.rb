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
          to_be_filtered[:numbers] |= args unless args.empty?
        end
        
        def filters
          @filters ||= begin
            f = Hash.new []
            f[:numbers] = /[^0-9]*/i
            f
          end
        end
        
      end
      
      def apply_filters
        self.class.to_be_filtered.each do |key, value|
          value.each do |attr|
            send(attr).gsub!(self.class.filters[key], "") unless send(attr).blank?
          end
        end
      end
            
    end
  
  end
  
end