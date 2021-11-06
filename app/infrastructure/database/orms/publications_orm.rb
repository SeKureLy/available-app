# frozen_string_literal: true

require 'sequel'

module PaperDeep
  module Database
    # Object-Relational Mapper for Members
    class PublicationOrm < Sequel::Model(:publications)
      #   @strict_param_setting = false
      #   需要加上one to one the relation
      plugin :timestamps, update_on_create: true

      def self.find_or_create(publication_info)
        first(title: publication_info[:publicationId]) || create(publication_info)
      end
    end
  end
end
