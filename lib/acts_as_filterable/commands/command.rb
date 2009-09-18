module ActsAsFilterable
  
  module ActiveRecordExt
    
    module Commands
    
      class Command
      
        def apply(record, attr)
          record[attr] = execute record[attr]
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