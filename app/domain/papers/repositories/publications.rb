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

        Entity::Publication.new(
          pid: db_record.pid,
          journal_impact: db_record.journal_impact,
          views_count: db_record.views_count,
          citation_count: db_record.citation_count,
          source_title: db_record.source_title,
          publication_year: db_record.publication_year
        )
      end

      def self.db_find_or_create(entity)
        Database::PublicationOrm.find_or_create(entity.content)
      end
    end
  end
end
