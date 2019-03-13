# frozen_string_literal: true

require_relative '../../spec_helper'
require 'webmock/minitest'

describe Umwelt::History::Get do
  subject do
    interactor.call(23)
  end
  let(:interactor) do
    Umwelt::History::Get.new
  end

  let(:history_data) do
    Struct::History.new(
      project: project.to_h,
      phases: [phase.to_h]
    ).to_h
  end

  let(:history) do
    Struct::History.new(
      project: project,
      phases: [phase]
    )
  end

  let(:project) { Fabricate(:project) }

  let(:phase) do
    Struct::Phase.new(
      id: 13,
      parent_id: 5,
      merge_id: nil,
      user_id: 1,
      finished_at: Time.now.to_s,
      name: 'feature',
      description: 'implementing feature'
    )
  end

  let(:headers) do
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'User-Agent' => "Umwelt client #{Umwelt::VERSION}"
    }
  end

  describe 'when all is good' do
    before do
      stub_request(
        :get,
        'http://umwelt.dev/api/histories/23'
      ).with(
        headers: headers
      ).to_return(
        status: 200,
        body: JSON.generate(history_data),
        headers: {}
      )
    end

    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes history' do
      _(subject.history).must_be_kind_of Struct::History
      _(subject.history).must_equal history
    end
  end

  describe 'when project not found' do
    before do
      stub_request(
        :get, 'http://umwelt.dev/api/histories/23'
      ).with(
        headers: headers
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
        'Umwelt::History::Mapper',
        'wrong number of arguments (given 1, expected 0)',
        nil
      ]
    end
  end

  describe 'when project not found' do
    before do
      stub_request(
        :get,
        'http://umwelt.dev/api/histories/23'
      ).with(
        headers: headers
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
