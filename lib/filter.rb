
# A command that represents a filter that can be applied to a field
# encapsulates the actual filter action.
class Filter
  
  # Recieves the field value and returns 
  # the filtered or transformed value
  def execute(field); end
  
end