module ActsAsFilterable
  
  module ActiveRecordExt
    
    module Commands
    
      class Digits < Command
      
        def execute(value)
          value.gsub! /[^\d]*/, ""
        end
        
      end
    end
  
  end
  
end