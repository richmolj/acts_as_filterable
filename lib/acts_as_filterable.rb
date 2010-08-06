require File.dirname(__FILE__) + '/acts_as_filterable/configuration'
require File.dirname(__FILE__) + '/acts_as_filterable/filtering'

module ActsAsFilterable

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def included(klass)
      klass.send(:class_inheritable_accessor, :filters)
      klass.filters = Configuration.filters
      klass.extend Filtering
    end
  end

end