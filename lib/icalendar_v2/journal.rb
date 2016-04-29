module IcalendarV2

  class Journal < Component

    required_property :dtstamp, IcalendarV2::Values::DateTime
    required_property :uid

    optional_single_property :ip_class
    optional_single_property :created, IcalendarV2::Values::DateTime
    optional_single_property :dtstart, IcalendarV2::Values::DateTime
    optional_single_property :last_modified, IcalendarV2::Values::DateTime
    optional_single_property :organizer, IcalendarV2::Values::CalAddress
    optional_single_property :recurrence_id, IcalendarV2::Values::DateTime
    optional_single_property :sequence, IcalendarV2::Values::Integer
    optional_single_property :status
    optional_single_property :summary
    optional_single_property :url, IcalendarV2::Values::Uri

    optional_property :rrule, IcalendarV2::Values::Recur, true
    optional_property :attach, IcalendarV2::Values::Uri
    optional_property :attendee, IcalendarV2::Values::CalAddress
    optional_property :categories
    optional_property :comment
    optional_property :contact
    optional_property :description
    optional_property :exdate, IcalendarV2::Values::DateTime
    optional_property :request_status
    optional_property :related_to
    optional_property :rdate, IcalendarV2::Values::DateTime

    def initialize
      super 'journal'
      self.dtstamp = IcalendarV2::Values::DateTime.new Time.now.utc, 'tzid' => 'UTC'
      self.uid = new_uid
    end

  end

end
