# frozen_string_literal: true

require_relative '../../helpers/spec_helper'
require_relative '../../helpers/database_helper'
require_relative '../../helpers/vcr_helper'
require 'headless'
require 'webdrivers/chromedriver'
require "watir-webdriver/wait"
require 'watir'

describe 'Acceptance Tests' do
  before do
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    @browser = Watir::Browser.new :chrome, options: options
  end

  after do
    @browser.close
  end
  describe 'Homepage' do
    describe 'Visit Home page' do
      it '(HAPPY) should have search input and button' do
        # GIVEN: user is on the home page without any projects
        @browser.goto 'http:localhost:9090'
        # THEN: user should see basic headers, no projects and a welcome message
        _(@browser.title).must_equal 'Paper Deep'
        _(@browser.input(placeholder: 'Search Study Fields').present?).must_equal true
        _(@browser.button(text: 'Search').present?).must_equal true
        
      end
      it '(HAPPY) should have search result' do
        # GIVEN: user is on the home page without any projects
        @browser.goto 'http:localhost:9090'

        # WHEN:
        @browser.input(placeholder: 'Search Study Fields').set('blockchain')
        @browser.button(text: 'Search').click
        _(@browser.table.tds.length).must_equal 0
  
        Watir::Wait.until(timeout: 10) { @browser.table.tds.length == 150 }
        #then
        _(@browser.table.tds.length).must_equal 150
      end
    end
  end
end
