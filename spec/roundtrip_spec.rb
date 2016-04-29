require 'spec_helper'

describe IcalendarV2 do

  describe 'single event round trip' do
    let(:source) { File.read File.join(File.dirname(__FILE__), 'fixtures', 'single_event.ics') }

    it 'will generate the same file as is parsed' do
      expect(IcalendarV2.parse(source, true).to_ical).to eq source
    end

    it 'array properties can be assigned to a new event' do
      event = IcalendarV2::Event.new
      parsed = IcalendarV2.parse source, true
      event.rdate = parsed.events.first.rdate
      expect(event.rdate.first).to be_kind_of IcalendarV2::Values::Array
      expect(event.rdate.first.ical_params).to eq 'tzid' => ['US-Mountain']
    end
  end

  describe 'timezone round trip' do
    let(:source) { File.read File.join(File.dirname(__FILE__), 'fixtures', 'timezone.ics') }
    it 'will generate the same file as it parsed' do
      expect(IcalendarV2.parse(source, true).to_ical).to eq source
    end
  end

  describe 'non-default values' do
    let(:source) { File.read File.join(File.dirname(__FILE__), 'fixtures', 'nondefault_values.ics') }
    subject { IcalendarV2.parse(source, true).events.first }

    it 'will set dtstart to Date' do
      expect(subject.dtstart.value).to eq ::Date.new(2006, 12, 15)
    end

    it 'will set dtend to Date' do
      expect(subject.dtend.value).to eq ::Date.new(2006, 12, 15)
    end

    it 'will output value param on dtstart' do
      expect(subject.dtstart.to_ical(subject.class.default_property_types['dtstart'])).to match /^;VALUE=DATE:20061215$/
    end

    it 'will output value param on dtend' do
      expect(subject.dtend.to_ical(subject.class.default_property_types['dtend'])).to match /^;VALUE=DATE:20061215$/
    end
  end

  describe 'sorting daily events' do
    let(:source) { File.read File.join(File.dirname(__FILE__), 'fixtures', 'two_day_events.ics') }
    subject { IcalendarV2.parse(source, true).events }

    it 'sorts day events' do
      events = subject.sort_by(&:dtstart)

      expect(events.first.dtstart).to eq ::Date.new(2014, 7, 13)
      expect(events.last.dtstart).to eq ::Date.new(2014, 7, 14)
    end
  end

  describe 'sorting time events' do
    let(:source) { File.read File.join(File.dirname(__FILE__), 'fixtures', 'two_time_events.ics') }
    subject { IcalendarV2.parse(source, true).events }

    it 'sorts time events by start time' do
      events = subject.sort_by(&:dtstart)

      expect(events.first.dtstart).to eq ::DateTime.new(2014, 7, 14, 9, 0, 0, '-4')

      expect(events.last.dtstart).to eq ::DateTime.new(2014, 7, 14, 9, 1, 0, '-4')
      expect(events.last.dtend).to eq ::DateTime.new(2014, 7, 14, 9, 59, 0, '-4')
    end

    it 'sorts time events by end time' do
      events = subject.sort_by(&:dtend)

      expect(events.first.dtstart).to eq ::DateTime.new(2014, 7, 14, 9, 1, 0, '-4')
      expect(events.first.dtend).to eq ::DateTime.new(2014, 7, 14, 9, 59, 0, '-4')
      expect(events.last.dtstart).to eq ::DateTime.new(2014, 7, 14, 9, 0, 0, '-4')
    end
  end

  describe 'sorting date / time events' do
    let(:source) { File.read File.join(File.dirname(__FILE__), 'fixtures', 'two_date_time_events.ics') }
    subject { IcalendarV2.parse(source, true).events }

    it 'sorts time events' do
      events = subject.sort_by(&:dtstart)

      expect(events.first.dtstart).to eq ::Date.new(2014, 7, 14)
      expect(events.last.dtstart).to eq ::DateTime.new(2014, 7, 14, 9, 0, 0, '-4')
    end
  end

  describe 'non-standard values' do
    if defined? File::NULL
      before(:all) { IcalendarV2.logger = IcalendarV2::Logger.new File::NULL }
      after(:all) { IcalendarV2.logger = nil }
    end
    let(:source) { File.read File.join(File.dirname(__FILE__), 'fixtures', 'nonstandard.ics') }
    subject { IcalendarV2::Parser.new(source, strict) }

    context 'strict parser' do
      let(:strict) { true }
      specify { expect { subject.parse }.to raise_error }
    end

    context 'lenient parser' do
      let(:strict) { false }
      specify { expect { subject.parse }.to_not raise_error }

      context 'saves non-standard fields' do
        let(:parsed) { subject.parse.first.events.first }
        specify { expect(parsed.custom_property('customfield').first).to eq 'Not properly noted as custom with X- prefix.' }
        specify { expect(parsed.custom_property('CUSTOMFIELD').first).to eq 'Not properly noted as custom with X- prefix.' }
      end

      it 'can output custom fields' do
        ical = subject.parse.first.to_ical
        expect(ical).to include 'CUSTOMFIELD:Not properly noted as custom with X- prefix.'
      end
    end
  end
end
