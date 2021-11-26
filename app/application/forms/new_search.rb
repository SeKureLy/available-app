# frozen_string_literal: true

require 'dry-validation'

module PaperDeep
  module Forms
    # search query param regular expression
    class NewSearch < Dry::Validation::Contract
      KEYWORD_REGEX = /^[A-Za-z]+ || {2-s2\.0-\d+}/

      params do
        required(:keyword).filled(:string)
      end

      rule(:keyword) do
        key.failure('is an nonsense searching keyword') unless KEYWORD_REGEX.match?(value)
      end
    end
  end
end
