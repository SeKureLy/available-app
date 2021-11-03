# frozen_string_literal: true

require 'sequel'

module PaperDeep
  module Database
    # Object-Relational Mapper for Members
    class PaperOrm < Sequel::Model(:papers)
    #   one_to_many :owned_projects,
    #               class: :'CodePraise::Database::ProjectOrm',
    #               key: :owner_id

    #   many_to_many :contributed_projects,
    #                class: :'CodePraise::Database::ProjectOrm',
    #                join_table: :projects_members,
    #                left_key: :member_id, right_key: :project_id

      plugin :timestamps, update_on_create: true

      def self.find_or_create(paper_info)
        first(title: paper_info[:tile]) || create(paper_info)
      end
    end
  end
end