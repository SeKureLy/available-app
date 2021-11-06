# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module PaperDeep
  module Entity
    # Domain entity for team members
    class Publication < Dry::Struct
      include Dry.Types
      attribute :publication_id, Strict::Integer
      attribute :journalImpact, Strict::Float
      attribute :viewsCount, Strict::Integer
      attribute :citationCount, Strict::Integer
      attribute :publicationYear, Strict::Integer
      attribute :sourceTitle, Strict::String

      def content
        { 
          publication_id: publication_id,
          journalImpact: journalImpact,
          viewsCount: viewsCount,
          citationCount: citationCount,
          publicationYear: publicationYear,
          sourceTitle: sourceTitle
        }
      end
    end
  end
end
