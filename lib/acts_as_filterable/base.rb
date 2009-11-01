module ActsAsFilterable #:nodoc:

  # This flyweight represents all of the filters that we can run on attributes.
  # Each filter should modify the attribute value in place an not create new strings.
  # The following filters exist:
  # * digits     - strip any numeric characters out.
  # * lowercase  - make all character values lowercase.
  # * uppercase  - make all character values uppercase.
  # * whitespace - strip any non-important whitespace out of the value (tabs and newlines).
  Filters = returning Hash.new([]) do |f| 
    f[:digits]     = lambda { |attr| attr.gsub!(/[^\d]*/, "") }
    f[:lowercase]  = lambda { |attr| attr.downcase! }
    f[:uppercase]  = lambda { |attr| attr.upcase! }
    f[:whitespace] = lambda { |attr| attr.gsub!(/\s+/, " "); attr.strip! }
  end.freeze
  
  module ActiveRecordExt #:nodoc: 
    
    # Module that is mixed into the ActiveRecord::Base class
    # I know, I know, Base is a cop-out but it does serve a purpose for 
    # code organization in RE: to ActiveRecord. Also, fuck your ivory tower bullshit.
    module Base 
      
      # Hook that pulls the functionality into ActiveRecord.
      # Also adds #apply_filters as a before_validation filter
      def self.included(klazz)
        klazz.extend ClassMethods
        klazz.before_validation :apply_filters
      end
      
      module ClassMethods 
        
        # As the class methods are added in the included hook, the following
        # macros are created:
        #
        # * filter_for_digits     - Filter non-numeric values out.
        # * filter_for_uppercase  - Uppercase all alpha values.
        # * filter_for_lowercase  - Lowercase all alpha values.
        # * filter_for_whitespace - Filter any continuous sequence of whitespace greater than 1 to only 1 space. 
        def self.extended(klazz) 
          ActsAsFilterable::Filters.each_key do |key|
            klazz.class_eval <<-MACROS, __FILE__, __LINE__ + 1
              def self.filter_for_#{key}(*args)
                filtered_attributes[:#{key}] |= args unless args.empty?
              end
            MACROS
          end
        end
       
        # Hash that contains the attributes that are to be filtered according the
        # filter that should be applied to them. 
        def filtered_attributes
          @filtered_attributes ||= Hash.new []
        end

      end
      
      protected
     
      # Called in the before_validate hook in each model.
      # Filters are applied in the order that the appear in the class 
      # definition. 
      #
      # So if the following ruleset is defined:
      #   filter_for_whitespace :message
      #   filter_for_lowercase :message
      #
      # The whitespace filter will be invoked followed by the lowercase filter on before_validate
      def apply_filters
        self.class.filtered_attributes.each do |key, value|
          value.each do |attr|
            apply_filter self, attr, ActsAsFilterable::Filters[key]
          end
        end
      end
      
      private
      
      # Applies the filter in question to the attribute.
      # if the value is _not_ a String, then the filter call is ignored.
      def apply_filter(record, attr, filter)
        filter.call(record[attr]) if record[attr].is_a?(String)
      end
            
    end
  
  end
  
end
