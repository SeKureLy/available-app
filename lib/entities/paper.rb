# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module PaperDeep
  module Entity
    # Domain entity for team members
    class Paper < Dry::Struct
      include Dry.Types
      attribute :eid,  Strict::String
      attribute :title,  Strict::String
      attribute :link,  Strict::String
      attribute :publication_name,  Strict::String
      attribute :date,  Strict::String
      attribute :organization,  Strict::String
      attribute :citedby, Strict::Integer
      attribute :author,  Strict::String

      def content 
        {
            eid: eid,
            title: title,
            link: link,
            publication_name: publication_name,
            date: date,
            organization: organization,
            citedby: citedby,
            author: author
        }
      end
    end
  end
end