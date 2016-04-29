require 'icalendar_v2/logger'

module IcalendarV2

  MAX_LINE_LENGTH = 75

  def self.logger
    @logger ||= IcalendarV2::Logger.new(STDERR)
  end

  def self.logger=(logger)
    @logger = logger
  end

  def self.parse(source, single = false)
    calendars = Parser.new(source).parse
    single ? calendars.first : calendars
  end

end

require 'icalendar_v2/has_properties'
require 'icalendar_v2/has_components'
require 'icalendar_v2/component'
require 'icalendar_v2/value'
require 'icalendar_v2/alarm'
require 'icalendar_v2/event'
require 'icalendar_v2/todo'
require 'icalendar_v2/journal'
require 'icalendar_v2/freebusy'
require 'icalendar_v2/timezone'
require 'icalendar_v2/calendar'
require 'icalendar_v2/parser'
