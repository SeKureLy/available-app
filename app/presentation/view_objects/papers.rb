# frozen_string_literal: true

module Views
    # View for a single project entity
    class Papers
      def initialize(papers)
        @papers = papers
      end
  
      def content
        @papers.map(&:content).to_json
      end
    end
  end