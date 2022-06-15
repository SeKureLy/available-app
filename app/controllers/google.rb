# frozen_string_literal: true

require 'roda'

module Available
  # Web controller for Available API
  class App < Roda
    route('google') do |routing|

      # GET /events/[event_id]
      routing.get('calendar') do
        response = HTTP.auth("Bearer #{@current_account.google_auth_token}")
                    .get("https://www.googleapis.com/calendar/v3/users/me/calendarList?maxResults=#{10}")
        return response.to_s if response.code == 200
        return {"message": "error"}.to_json
      rescue StandardError => e
        puts e.message
        routing.halt 500, {message: "error"}.to_json
      end
    end
  end
end
