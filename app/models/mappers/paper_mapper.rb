# frozen_string_literal: true

require_relative '../gateways/scopus_api'
require_relative '../entities/paper'

# Module for PaperDeep Module
module PaperDeep
  # Data parsing from gateway"
  class PaperMapper
    attr_reader :raw_data

    def initialize(api_key, gateway_class = ScopusAPI)
      @api_key = api_key
      @gateway_class = gateway_class
      @gateway = @gateway_class.new(@api_key)
    end

    def search(query)
      @raw_data = @gateway.search(query)
    end

    def parse
      raw_data.map do |origin_hash|
        PaperMapper.build_entity(origin_hash)
      end
    end

    def self.build_entity(data)
      PaperInfo.new(data).build_entity
    end
  end

  # Class for Paper
  class PaperInfo
    def initialize(paper_data)
      @origin_hash = paper_data
    end

    attr_reader :origin_hash

    def eid
      origin_hash[:eid]
    rescue StandardError
      'NULL'
    end

    def title
      origin_hash[:'dc:title']
    rescue StandardError
      'NULL'
    end

    def paper_link
      scopus_part = origin_hash[:link].select { |item| item[:@ref] == 'scopus' }
      scopus_part[0][:@href]
    rescue StandardError
      'NULL'
    end

    def citedby_link
      citedby_part = origin_hash[:link].select { |item| item[:@ref] == 'scopus-citedby' }
      citedby_part[0][:@href]
    rescue StandardError
      'NULL'
    end

    def publication_name
      origin_hash[:'prism:publicationName']
    rescue StandardError
      'NULL'
    end

    def date
      origin_hash[:'prism:coverDate']
    rescue StandardError
      'NULL'
    end

    def organization
      # if origin_hash[:affiliation].nil?
      organization_list = origin_hash[:affiliation].map { |item| item[:affilname] }
      organization_list.join(',')
    rescue StandardError
      'NULL'
    end

    def citedby
      origin_hash[:'citedby-count'].to_i
    rescue StandardError
      'NULL'
    end

    def author
      origin_hash[:'dc:creator']
    rescue StandardError
      'NULL'
    end

    def build_entity
      PaperDeep::Entity::Paper.new(eid: eid,
                                   title: title,
                                   publication_name: publication_name,
                                   date: date,
                                   organization: organization,
                                   citedby: citedby,
                                   author: author,
                                   paper_link: paper_link,
                                   citedby_link: citedby_link)
    end
  end
end

# instance = PaperDeep::PaperMapper.new('c04c47e12dff67bb111f066d47f54115')
# instance.search('ml')
# # puts instance.raw_data
# QAQ = instance.parse
# # puts QAQ[0].content
# QAQ.each { |item| puts item.content}
