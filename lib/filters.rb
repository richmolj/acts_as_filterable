require "filter"

module ActsAsFilterable
  
  module ActiveRecordExt
    
    # TODO: this sucks. make it not suck
    class Filters 
      
      class << self
      
        def all 
          @filters ||= {
           :numeric => Filter.new(:numeric, proc { |field| field.gsub!(/[^0-9\.]/, "") }),
           :phone => Filter.new(:phone, proc { |field| field.gsub!(/[^0-9]/, "") })
          }
        end

        def append(type, &action)
          raise unless action.arity == 1
          all[type.to_sym] = Filter.new(type.to_sym, action)
        end

      end
          
    end
    
  end
  
end
