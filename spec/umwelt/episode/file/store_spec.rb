# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::Episode::File::Store do
  subject do
    interactor.call(phase_id, episode)
  end
  let(:interactor) do
    Umwelt::Episode::File::Store.new(path: tmp)
  end

  let(:tmp) { 'tmp/episodes' }
  let(:path) { Pathname.pwd / tmp / "#{phase_id}.json" }

  let(:phase_id) { 13 }

  let(:finished) { Time.now }

  let(:phase) do
    Struct::Phase.new(
      id: 13,
      parent_id: 5,
      merge_id: nil,
      user_id: 1,
      finished_at: Time,
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

  let(:content) { JSON.pretty_generate episode_data }

  after do
    path.delete
  end

  describe 'success' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it ' store episode in file' do
      _(path.exist?).must_equal false
      subject
      _(path.exist?).must_equal true
    end

    it 'store in JSON pretty' do
      subject
      _(path.read).must_be_kind_of String
      _(path.read).must_equal content
    end
  end
end