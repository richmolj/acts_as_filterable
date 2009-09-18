module ActsAsFilterable
  
  module ActiveRecordExt
    
    module Commands
    
      class Lowercase < Command
      
        def execute(value)
          value.downcase
        end
        
      end
    end
  
  end
  
end