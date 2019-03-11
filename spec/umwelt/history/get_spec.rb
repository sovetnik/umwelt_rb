# frozen_string_literal: true

require_relative '../../spec_helper'
require 'webmock/minitest'

describe Umwelt::Episode::Get do
  subject do
    interactor.call(phase.id)
  end
  let(:interactor) do
    Umwelt::Episode::Get.new
  end

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

  let(:fragment) do
    Struct::Fragment.new(
      id: 4,
      abstract_id: 3,
      context_id: 2,
      kind: 'space',
      body: 'member',
      note: 'description of member'
    )
  end

  let(:episode) do
    Struct::Episode.new(
      phase: phase,
      engaged: [fragment],
      forgotten: [42]
    )
  end

  let(:episode_data) do
    Struct::Episode.new(
      phase: phase.to_h,
      engaged: [fragment.to_h],
      forgotten: [42]
    ).to_h
  end

  describe 'when all is good' do
    before do
      stub_request(
        :get,
        'http://umwelt.dev/api/episodes/13'
      ).with(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent' => 'Umwelt client 0.1.1'
        }
      ).to_return(
        status: 200,
        body: JSON.generate(episode_data),
        headers: {}
      )
    end

    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes episode' do
      _(subject.episode).must_be_kind_of Struct::Episode
      _(subject.episode).must_equal episode
    end
  end

  describe 'when project not found' do
    before do
      stub_request(
        :get,
        'http://umwelt.dev/api/episodes/13'
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
        'Umwelt::Episode::Mapper',
        'wrong number of arguments (given 1, expected 0)',
        nil
      ]
    end
  end

  describe 'when phase not found' do
    before do
      stub_request(
        :get,
        'http://umwelt.dev/api/episodes/13'
      ).with(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent' => 'Umwelt client 0.1.1'
        }
      ).to_return(
        status: 404,
        body: JSON.generate(Hash[errors: ['No phase found']]),
        headers: {}
      )
    end

    it 'should be failed' do
      _(subject.failure?).must_equal true
    end
    it 'fails with errors' do
      _(subject.errors).must_equal [
        'No phase found'
      ]
    end
  end
end
