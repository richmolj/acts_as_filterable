module ActsAsFilterable
  class Configuration

    # Provides the following:
    #
    # * filter_for_digits - Filter non-numeric values out.
    # * filter_for_uppercase - Uppercase all alpha values.
    # * filter_for_lowercase - Lowercase all alpha values.
    # * filter_for_whitespace - Filter any continuous sequence of whitespace greater than 1 to only 1 space.
    @@filters = Hash.new([]).tap do |f|
      f[:digits] = lambda { |attr|
        if attr.kind_of?(Numeric)
          attr.to_s.gsub!(/[^\d]*/, "")
          attr.to_i
        else
          attr.gsub!(/[^\d]*/, "")
          attr
        end
      }
      f[:lowercase]  = lambda { |attr| attr.downcase!; attr }
      f[:uppercase]  = lambda { |attr| attr.upcase!; attr }
      f[:whitespace] = lambda { |attr| attr.gsub!(/\s+/, " "); attr.strip!; attr }
    end

    def self.filters
      @@filters
    end

    def add_filter(filter_name, &blk)
      raise "Must supply a block when adding a filter to ActsAsFilterable::Configuration" unless block_given?
      @@filters.merge!({filter_name => blk})
    end

  end
end