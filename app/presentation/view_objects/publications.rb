# frozen_string_literal: true

module Views
    # View for a single project entity
    class Publications
      def initialize(publications)
        @publications = publications
      end
  
      def content
        @publications.map(&:content).to_json
      end
    end
  end