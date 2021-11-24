# frozen_string_literal: true

require 'dry-validation'

module PaperDeep
  module Forms
    class NewSearch < Dry::Validation::Contract
      URL_REGEX = /^[A-Za-z]+/.freeze

      params do
        required(:keyword).filled(:string)
      end

      rule(:keyword) do
        unless URL_REGEX.match?(value)
          key.failure('is an nonsense searching keyword')
        end
      end
    end
  end
end