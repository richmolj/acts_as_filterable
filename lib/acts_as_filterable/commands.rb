module ActsAsFilterable
  
  module ActiveRecordExt
    
    module Commands
      autoload :Command, "acts_as_filterable/commands/command"
      autoload :Digits, "acts_as_filterable/commands/digits"    
      autoload :Lowercase, "acts_as_filterable/commands/lowercase"    
    end
  
  end
  
end
