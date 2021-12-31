# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module PaperDeep
  module Representer
    # Represents essential Paper information for API output
    # USAGE:
    #   eid = '2-s2.0-84979828304'
    #   paper = Database::PaperOrm.find_eid(eid)
    #   Representer::Paper.new(paper).to_json
    class Paper < Roar::Decorator
      include Roar::JSON

      property :eid
      property :title
      property :paper_link
      property :citedby_link
      property :date
      property :organization
      property :author
      property :citedby
      property :publication_id
      property :publication
    end
  end
end
