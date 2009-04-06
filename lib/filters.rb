module ActsAsFilterable
  
  module ActiveRecordExt
    
    module Filters 
      extend self
    
      # flyweight (GoF) of all the filters that can be applied
      def all
        {
          :numeric => lambda { |field| field.gsub!(/[^0-9\.]/, "") },
          :phone => lambda { |field| field.gsub!(/[^0-9]/, "") }
        }
      end
    end
    
  end
  
end