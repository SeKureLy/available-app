# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:publications) do
      primary_key  :id

      # pid equals to publication_id
      String      :pid, unique: true, null: false
      Float        :journal_impact, unique: false, null: false
      Integer      :views_count, unique: false, null: false
      Integer      :citation_count, unique: false, null: false
      Integer      :publication_year, unique: false, null: true
      String       :source_title, unique: false, null: true

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
