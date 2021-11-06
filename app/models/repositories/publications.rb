# frozen_string_literal: true

module PaperDeep
    module Repository
      # Repository for Members
      class Publication
        def self.all
          Database::PublicationOrm.all.map { |db_project| rebuild_entity(db_project) }
        end
  
        def self.rebuild_entity(db_record)
          return nil unless db_record
          puts db_record.to_hash
          Entity::Publication.new(
            publication_id:     db_record.publicationId,
            journalImpact:      db_record.journalImpact,
            viewsCount:         db_record.viewsCount,
            citationCount:      db_record.citationCount,
            sourceTitle:        db_record.sourceTitle,
            publicationYear:    db_record.publicationYear
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


  