# frozen_string_literal: true

require 'sequel'

module PaperDeep
  module Database
    # Object-Relational Mapper for Members
    class PaperOrm < Sequel::Model(:papers)
      plugin :timestamps, update_on_create: true

      def self.find_or_create(paper_info)
        first(title: paper_info[:title]) || create(paper_info)
      end
    end
  end
end
