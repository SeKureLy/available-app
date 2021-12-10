# frozen_string_literal: true

require 'dry/transaction'

module PaperDeep
  module Service
    # Transaction to store project from Github API to database
    class AddPaper
      include Dry::Transaction

      step :parse_keyword
      step :find_paper

      private

      def parse_keyword(input)
        if input.success?
          Success(keyword: input[:keyword])
        else
          Failure("KEYWORD #{input.errors.messages.first}")
        end
      end

      def find_paper(input)
        input[:paper] = Gateway::Api.new(App.config).paper(input)
        puts input
        Success(input)
      rescue StandardError => e
        Failure(e.to_s)
      end
    end
  end
end
