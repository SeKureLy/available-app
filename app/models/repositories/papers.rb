# frozen_string_literal: true

module PaperDeep
    module Repository
      # Repository for Members
      class Papers
        def self.all
          Database::PaperOrm.all.map { |db_project| rebuild_entity(db_project) }
        end

        def self.find_eid(eid)
          rebuild_entity Database::PaperOrm.first(eid: eid)
        end
  
        def self.find_author(author)
          rebuild_entity Database::PaperOrm.first(author: author)
        end
  
        def self.rebuild_entity(db_record)
          return nil unless db_record
  
          Entity::Paper.new(
            id:                 db_record.id,
            eid:                db_record.eid,
            title:              db_record.title,
            paper_link:         db_record.paper_link,
            citedby_link:       db_record.citedby_link,
            publication_name:   db_record.publication_name,
            date:               db_record.date,
            organization:       db_record.organization,
            author:             db_record.author,
            citedby:             db_record.citedby
          )
        end
  
        def self.rebuild_many(db_records)
          db_records.map do |db_member|
            Papers.rebuild_entity(db_member)
          end
        end
  
        def self.db_find_or_create(entity)
          Database::PaperOrm.find_or_create(entity.content)
        end
      end
    end
  end


  