# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'

require_relative '../../init'

ENV['RACK_ENV'] = 'test'

KEYWORD = 'blockchain'
EID = '2-s2.0-84979828304'
PID = '84979828304'
