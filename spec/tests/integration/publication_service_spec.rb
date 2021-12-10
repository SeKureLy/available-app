# frozen_string_literal: true

require_relative '../../spec_helper.rb'

describe 'Integration test of SearchPublication service and API gateway' do
  it 'must add a list of legitimate publications' do
    # WHEN we request to search papers
    res = PaperDeep::Service::SearchPublication.new.call({'PID': PID})
    
    # THEN we should see a single project in the list
    _(res.success?).must_equal true
  end
end
