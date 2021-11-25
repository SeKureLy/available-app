# frozen_string_literal: true

require 'dry/transaction'

module PaperDeep
  module Service
    # Transaction to store project from Github API to database
    class AddPaper
      include Dry::Transaction

      step :parse_keyword
      step :find_paper
      step :store_paper

      private

      def parse_keyword(input)
        if input.success?
          Success(keyword: input[:keyword])
        else
          Failure("KEYWORD #{input.errors.messages.first}")
        end
      end

      def find_paper(input)
        input[:paper] = paper_from_scopus(input)
        Success(input)
      rescue StandardError => error
        Failure(error.to_s)
      end

      def store_paper(input)
        input[:storage] = input[:paper].map do |paper|
                  Repository::For.entity(paper).db_find_or_create(paper)
                end
        Success(input)
      rescue StandardError => error
        puts error.backtrace.join("\n")
        Failure('Having trouble accessing the database')
      end

      # following are support methods that other services could use

      def paper_from_scopus(input)
        scopus = PaperDeep::PaperMapper.new(App.config.api_key)
        result = scopus.search(input[:keyword])[0]
        scopus_parse_project = scopus.parse
      rescue StandardError
        raise 'Having trouble searching papers'
      end
    end
  end
end