# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::Files::Episodes::Restore do
  subject do
    interactor.call(phase_id)
  end
  let(:interactor) do
    Umwelt::Files::Episodes::Restore.new(path: tmp)
  end

  let(:tmp) { 'tmp/episodes' }
  let(:path) { Pathname.pwd / tmp / "#{phase_id}.json" }

  let(:phase_id) { 13 }

  let(:phase) do
    { id: 13,
      parent_id: 5,
      merge_id: nil,
      user_id: 1,
      finished_at: Time.now.to_s,
      name: 'zeta',
      description: 'Dank foetid gambrel antediluvian indescribable.' }
  end

  let(:fragment) do
    { id: 4,
      abstract_id: 3,
      context_id: 2,
      kind: 'space',
      body: 'member',
      note: 'description of member' }
  end

  let(:episode) do
    Struct::Episode.new(
      phase: phase,
      engaged: [fragment],
      forgotten: [42]
    )
  end

  let(:content) { JSON.pretty_generate episode.to_h }

  before do
    Umwelt::Files::Episodes::Store.new(path: tmp).call(phase_id, episode)
  end

  after do
    path.delete
  end

  describe 'success' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes episode' do
      _(subject.struct).must_be_kind_of Struct::Episode
      _(subject.struct).must_equal episode
    end
  end

  describe 'when file is not exist' do
    let(:failed) { interactor.call(23) }

    it 'should be failed' do
      _(failed.failure?).must_equal true
    end
    it 'fails with errors' do
      _(failed.errors).must_equal [
        "Failed reading #{Pathname.pwd}/tmp/episodes/23.json"
      ]
    end
  end
end
