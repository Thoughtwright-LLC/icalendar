module IcalendarV2

  class Timezone < Component
    module TzProperties
      def self.included(base)
        base.class_eval do
          required_property :dtstart, IcalendarV2::Values::DateTime
          required_property :tzoffsetfrom, IcalendarV2::Values::UtcOffset
          required_property :tzoffsetto, IcalendarV2::Values::UtcOffset

          optional_property :rrule, IcalendarV2::Values::Recur, true
          optional_property :comment
          optional_property :rdate, IcalendarV2::Values::DateTime
          optional_property :tzname
        end
      end
    end
    class Daylight < Component
      include TzProperties

      def initialize
        super 'daylight', 'DAYLIGHT'
      end
    end
    class Standard < Component
      include TzProperties

      def initialize
        super 'standard', 'STANDARD'
      end
    end


    required_property :tzid

    optional_single_property :last_modified, IcalendarV2::Values::DateTime
    optional_single_property :tzurl, IcalendarV2::Values::Uri

    component :daylight, false, IcalendarV2::Timezone::Daylight
    component :standard, false, IcalendarV2::Timezone::Standard

    def initialize
      super 'timezone'
    end

    def valid?(strict = false)
      daylights.empty? && standards.empty? and return false
      daylights.all? { |d| d.valid? strict } or return false
      standards.all? { |s| s.valid? strict } or return false
      super
    end
  end
end
