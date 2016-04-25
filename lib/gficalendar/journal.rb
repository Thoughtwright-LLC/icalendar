module GFIcalendar

  class Journal < Component

    required_property :dtstamp, GFIcalendar::Values::DateTime
    required_property :uid

    optional_single_property :ip_class
    optional_single_property :created, GFIcalendar::Values::DateTime
    optional_single_property :dtstart, GFIcalendar::Values::DateTime
    optional_single_property :last_modified, GFIcalendar::Values::DateTime
    optional_single_property :organizer, GFIcalendar::Values::CalAddress
    optional_single_property :recurrence_id, GFIcalendar::Values::DateTime
    optional_single_property :sequence, GFIcalendar::Values::Integer
    optional_single_property :status
    optional_single_property :summary
    optional_single_property :url, GFIcalendar::Values::Uri

    optional_property :rrule, GFIcalendar::Values::Recur, true
    optional_property :attach, GFIcalendar::Values::Uri
    optional_property :attendee, GFIcalendar::Values::CalAddress
    optional_property :categories
    optional_property :comment
    optional_property :contact
    optional_property :description
    optional_property :exdate, GFIcalendar::Values::DateTime
    optional_property :request_status
    optional_property :related_to
    optional_property :rdate, GFIcalendar::Values::DateTime

    def initialize
      super 'journal'
      self.dtstamp = GFIcalendar::Values::DateTime.new Time.now.utc, 'tzid' => 'UTC'
      self.uid = new_uid
    end

  end

end
