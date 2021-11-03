# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:papers) do
      primary_key :id

      String      :eid, unique: true, null: true
      String      :title, unique: true, null: true
      String      :paper_link, unique: true, null: false
      String      :citedby_link, unique: true, null: false
      String      :publication_name, unique: true, null: false
      String      :date, unique: true, null: false
      String      :organization, unique: true, null: false
      String      :author, unique: true, null: false

      Integer     :citedby

      DateTime :created_at
      DateTime :updated_at
    end
  end
end