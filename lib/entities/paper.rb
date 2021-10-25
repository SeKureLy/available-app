# frozen_string_literal: false

require 'dry-types'
require 'dry-struct'

module PaperDeep
  module Entity
    # Domain entity for team members
    class Paper < Dry::Struct
      include Dry.Types

      attribute :title,  Strict::String
      attribute :publication_name,  Strict::String
      attribute :link,  Strict::String
      attribute :author,  Strict::String
      attribute :organization,  Strict::String
      attribute :eid,  Strict::String
      attribute :citedby, Strict::Integer
      attribute :date,  Strict::String
    end
  end
end