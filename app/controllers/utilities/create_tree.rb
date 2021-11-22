# frozen_string_literal: true

# require_relative '../../init'
# require_relative '../../config/environment'
require 'json'

# PaperDeep Module
module PaperDeep
  # Utilities Module to add feature
  module Utilities
    # create citation tree class
    class CreateCitationTree
      def initialize(gateway, root_paper)
        @root_paper = root_paper
        @gateway = gateway  # PaperMapper instance
        @content = {}
      end

      def create
        @tree_content = {
          content: { NodeName: @root_paper[:title], link: @root_paper[:paper_link], eid: @root_paper[:eid] },
          next: []
        }

        create_tree(@tree_content, 0)
        nil
      end

      def create_tree(subtree, height)
        return [] if height == 3

        @gateway.search(subtree[:content][:eid])
        parsed = @gateway.parse.first(3)

        subtree[:next][0] = {
          content: { NodeName: parsed[0][:title], link: parsed[0][:paper_link], eid: parsed[0][:eid] },
          next: []
        }
        subtree[:next][1] = {
          content: { NodeName: parsed[1][:title], link: parsed[1][:paper_link], eid: parsed[1][:eid] },
          next: []
        }
        subtree[:next][2] = {
          content: { NodeName: parsed[2][:title], link: parsed[2][:paper_link], eid: parsed[2][:eid] },
          next: []
        }

        create_tree(subtree[:next][0], height + 1)
        create_tree(subtree[:next][1], height + 1)
        create_tree(subtree[:next][2], height + 1)
      end

      def return_tree
        @tree_content
      end
    end
  end
end
