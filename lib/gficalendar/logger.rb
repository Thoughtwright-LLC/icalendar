require 'delegate'
require 'logger'

module GFIcalendar

  class Logger < ::SimpleDelegator

    def initialize(sink, level = ::Logger::WARN)
      logger = ::Logger.new(sink)
      logger.level = level
      super logger
    end

  end

end
