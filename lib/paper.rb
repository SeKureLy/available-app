# frozen_string_literal: true

# module for PaperDeep
module PaperDeep
  # class for paper to solve feature envy
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
      # TODO: change to list.join
      origin_hash[:affiliation][0][:affilname]
    end

    def citedby
      origin_hash[:'citedby-count']
    end

    def author
      origin_hash[:'dc:creator']
    end

    def content
      {
        eid: eid,
        title: title,
        link: link,
        publicationName: publication_name,
        date: date,
        Organization: organization,
        citeBy: citedby,
        author: author
      }
    end
  end
end
