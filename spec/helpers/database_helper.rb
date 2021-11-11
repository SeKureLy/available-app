# frozen_string_literal: true

# Helper to clean database during test runs
module DatabaseHelper
  # Deliberately :reek:DuplicateMethodCall on App.DB
  def self.wipe_database
    # Ignore foreign key constraints when wiping tables
    PaperDeep::App.DB.run('PRAGMA foreign_keys = OFF')
    PaperDeep::Database::PaperOrm.map(&:destroy)
    PaperDeep::App.DB.run('PRAGMA foreign_keys = ON')
  end
end
