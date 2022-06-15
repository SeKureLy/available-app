# frozen_string_literal: true

require 'roda'

module Available
  # Web controller for Available API
  class App < Roda
    route('google') do |routing|

      # GET /events/[event_id]
      routing.get('calendar') do
        puts "https://www.googleapis.com/calendar/v3/users/me/calendarList?maxResults=#{10}"
        response = HTTP.auth("Bearer #{@current_account.auth_token}")
                    .get("https://www.googleapis.com/calendar/v3/users/me/calendarList?maxResults=#{10}")
        puts response.to_s
        return JSON.parse(response.body.to_s) if response.code == 200
        return {"message": "error"}.to_json
      rescue StandardError => e

        puts e.message
        routing.halt 500, {message: e.message}.to_json
      end
    end
  end
end
