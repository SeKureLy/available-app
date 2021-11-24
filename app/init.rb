# frozen_string_literal: true

%w[domain application infrastructure presentation].each do |folder|
  require_relative "#{folder}/init.rb"
end
