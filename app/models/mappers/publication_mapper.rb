# frozen_string_literal: true

require_relative '../../infrastructure/gateways/publication_lookup'
require_relative '../entities/publication'

# Module for PaperDeep Module
module PaperDeep
  # Data parsing from gateway"
  class PublicationMapper
    attr_reader :raw_data

    def initialize(api_key, gateway_class = PublicationAPI)
      @api_key = api_key
      @gateway_class = gateway_class
      @gateway = @gateway_class.new(@api_key)
    end

    def search(publication_id)
      @raw_data = @gateway.search(publication_id)
    end

    def parse
      raw_data.map do |origin_hash|
        # puts origin_hash[:publication]
        PublicationMapper.build_entity(origin_hash)
      end
    end

    def self.build_entity(data)
      PublicationInfo.new(data).build_entity
    end
  end

  # Class for Paper
  class PublicationInfo
    def initialize(publication_data)
      @origin_hash = publication_data
    end

    attr_reader :origin_hash

    def journalImpact
      journal_impact = origin_hash[:metrics].select { |item| item[:metricType] == 'JournalImpact' }
      journal_impact[0][:value].to_f
    rescue StandardError
      'NULL'
    end

    def viewsCount
      views_count = origin_hash[:metrics].select { |item| item[:metricType] == 'ViewsCount' }
      views_count[0][:value].to_i
    rescue StandardError
      'NULL'
    end

    def citationCount
      citation_count = origin_hash[:metrics].select { |item| item[:metricType] == 'CitationCount' }
      citation_count[0][:value].to_i
    rescue StandardError
      'NULL'
    end

    def publicationYear
      origin_hash[:publication][:publicationYear].to_i
    rescue StandardError
      'NULL'
    end

    def sourceTitle
      origin_hash[:publication][:sourceTitle]
    rescue StandardError
      'NULL'
    end

    def build_entity
      # puts origin_hash
      PaperDeep::Entity::Publication.new(journalImpact: journalImpact,
                                   viewsCount: viewsCount,
                                   citationCount: citationCount,
                                   sourceTitle: sourceTitle,
                                   publicationYear: publicationYear)
    end
  end
end


# instance = PaperDeep::PublicationMapper.new('7f59af901d2d86f78a1fd60c1bf9426a')
# instance.search('84979828304,84979828302')
# # puts instance.raw_data
# QAQ = instance.parse
# # puts QAQ[0].content
# QAQ.each { |item| puts item.content}