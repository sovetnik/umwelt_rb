# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::Files::Episodes::Store do
  subject do
    interactor.call(phase_id, episode)
  end
  let(:interactor) do
    Umwelt::Files::Episodes::Store.new(path: tmp)
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
