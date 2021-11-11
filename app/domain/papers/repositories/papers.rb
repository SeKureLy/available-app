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

        def self.find_publication_by_id(publication_id)
          # SELECT * FROM `papers` 
          # LEFT JOIN `publications` ON (`publications`.`pid` = `papers`.`publication_id`) 
          # WHERE (`publication_id` = publication_id)
          db_record = Database::PaperOrm.left_join(:publications, pid: :publication_id).where(publication_id:publication_id).first
          rebuild_entity_with_publication(db_record)
        end
  
        def self.rebuild_entity_with_publication(db_record)
          return nil unless db_record
          record = db_record.to_hash
          return rebuild_entity(db_record) if record[:pid].nil?
          publication_hash = {
              pid:                record[:pid],
              journalImpact:      record[:journal_impact],
              viewsCount:         record[:views_count],
              citationCount:      record[:citation_count],
              sourceTitle:        record[:source_title],
              publicationYear:    record[:publication_year]
          }
          paper_hash = record.except(publication_hash.keys)
          Entity::Paper.new(paper_hash.merge(publication: publication_hash))
        end
  
        def self.rebuild_entity(db_record)
          return nil unless db_record
  
          Entity::Paper.new(
            id:                 db_record.id,
            eid:                db_record.eid,
            title:              db_record.title,
            paper_link:         db_record.paper_link,
            citedby_link:       db_record.citedby_link,
            date:               db_record.date,
            organization:       db_record.organization,
            author:             db_record.author,
            citedby:            db_record.citedby,
            publication_id:     db_record.publication_id,
            publication:       nil
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

