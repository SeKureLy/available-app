# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/gs_api'

describe 'Tests Github API library' do
    describe 'Project information' do
      it 'HAPPY: should provide correct project attributes' do
        project = CodePraise::GithubApi.new(GITHUB_TOKEN)
                                       .project(USERNAME, PROJECT_NAME)
        _(project.size).must_equal CORRECT['size']
        _(project.git_url).must_equal CORRECT['git_url']
      end
    end
end
