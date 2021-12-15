# frozen_string_literal: true

require_relative '../../helpers/acceptance_helper'
require_relative 'pages/home_page'

describe 'Homepage Acceptance Tests' do
  include PageObject::PageFactory

  before do
    DatabaseHelper.wipe_database
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    @browser = Watir::Browser.new :chrome, options: options
  end

  after do
    @browser.close
  end

  describe 'Visit Home page' do
    it '(HAPPY) should have search input and button' do
      # GIVEN: user has no projects
      # WHEN: they visit the home page
      visit HomePage do |page|
        # THEN: they should see basic headers, no projects and a welcome message
        _(page.home_page_title).must_equal 'Paper Search'
        _(page.search_bar_input_element.present?).must_equal true
        _(page.search_button_element.present?).must_equal true
      end
    end
    # rubocop:disable Layout/LineLength
    it '(HAPPY) should have search result' do
      # GIVEN: user has no projects
      # WHEN: they input keyword to search
      visit HomePage do |page|
        page.search('blockchain')
        # THEN: they should see search result
        Watir::Wait.until(timeout: 10) { page.num_results == 25 }
        _(page.num_results).must_equal 25
        _(page.table_cell_content(1, 5)).must_equal '1839'
        _(page.table_content(1)).must_equal '0 Blockchains and Smart Contracts for the Internet of Things Christidis K. NC State University Scopus link 1839'
      end
    end
    # rubocop:enable Layout/LineLength
  end
end
