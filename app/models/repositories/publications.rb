# frozen_string_literal: true

module PaperDeep
    module Repository
      # Repository for Members
      class Publications
        def self.all
          Database::PublicationOrm.all.map { |db_project| rebuild_entity(db_project) }
        end
  
        def self.rebuild_entity(db_record)
          return nil unless db_record
          puts db_record.to_hash
          Entity::Publication.new(
            pid:                db_record.pid,
            journalImpact:      db_record.journal_impact,
            viewsCount:         db_record.views_count,
            citationCount:      db_record.citation_count,
            sourceTitle:        db_record.source_title,
            publicationYear:    db_record.publication_year
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


  