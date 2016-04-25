require 'gficalendar/logger'

module GFIcalendar

  MAX_LINE_LENGTH = 75

  def self.logger
    @logger ||= GFIcalendar::Logger.new(STDERR)
  end

  def self.logger=(logger)
    @logger = logger
  end

  def self.parse(source, single = false)
    calendars = Parser.new(source).parse
    single ? calendars.first : calendars
  end

end

require 'gficalendar/has_properties'
require 'gficalendar/has_components'
require 'gficalendar/component'
require 'gficalendar/value'
require 'gficalendar/alarm'
require 'gficalendar/event'
require 'gficalendar/todo'
require 'gficalendar/journal'
require 'gficalendar/freebusy'
require 'gficalendar/timezone'
require 'gficalendar/calendar'
require 'gficalendar/parser'
