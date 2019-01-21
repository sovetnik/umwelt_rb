# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::Mappers::Episode do
  subject do
    interactor.call(episode_data)
  end

  let(:interactor) do
    Umwelt::Mappers::Episode .new
  end

  let(:episode_data) do
    Struct::Episode.new(
      phase: phase.to_h,
      engaged: [fragment.to_h],
      forgotten: 23
    ).to_h
  end

  let(:episode) do
    Struct::Episode.new(
      phase: phase,
      engaged: [fragment],
      forgotten: 23
    )
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
      id: 13,
      abstract_id: 5,
      context_id: nil,
      kind: 'space',
      body: 'foo',
      note: 'foo bar baz'
    )
  end

  describe 'when data is good' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes episode' do
      _(subject.struct).must_be_kind_of Struct::Episode
      _(subject.struct).must_equal episode
    end
  end

  describe 'when data is wrong' do
    let(:failed) do
      interactor.call(
        phase: {},
        engaged: [{ shit: :happens }],
        forgotten: [1, 2]
      )
    end

    it 'should be failed' do
      _(failed.failure?).must_equal true
    end

    it 'fails with errors' do
      _(failed.errors).must_equal [
        'Episode',
        'unknown keywords: shit',
        { shit: :happens }
      ]
    end
  end
end
