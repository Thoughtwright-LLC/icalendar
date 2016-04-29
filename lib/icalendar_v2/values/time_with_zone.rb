begin
  require 'active_support/time'

  if defined?(ActiveSupport::TimeWithZone)
    require 'icalendar_v2/values/active_support_time_with_zone_adapter'
  end
rescue LoadError
  # tis ok, just a bit less fancy
end

module IcalendarV2
  module Values
    module TimeWithZone
      attr_reader :tz_utc

      def initialize(value, params = {})
        params = IcalendarV2::DowncasedHash(params)
        @tz_utc = params['tzid'] == 'UTC'

        if defined?(ActiveSupport::TimeZone) && defined?(ActiveSupportTimeWithZoneAdapter) && !params['tzid'].nil?
          tzid = params['tzid'].is_a?(::Array) ? params['tzid'].first : params['tzid']
          zone = ActiveSupport::TimeZone[tzid]
          value = ActiveSupportTimeWithZoneAdapter.new nil, zone, value unless zone.nil?
          super value, params
        else
          super value, params
        end
      end

      def params_ical
        ical_params.delete 'tzid' if tz_utc
        super
      end
    end
  end
end