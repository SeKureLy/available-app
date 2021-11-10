# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module PaperDeep
  module Entity
    # Domain entity for team members
    class Publication < Dry::Struct
      include Dry.Types
      attribute :pid, Strict::Integer
      attribute :journal_impact, Strict::Float
      attribute :views_count, Strict::Integer
      attribute :citation_count, Strict::Integer
      attribute :publication_year, Strict::Integer
      attribute :source_title, Strict::String

      def content
        { 
          pid: pid,
          journal_impact: journal_impact,
          views_count: views_count,
          citation_count: citation_count,
          publication_year: publication_year,
          source_title: source_title
        }
      end
    end
  end
end
