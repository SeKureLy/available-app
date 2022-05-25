# frozen_string_literal: true

require 'roda'

module Available
  # Web controller for Available API
  class App < Roda
    route('events') do |routing|
      routing.redirect '/auth/login' unless @current_account.logged_in?

      # GET /events/[event_id]
      routing.get(String) do |event_id|
        event_info = GetEvent.new(App.config)
                              .call(@current_account, event_id)
        event = Event.new(event_info)

        # view :document, locals: {
        #   current_account: @current_account, document: document
        # }
      end
    end
  end
end
