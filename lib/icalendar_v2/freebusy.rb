module IcalendarV2

  class Freebusy < Component

    required_property :dtstamp, IcalendarV2::Values::DateTime
    required_property :uid

    optional_single_property :contact
    optional_single_property :dtstart, IcalendarV2::Values::DateTime
    optional_single_property :dtend, IcalendarV2::Values::DateTime
    optional_single_property :organizer, IcalendarV2::Values::CalAddress
    optional_single_property :url, IcalendarV2::Values::Uri

    optional_property :attendee, IcalendarV2::Values::CalAddress
    optional_property :comment
    optional_property :freebusy, IcalendarV2::Values::Period
    optional_property :request_status

    def initialize
      super 'freebusy'
      self.dtstamp = IcalendarV2::Values::DateTime.new Time.now.utc, 'tzid' => 'UTC'
      self.uid = new_uid
    end

  end

end
