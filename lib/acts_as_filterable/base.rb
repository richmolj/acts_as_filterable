module ActsAsFilterable
  
  module ActiveRecordExt
    
    module Base
      
      def self.included(klazz)
        klazz.extend ClassMethods
        klazz.before_validation :apply_filters
      end
      
      private 
      
      module ClassMethods
        
        def filter_for_digits(*args)
          filtered_attributes[:digits] |= args unless args.empty?
        end
        
        def filters
          @filters ||= returning(Hash.new([])) do |f|
            f[:digits] = /[^\d]*/
          end.freeze
        end
        
        def filtered_attributes
          @filtered_attributes ||= Hash.new []
        end
        
      end
      
      protected
      
      def apply_filters
        self.class.filtered_attributes.each do |key, value|
          value.each do |attr|
           apply_filter self.class.filters[key], attr
          end
        end
      end
      
      private
      
      def apply_filter(filter, attr)
        if not send(attr).blank? and send(attr).is_a?(String)
          send(attr).gsub!(filter, "")
        end
      end
            
    end
  
  end
  
end
