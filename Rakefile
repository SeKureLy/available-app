# frozen_string_literal: true

require 'rake/testtask'
require './require_app'

task :default do
  puts `rake -T`
end

desc 'Run unit and integration tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/tests/{integration,unit}/**/*_spec.rb'
  t.warning = false
end

desc 'Run all tests'
Rake::TestTask.new(:spec_all) do |t|
  t.pattern = 'spec/tests/**/*_spec.rb'
  t.warning = false
end

desc 'Keep rerunning unit/integration tests upon changes'
task :respec do
  sh "rerun -c 'rake spec' --ignore 'coverage/*'"
end

desc 'Run acceptance tests'
task :spec_accept do
  puts 'NOTE: run app in test environment in another process'
  # front-end build in a test version
  # sh ' cd app/presentation/react/ && npm test && cd ../../../'
  sh 'bash spec/acceptance_test'
end

# # NOTE: run `rake run:test` in another process
# desc 'Run acceptance tests'
# Rake::TestTask.new(:spec_accept) do |t|
#   t.pattern = 'spec/tests/acceptance/*_spec.rb'
#   t.warning = false
# end

desc 'Keep restarting web app upon changes'
task :rerack do
  sh "rerun -c rackup -p 9292 --ignore 'coverage/*'"
end

namespace :run do
  # Run in development mode
  desc 'Run Web App in development mode'
  task :dev do
    sh 'rerun -c "rackup -p 9292"'
  end

  # task :test do
  #   sh 'RACK_ENV=test rackup -p 9000'
  # end
end

task :load_lib do
  require_app('lib')
end

namespace :generate do
  desc 'Create rbnacl key'
  task msg_key: :load_lib do
    puts "New MSG_KEY (base64): #{SecureMessage.generate_key}"
  end

  desc 'Create cookie secret'
  task session_secret: :load_lib do
    puts "New SESSION_SECRET (base64): #{SecureSession.generate_secret}"
  end
end

desc 'Run application console'
task :console do
  sh 'pry -r ./init'
end

namespace :quality do
  only_app = 'config/ app/'

  desc 'run all static-analysis quality checks'
  task all: %i[rubocop reek flog]

  desc 'code style linter'
  task :rubocop do
    sh 'rubocop -A'
  end

  desc 'code smell detector'
  task :reek do
    sh 'reek'
  end

  desc 'complexiy analysis'
  task :flog do
    sh "flog #{only_app}"
  end
end
