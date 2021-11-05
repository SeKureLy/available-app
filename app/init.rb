# frozen_string_literal: true

%w[models controllers infrastructure].each do |folder|
  require_relative "#{folder}/init.rb"
end
