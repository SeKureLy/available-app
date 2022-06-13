# frozen_string_literal: true

require 'http'

module Available
  # Returns an authenticated user, or nil
  class AuthorizeGoogleAccount
    # Errors emanating from Google
    class UnauthorizedError < StandardError
      def message
        'Could not login with Google'
      end
    end

    def initialize(config)
      @config = config
    end

    def call(code)
      access_token = get_access_token_from_google(code)
      puts "ACCESS TOKEN = #{access_token}"
      get_sso_account_from_api(access_token)
    end

    private

    def get_access_token_from_google(code)
      challenge_response =
        HTTP.headers('Content-Type': 'application/x-www-form-urlencoded') #application/json
            .post(@config.GOOGLE_TOKEN_URL,
                  form: { code: code,
                          client_id: @config.GOOGLE_CLIENT_ID,
                          client_secret: @config.GOOGLE_CLIENT_SECRET,
                          redirect_uri: 'http://localhost:9292/api/v1/auth/sso_callback',
                          grant_type: 'authorization_code'
                        })
      raise UnauthorizedError unless challenge_response.status < 400

      JSON.parse(challenge_response)['access_token']
    end

    def get_sso_account_from_api(access_token)
      response =
        HTTP.post("#{@config.API_URL}/auth/sso",
                  json: { access_token: access_token })
      raise if response.code >= 400

      puts JSON.parse(response)
      account_info = JSON.parse(response)['data']['attributes']

      puts "account_info = #{account_info}"
      {
        account: account_info['account']['data']['attributes'],
        auth_token: account_info['auth_token']
      }
    end
  end
end
