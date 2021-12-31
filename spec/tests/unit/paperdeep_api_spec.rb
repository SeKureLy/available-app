# frozen_string_literal: true

require_relative '../../spec_helper'

describe 'Unit test of PaperDeep API gateway' do
  it 'must report alive status' do
    alive = PaperDeep::Gateway::Api.new(PaperDeep::App.config).alive?
    _(alive).must_equal true
  end

  it 'must be able to search for papers with keyword' do
    res = PaperDeep::Gateway::Api.new(PaperDeep::App.config)
      .paper({ keyword: KEYWORD })

    _(res.success?).must_equal true
    _(res.payload).must_include KEYWORD
  end

  it 'must be able to search for papers with EID' do
    res = PaperDeep::Gateway::Api.new(PaperDeep::App.config)
      .paper({ eid: EID })

    _(res.success?).must_equal true
  end

  it 'must be able to search for publications' do
    res = PaperDeep::Gateway::Api.new(PaperDeep::App.config)
      .publication({ pid: PID })

    _(res.success?).must_equal true
    _(res.payload).must_include PID
  end

  it 'must be able to return all db papers' do
    # GIVEN a list of papers is added into the database
    PaperDeep::Gateway::Api.new(PaperDeep::App.config)
      .paper({ keyword: KEYWORD })

    # WHEN we request the papers
    res = PaperDeep::Gateway::Api.new(PaperDeep::App.config)
      .db_paper

    # THEN we should see the very EID in the list of papers
    _(res.success?).must_equal true
    _(res.payload).must_include EID
  end

  it 'must be able to return db publications' do
    # GIVEN a publication is added into the database
    PaperDeep::Gateway::Api.new(PaperDeep::App.config)
      .publication({ pid: PID })

    # WHEN we request the publications
    res = PaperDeep::Gateway::Api.new(PaperDeep::App.config)
      .db_publication(EID)

    # THEN we should see the very PID in the list of publications
    _(res.success?).must_equal true
    _(res.payload).must_include PID
  end
end
