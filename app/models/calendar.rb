# frozen_string_literal: true

module Available
  # Behaviors of the currently logged in account
  class Calendar
    attr_reader :id, :title, # basic info
                :owner, :members, :events, :policies # full details

    def initialize(calendar_info)
      process_attributes(calendar_info['attributes'])
      process_relationships(calendar_info['relationships'])
      process_policies(calendar_info['policies'])
    end

    private

    def process_attributes(attributes)
      @id = attributes['id']
      @title = attributes['title']
    end

    def process_relationships(relationships)
      return unless relationships

      @owner = Account.new(relationships['owner'])
      @members = process_members(relationships['members'])
      @events = process_events(relationships['events'])
    end

    def process_policies(policies)
      @policies = OpenStruct.new(policies)
    end

    def process_events(events_info)
      return nil unless events_info

      events_info.map { |event_info| Event.new(event_info) }
    end

    def process_members(members)
      return nil unless members

      members.map { |account_info| Account.new(account_info) }
    end
  end
end
