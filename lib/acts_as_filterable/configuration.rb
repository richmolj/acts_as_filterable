module ActsAsFilterable
  class Configuration

    # Provides the following:
    #
    # * filter_for_digits - Filter non-numeric values out.
    # * filter_for_uppercase - Uppercase all alpha values.
    # * filter_for_lowercase - Lowercase all alpha values.
    # * filter_for_whitespace - Filter any continuous sequence of whitespace greater than 1 to only 1 space.
    def initialize
      super
      @@filters = Hash.new([]).tap do |f|
        f[:digits]     = digit_filter
        f[:lowercase]  = lowercase_filter
        f[:uppercase]  = uppercase_filter
        f[:whitespace] = whitespace_filter
      end
    end

    def self.filters
      @@filters
    end

    def add_filter(filter_name, &blk)
      raise "Must supply a block when adding a filter to ActsAsFilterable::Configuration" unless block_given?
      @@filters.merge!({filter_name => blk})
    end

    private

    def digit_filter
      lambda do |value|
        return if value.nil?
        if value.kind_of?(Numeric)
          value.to_s.gsub!(/[^\d]*/, "")
          value.to_i
        else
          value.gsub!(/[^\d]*/, "")
          value
        end
      end
    end

    def lowercase_filter
      lambda do |value|
        return if value.nil?
        value.downcase!
        value
      end
    end

    def uppercase_filter
      lambda do |value|
        return if value.nil?
        value.upcase!
        value
      end
    end

    def whitespace_filter
      lambda do |value|
        return if value.nil?
        value.gsub!(/\s+/, " ")
        value.strip!
        value
      end
    end

  end
end