# frozen_string_literal: true

require 'dry/transaction'

module PaperDeep
  module Service
    # Transaction to store project from Github API to database
    class SearchPublication
      include Dry::Transaction

      step :find_publication
      step :store_publication

      private

      def find_publication(input)
        input[:publication] = publication_from_scopus(input)
        Success(input)
      rescue StandardError => error
        Failure(error.to_s)
      end

      def store_publication(input)
        input[:storage] = input[:publication].map do |publication|
                            Repository::For.entity(publication).db_find_or_create(publication)
                          end
        Success(input)
      rescue StandardError => error
        puts error.backtrace.join("\n")
        Failure('Having trouble accessing the database publication')
      end

      # following are support methods that other services could use

      def publication_from_scopus(input)
        scopus = PaperDeep::PublicationMapper.new(App.config.api_key)
        result = scopus.search(input[:pid])
        publications = scopus.parse
      rescue StandardError
        raise 'Having trouble searching publication'
      end
    end
  end
end