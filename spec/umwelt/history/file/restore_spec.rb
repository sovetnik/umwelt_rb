# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::History::File::Restore do
  subject do
    interactor.call
  end

  let(:interactor) do
    Umwelt::History::File::Restore.new(path: tmp)
  end

  let(:tmp) { 'tmp' }
  let(:tmp_root) { Pathname.pwd / tmp }
  let(:path) { Pathname.pwd / tmp / 'history.json' }

  let(:project) do
    Fabricate(:project)
  end

  let(:phase) do
    Fabricate(:phase, finished_at: Time.now.to_s)
  end

  let(:history) do
    Struct::History.new(
      project: project,
      phases: [phase]
    )
  end

  describe 'success' do
    before do
      Umwelt::History::File::Store
        .new(path: tmp)
        .call(history)
    end

    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes history' do
      _(subject.struct).must_be_kind_of Struct::History
      _(subject.struct).must_equal history
    end

    after do
      path.delete
    end
  end

  describe 'when file is not exist' do
    it 'should be failed' do
      _(subject.failure?).must_equal true
    end

    it 'fails with errors' do
      _(subject.errors).must_equal [
        "Failed reading #{Pathname.pwd}/tmp/history.json"
      ]
    end
  end
end
