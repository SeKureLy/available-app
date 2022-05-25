# frozen_string_literal: true

require_relative 'calendar'

module Available    
  # Behaviors of the currently logged in account
  class Event
    attr_reader :id, :title, :start_time, :end_time, :description, # basic info
                :calendar # full details

    def initialize(info)
      process_attributes(info['attributes'])
      process_included(info['include'])
    end

    private

    def process_attributes(attributes)
      @id               = attributes['id']
      @title            = attributes['title']
      @start_time       = attributes['start_time']
      @end_time         = attributes['end_time']
      @description      = attributes['description']
    end

    def process_included(included)
      @calendar = Calendar.new(included['calendar'])
    end
  end
end