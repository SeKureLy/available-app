# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'publication_representer'

module PaperDeep
  module Representer
    # Represents list of projects for API output
    class PublicationList < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      collection :publication, extend: Representer::Publication, class: OpenStruct

      link :self do
        '/api/v1/publication'
      end
    end

    # publication class
    class Publications
      def initialize(publication)
        @publication = publication
      end

      def publication
        @publication.map{|p| OpenStruct.new(p)}
      end
    end
  end
end
