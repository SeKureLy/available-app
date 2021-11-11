# frozen_string_literal: true

folders = %w[paper_search publication_search database]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
