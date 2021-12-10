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
    class Publication < Roar::Decorator
      include Roar::JSON

      property :pid
      property :journal_impact
      property :views_count
      property :citation_count
      property :publication_year
      property :source_title
    end
  end
end
