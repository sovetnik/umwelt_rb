# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::Episode::File::Store do
  subject do
    interactor.call(phase_id, episode)
  end
  let(:interactor) do
    Umwelt::Episode::File::Store.new(path: tmp)
  end

  let(:tmp) { 'tmp' }
  let(:tmp_root) { Pathname.pwd / tmp }
  let(:path) { Pathname.pwd / tmp / "episodes/#{phase_id}.json" }

  let(:phase_id) { 13 }

  let(:finished) { Time.now }

  let(:phase) { Fabricate(:phase) }
  let(:fragment) { Fabricate(:fragment) }

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
    tmp_root.rmtree
  end

  describe 'success' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it ' store episode in file' do
      _(path.exist?).must_equal false
      _(subject.written_paths.keys).must_include path
      _(path.exist?).must_equal true
    end

    it 'store in JSON pretty' do
      subject
      _(path.read).must_be_kind_of String
      _(path.read).must_equal content
    end
  end
end
