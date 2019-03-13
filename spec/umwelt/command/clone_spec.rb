# frozen_string_literal: true

require_relative '../../spec_helper'
require 'webmock/minitest'

describe Umwelt::Command::Clone do
  subject do
    Umwelt::Command::Clone
      .new(path: umwelt_root)
      .call(user_project: 'genry/ford')
  end

  let(:umwelt_root) { Pathname.pwd / 'tmp' }
  let(:examples) { Pathname.pwd / 'spec/examples' }
  let(:headers) do
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'User-Agent' => "Umwelt client #{Umwelt::VERSION}"
    }
  end

  before do
    stub_request(
      :get,
      'http://umwelt.dev/api/projects/find?project_name=ford&user_name=genry'
    ).with(
      headers: headers
    ).to_return(
      status: 200,
      body: (examples / 'project.json').read,
      headers: {}
    )

    stub_request(:get, 'http://umwelt.dev/api/histories/1')
      .with(
        headers: headers
      ).to_return(
        status: 200,
        body: (examples / 'short_history.json').read,
        headers: {}
      )

    stub_request(:get, 'http://umwelt.dev/api/episodes/1')
      .with(
        headers: headers
      ).to_return(
        status: 200,
        body: (examples / 'episodes/1.json').read,
        headers: {}
      )

    stub_request(:get, 'http://umwelt.dev/api/episodes/2')
      .with(
        headers: headers
      ).to_return(
        status: 200,
        body: (examples / 'episodes/2.json'),
        headers: {}
      )
  end

  let(:paths) { subject.written_paths.keys }

  after do
    umwelt_root.rmtree
  end

  describe 'get only new episodes' do
    before do
      (umwelt_root / 'episodes').mkpath
      (umwelt_root / 'episodes/1.json').write(
        (examples / 'episodes/1.json').read
      )
    end

    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes written_paths' do
      _(paths).must_include umwelt_root / 'project.json'
      _(paths).must_include umwelt_root / 'history.json'
      _(paths).must_include umwelt_root / 'episodes/2.json'
    end

    it 'dont write existing episodes' do
      _(paths).wont_include umwelt_root / 'episodes/1.json'
    end
  end

  describe 'clone umwelt from remote' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes written_paths' do
      _(paths).must_include umwelt_root / 'project.json'
      _(paths).must_include umwelt_root / 'history.json'
      _(paths).must_include umwelt_root / 'episodes/1.json'
      _(paths).must_include umwelt_root / 'episodes/2.json'
    end
  end
end
