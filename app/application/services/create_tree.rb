# frozen_string_literal: true

# require_relative '../../init'
# require_relative '../../config/environment'
require 'json'

# PaperDeep Module
module PaperDeep
  # Utilities Module to add feature
  module Service
    # create citation tree class
    class CreateCitationTree
      def initialize(gateway, root_paper)
        @root_paper = root_paper
        @gateway = gateway # PaperMapper instance
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

      def node_content(subtree)
        @gateway.search(subtree[:content][:eid])
        parsed = @gateway.parse.first(3)

        subtree[:next] = (0..2).map do |index|
          { content:
            { NodeName: parsed[index][:title], link: parsed[index][:paper_link], eid: parsed[index][:eid] },
            next: [] }
        end
      end

      def create_tree(subtree, height)
        return [] if height == 3

        node_content(subtree)

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
