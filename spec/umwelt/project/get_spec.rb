# frozen_string_literal: true

require_relative '../../spec_helper'
require 'webmock/minitest'

describe Umwelt::Project::Get do
  subject do
    interactor.call(
      project_name: 'genry', user_name: 'ford'
    )
  end

  let(:interactor) do
    Umwelt::Project::Get.new
  end

  let(:project) { Fabricate(:project) }

  describe 'when all is good' do
    before do
      # stub_request(:get, 'http://localhost:2300/api/histories/23')
      stub_request(
        :get,
        'http://umwelt.dev/api/projects/find?project_name=genry&user_name=ford'
      ).with(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent' => 'Umwelt client 0.1.1'
        }
      ).to_return(
        status: 200,
        body: JSON.generate(project.to_h),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent' => 'Umwelt client 0.1.1'
        }
      )
    end

    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes project' do
      _(subject.project).must_be_kind_of Struct::Project
      _(subject.project).must_equal project
    end
  end

  describe 'when data is wrong' do
    before do
      stub_request(
        :get,
        'http://umwelt.dev/api/projects/find?project_name=genry&user_name=ford'
      ).with(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent' => 'Umwelt client 0.1.1'
        }
      ).to_return(
        status: 200,
        body: JSON.generate(shit: :happens),
        headers: {}
      )
    end

    it 'should be failed' do
      _(subject.failure?).must_equal true
    end

    it 'fails with errors' do
      _(subject.errors).must_equal [
        'Umwelt::Project::Mapper',
        'unknown keywords: shit',
        { shit: 'happens' }
      ]
    end
  end

  describe 'when project not found' do
    before do
      stub_request(
        :get,
        'http://umwelt.dev/api/projects/find?project_name=genry&user_name=ford'
      ).with(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent' => 'Umwelt client 0.1.1'
        }
      ).to_return(
        status: 404,
        body: JSON.generate(Hash[errors: ['No project found']]),
        headers: {}
      )
    end

    it 'should be failed' do
      _(subject.failure?).must_equal true
    end
    it 'fails with errors' do
      _(subject.errors).must_equal [
        'No project found'
      ]
    end
  end
end
