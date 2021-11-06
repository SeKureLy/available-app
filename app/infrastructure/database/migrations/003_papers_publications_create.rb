# frozen_string_literal: true

require 'sequel'

# 不確定這個檔案有沒有用
Sequel.migration do
  change do
    create_table(:papers_publications) do
      primary_key [:publication_id]
      foreign_key :publication_id, :papers
      foreign_key :publicationId, :publications

      index [:publication_id]
    end
  end
end