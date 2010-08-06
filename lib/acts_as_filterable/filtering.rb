module ActsAsFilterable
  module Filtering
    class FilterNotFoundError < StandardError;end

    def apply_filter(filter_name, attributes)
      attributes.each do |attribute|
        if ancestors.include?(ActiveRecord::Base) and !instance_methods.include?("#{attribute}")
          apply_column_alias(filter_name, attribute)
        else
          apply_method_alias(filter_name, attribute)
        end
      end
    end

    def apply_column_alias(filter_name, attribute)
      class_eval <<-EOS, __FILE__, __LINE__ + 1
        def #{attribute}
          proc = ActsAsFilterable::Configuration.filters[:#{filter_name}]
          proc.call read_attribute(:#{attribute})
        end

        def #{attribute}=(val)
          proc = ActsAsFilterable::Configuration.filters[:#{filter_name}]
          write_attribute(:#{attribute}, proc.call(val))
        end
      EOS
    end

    def apply_method_alias(filter_name, attribute)
      raise FilterNotFoundError,
        "Filter #{filter_name} does not exist!" if ActsAsFilterable::Configuration.filters[filter_name].nil?

      class_eval <<-EOS, __FILE__, __LINE__ + 1
        def #{attribute}_with_#{filter_name}_filter
          proc = ActsAsFilterable::Configuration.filters[:#{filter_name}]
          proc.call #{attribute}_without_#{filter_name}_filter
        end
        alias_method_chain :#{attribute}, :#{filter_name}_filter
      EOS
    end

    def method_missing(id, *args, &blk)
      if id.to_s =~ /^#{matcher = "filter_for_"}/
        apply_filter id.to_s.gsub(matcher, ''), [args.shift].flatten
      else
        super
      end
    end

  end
end