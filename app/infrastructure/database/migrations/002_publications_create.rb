# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:publications) do
      primary_key :id
      # 感覺錯錯的
      # foreign_key  :publicationId, :papers
      
      Integer      :publicationId, unique: true, null: false
      Float        :journalImpact, unique: false, null: false
      Integer      :viewsCount, unique: false, null: false
      Integer      :citationCount, unique: false, null: false
      Integer      :publicationYear, unique: false, null: true
      String       :sourceTitle, unique: false, null: true

      DateTime :created_at
      DateTime :updated_at
    end
  end
end