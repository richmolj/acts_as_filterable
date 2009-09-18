module ActsAsFilterable
  
  module ActiveRecordExt
    
    module Commands
    
      class Command
      
        def apply(record, attr)
          if not record[attr].blank? and record[attr].is_a?(String)
            record[attr] = execute record[attr]
          end
        end
        
        private
        
        # command pattern
        def execute(value)
          value
        end
        
      end
      
    end
  
  end
  
end