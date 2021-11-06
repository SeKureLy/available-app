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

        def self.find_publication_by_id(publication_Id)
          # SELECT * FROM `papers` 
          # LEFT JOIN `publications` ON (`publications`.`publicationId` = `papers`.`publication_id`) 
          # WHERE (`publication_id` = publication_id)
          # db_record = PaperOrm.left_join(:publications, publicationId: :publication_id).where(publication_id:publication_id).all
          publication_record = Database::PublicationOrm.first(publicationId: publication_Id)
          paper_record = Database::PaperOrm.first(publication_id: publication_Id)
          rebuild_entity_with_publication(publication_record,paper_record)
        end
  
        def self.rebuild_entity_with_publication(publication_record,paper_record)
          return nil unless paper_record
          publication_hash = {
              publication_id:     publication_record.publicationId,
              journalImpact:      publication_record.journalImpact,
              viewsCount:         publication_record.viewsCount,
              citationCount:      publication_record.citationCount,
              sourceTitle:        publication_record.sourceTitle,
              publicationYear:    publication_record.publicationYear
          }
          Entity::Paper.new(
            paper_record.to_hash.merge(
              publication: publication_hash
            )
          )
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


  
# # testing script in rake console
# # 輸入測試資料
# 0. 清空db
# 1. rackup 打postman 一次,Papers就有資料
# 2. 使用rake console輸入publication資料
# rake console
# cd PaperDeep/Database
# PublicationOrm.create(publicationId: 84979828304,journalImpact:3.5,viewsCount:1,citationCount:2,publicationYear:2000,sourceTitle:"IEEE")

# # 測試left join
# rake console
# cd PaperDeep/Repository
# Papers.all.first
# Papers.find_publication_by_id(84979828304)
# Papers.find_publication_by_id(84979828304).publication.content
