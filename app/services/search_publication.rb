# frozen_string_literal: true

require 'dry/transaction'

module PaperDeep
  module Service
    # Transaction to store project from Github API to database
    class SearchPublication
      include Dry::Transaction

      step :find_publication

      private

      def find_publication(input)
        result = JSON.parse(Gateway::Api.new(App.config).publication(input))
        input[:publication] = result['publication']
        Success(input)
      rescue StandardError => e
        Failure(e.to_s)
      end
    end
  end
end
