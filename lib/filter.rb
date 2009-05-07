module ActsAsFilterable
  module ActiveRecordExt
  
    class Filter
      attr_reader :name, :action

      def initialize(name, action)
        @name = name
        @action = action
      end

      # run the filter on the model.
      def process(model, target)
        model.send("#{target.to_s}=", action.call(model.send(target.to_sym))) 
      end

    end

  end

end
