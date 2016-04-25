module GFIcalendar

  class Freebusy < Component

    required_property :dtstamp, GFIcalendar::Values::DateTime
    required_property :uid

    optional_single_property :contact
    optional_single_property :dtstart, GFIcalendar::Values::DateTime
    optional_single_property :dtend, GFIcalendar::Values::DateTime
    optional_single_property :organizer, GFIcalendar::Values::CalAddress
    optional_single_property :url, GFIcalendar::Values::Uri

    optional_property :attendee, GFIcalendar::Values::CalAddress
    optional_property :comment
    optional_property :freebusy, GFIcalendar::Values::Period
    optional_property :request_status

    def initialize
      super 'freebusy'
      self.dtstamp = GFIcalendar::Values::DateTime.new Time.now.utc, 'tzid' => 'UTC'
      self.uid = new_uid
    end

  end

end
