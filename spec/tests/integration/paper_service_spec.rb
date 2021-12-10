# frozen_string_literal: true

require_relative '../../spec_helper.rb'

describe 'Integration test of AddPaper service and API gateway' do
  it 'must add a list of legitimate papers' do
    # WHEN we request to search papers
    search_request = PaperDeep::Forms::NewSearch.new.call({'keyword': KEYWORD})

    res = PaperDeep::Service::AddPaper.new.call(search_request)
    
    # THEN we should see a single project in the list
    _(res.success?).must_equal true
    _(res.value!['keyword']).must_equal KEYWORD
  end
  it 'must add a list of legitimate papers by EID' do
    # WHEN we request to search papers
    search_request = PaperDeep::Forms::NewSearch.new.call({'keyword': EID})

    res = PaperDeep::Service::AddPaper.new.call(search_request)
    
    # THEN we should see a single project in the list
    _(res.success?).must_equal true
  end
end
