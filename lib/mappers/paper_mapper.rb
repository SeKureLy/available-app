require 'yaml'
require_relative '../gateways/scopus_api'

module PaperDeep
    class PaperMapper
        def initialize(gh_token, gateway_class = ScopusAPI)
            @token = gh_token
            @gateway_class = gateway_class
            @gateway = @gateway_class.new(@token)
        end

        def raw_data(query)
            @data = @gateway.search(query)
        end

        def parse
            @data.map do |origin_hash|
                PaperMapper.build_entity(origin_hash)
            end
        end

        def self.build_entity(data)
            PaperInfo.new(data).build_entity
        end

    end

    class PaperInfo
        # attr_reader origin_hash
    
        def initialize(paper_data)
          @origin_hash = paper_data
        end
    
        attr_reader :origin_hash
    
        def eid
          origin_hash[:eid]
        end
    
        def title
          origin_hash[:'dc:title']
        end
    
        def link
          origin_hash[:'prism:url']
        end
    
        def publication_name
          origin_hash[:'prism:publicationName']
        end
    
        def date
          origin_hash[:'prism:coverDate']
        end
    
        def organization
          organization_list = origin_hash[:affiliation].map { |item| item[:affilname]}
          organization_list.join(',')
        end
    
        def citedby
          origin_hash[:'citedby-count']
        end
    
        def author
          origin_hash[:'dc:creator']
        end
    
        def build_entity
            PaperDeep::Entity::Paper.new(
                eid: eid,
                title: title,
                link: link,
                publicationName: publication_name,
                date: date,
                Organization: organization,
                citeBy: citedby,
                author: author
            )
        end
      end
end
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
API_TOKEN = CONFIG['api_key']
instance = PaperDeep::PaperMapper.new(API_TOKEN)
cool = instance.raw_data('blockchain')
QAQ = cool.parse

puts QAQ