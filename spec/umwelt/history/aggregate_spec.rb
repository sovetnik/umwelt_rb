# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::History::Aggregate do
  subject do
    interactor.call([episode_chaos, episode_discord])
  end

  let(:interactor) do
    Umwelt::History::Aggregate.new
  end

  let(:phase_chaos) { Fabricate(:chaos) }
  let(:phase_discord) { Fabricate(:discord) }

  # Fragments
  let(:root) { Fabricate(:root) }
  let(:parent) { Fabricate(:parent) }
  let(:uncle) { Fabricate(:uncle) }
  let(:member) { Fabricate(:member) }
  let(:sibling) { Fabricate(:sibling) }
  let(:cousin) { Fabricate(:cousin) }

  let(:episode_chaos) do
    Struct::Episode .new(
      phase: phase_chaos,
      engaged: [root, parent, uncle, cousin],
      forgotten: []
    )
  end
  let(:episode_discord) do
    Struct::Episode.new(
      phase: phase_discord,
      engaged: [member, sibling],
      forgotten: [uncle.id, cousin.id]
    )
  end

  let(:result_chaos) { Minitest::Mock.new }
  let(:result_discord) { Minitest::Mock.new }

  describe 'when continuity respected' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes engaged and not forgotten fragments from apisodes' do
      _(subject.fragments).must_be_instance_of Array
      _(subject.fragments).must_equal [
        root, parent, member, sibling
      ]
    end
  end

  describe 'when episode cannot be readen from file' do
    let(:episode_chaos) do
      Struct::Episode .new(
        phase: phase_chaos,
        engaged: [root, parent, uncle, cousin],
        forgotten: [0]
      )
    end

    it 'should be failed' do
      _(subject.failure?).must_equal true
    end

    it 'fails with errors' do
      _(subject.errors).must_equal [
        'Aggregate failed: fantom ids: [0]'
      ]
    end
  end
end
