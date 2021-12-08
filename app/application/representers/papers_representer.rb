# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'paper_representer'

module PaperDeep
  module Representer
    # Represents list of projects for API output
    class PaperList < Roar::Decorator
      include Roar::JSON

      collection :papers, extend: Representer::Paper
    end
  end
end