module GFIcalendar

  class Timezone < Component
    module TzProperties
      def self.included(base)
        base.class_eval do
          required_property :dtstart, GFIcalendar::Values::DateTime
          required_property :tzoffsetfrom, GFIcalendar::Values::UtcOffset
          required_property :tzoffsetto, GFIcalendar::Values::UtcOffset

          optional_property :rrule, GFIcalendar::Values::Recur, true
          optional_property :comment
          optional_property :rdate, GFIcalendar::Values::DateTime
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

    optional_single_property :last_modified, GFIcalendar::Values::DateTime
    optional_single_property :tzurl, GFIcalendar::Values::Uri

    component :daylight, false, GFIcalendar::Timezone::Daylight
    component :standard, false, GFIcalendar::Timezone::Standard

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
