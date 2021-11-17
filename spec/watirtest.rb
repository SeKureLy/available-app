# frozen_string_literal: true

require_relative './helpers/spec_helper'
require_relative './helpers/database_helper'
require_relative './helpers/vcr_helper'
require 'headless'
require 'webdrivers/chromedriver'
require 'watir'

describe 'Acceptance Tests' do
  before do
    # DatabaseHelper.wipe_database
    # @headless = Headless.new
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    @browser = Watir::Browser.new :chrome, :options => options
  end

  after do
    # @browser.close
    # @headless.destroy
  end
  describe 'Homepage' do
    describe 'Visit Home page' do
      it '(HAPPY) should not see projects if none created' do
        # GIVEN: user is on the home page without any projects
        @browser.goto "http:localhost:9292"
        # THEN: user should see basic headers, no projects and a welcome message
        # puts (@browser.h1.text)
        _(@browser.title).must_equal 'Paper Deep'
      end
    end
  end
end