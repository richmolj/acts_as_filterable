module ActsAsFilterable
  
  Filters = returning Hash.new([]) do |f|
    f[:digits]     = lambda { |attr| attr.gsub!(/[^\d]*/, "") }
    f[:lowercase]  = lambda { |attr| attr.downcase! }
    f[:uppercase]  = lambda { |attr| attr.upcase! }
    f[:whitespace] = lambda { |attr| attr.gsub!(/\s+/, " "); attr.strip! }
  end.freeze
  
  module ActiveRecordExt
    
    module Base
      
      # @private
      def self.included(klazz)
        klazz.extend ClassMethods
        klazz.before_validation :apply_filters
      end
      
      module ClassMethods
        
        # @private
        def self.extended(klazz)
          ActsAsFilterable::Filters.each_key do |key|
            klazz.class_eval <<-MACROS, __FILE__, __LINE__ + 1
              def self.filter_for_#{key}(*args)
                filtered_attributes[:#{key}] |= args unless args.empty?
              end
            MACROS
          end
        end
        
        # @private
        def filtered_attributes
          @filtered_attributes ||= Hash.new []
        end

      end
      
      protected
     
      def apply_filters
        self.class.filtered_attributes.each do |key, value|
          value.each do |attr|
            apply_filter self, attr, ActsAsFilterable::Filters[key]
          end
        end
      end
      
      private
      
      def apply_filter(record, attr, filter)
        filter.call(record[attr]) if record[attr].is_a?(String)
      end
            
    end
  
  end
  
end
