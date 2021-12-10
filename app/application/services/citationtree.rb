# frozen_string_literal: true

require 'dry/transaction'

module PaperDeep
  module Service
    # Transaction to store project from Github API to database
    class CitationTree
      include Dry::Transaction

      step :extract_paper_root
      step :call_citationtree_api

      private

      def extract_paper_root(root_paper)
        list = { eid: root_paper["eid"] }
        Success(list)
      rescue StandardError => e
        Failure(e.to_s)
      end

      def call_citationtree_api(list)
        puts list
        result =JSON.parse(Gateway::Api.new(App.config).citationtree(list))
        Success(result)
 
      rescue StandardError => e
        puts e.to_s
        Failure(e.to_s)
      end
    end
  end
end
