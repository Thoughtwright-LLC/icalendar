module IcalendarV2

  class Event < Component
    required_property :dtstamp, IcalendarV2::Values::DateTime
    required_property :uid
    # dtstart only required if calendar's method is nil
    required_property :dtstart, IcalendarV2::Values::DateTime,
                      ->(event, dtstart) { !dtstart.nil? || !(event.parent.nil? || event.parent.ip_method.nil?) }

    optional_single_property :dtend, IcalendarV2::Values::DateTime
    optional_single_property :duration, IcalendarV2::Values::Duration
    mutually_exclusive_properties :dtend, :duration

    optional_single_property :ip_class
    optional_single_property :created, IcalendarV2::Values::DateTime
    optional_single_property :description
    optional_single_property :geo, IcalendarV2::Values::Float
    optional_single_property :last_modified, IcalendarV2::Values::DateTime
    optional_single_property :location
    optional_single_property :organizer, IcalendarV2::Values::CalAddress
    optional_single_property :priority, IcalendarV2::Values::Integer
    optional_single_property :sequence, IcalendarV2::Values::Integer
    optional_single_property :status
    optional_single_property :summary
    optional_single_property :transp
    optional_single_property :url, IcalendarV2::Values::Uri
    optional_single_property :recurrence_id, IcalendarV2::Values::DateTime

    optional_property :rrule, IcalendarV2::Values::Recur, true
    optional_property :attach, IcalendarV2::Values::Uri
    optional_property :attendee, IcalendarV2::Values::CalAddress
    optional_property :categories
    optional_property :comment
    optional_property :contact
    optional_property :exdate, IcalendarV2::Values::DateTime
    optional_property :request_status
    optional_property :related_to
    optional_property :resources
    optional_property :rdate, IcalendarV2::Values::DateTime

    component :alarm, false

    def initialize
      super 'event'
      self.dtstamp = IcalendarV2::Values::DateTime.new Time.now.utc, 'tzid' => 'UTC'
      self.uid = new_uid
    end

  end

end
