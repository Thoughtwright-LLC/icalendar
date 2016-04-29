module IcalendarV2
  module Values

    class Period < Value

      def initialize(value, params = {})
        parts = value.split '/'
        period_start = IcalendarV2::Values::DateTime.new parts.first
        if parts.last =~ /\A[+-]?P.+\z/
          period_end = IcalendarV2::Values::Duration.new parts.last
        else
          period_end = IcalendarV2::Values::DateTime.new parts.last
        end
        super [period_start, period_end], params
      end

      def value_ical
        value.map { |v| v.value_ical }.join '/'
      end

      def period_start
        first
      end

      def period_start=(v)
        value[0] = v.is_a?(IcalendarV2::Values::DateTime) ? v : IcalendarV2::Values::DateTime.new(v)
      end

      def explicit_end
        last.is_a?(IcalendarV2::Values::DateTime) ? last : nil
      end

      def explicit_end=(v)
        value[1] = v.is_a?(IcalendarV2::Values::DateTime) ? v : IcalendarV2::Values::DateTime.new(v)
      end

      def duration
        last.is_a?(IcalendarV2::Values::Duration) ? last : nil
      end

      def duration=(v)
        value[1] = v.is_a?(IcalendarV2::Values::Duration) ? v : IcalendarV2::Values::Duration.new(v)
      end
    end
  end
end
