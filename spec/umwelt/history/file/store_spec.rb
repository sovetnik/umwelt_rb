# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::History::File::Store do
  subject do
    interactor.call(history)
  end
  let(:interactor) do
    Umwelt::History::File::Store.new(path: tmp)
  end

  let(:tmp) { 'tmp' }
  let(:path) { Pathname.pwd / tmp / 'history.json' }

  let(:project) { Fabricate(:project) }

  let(:finished) { Time.now }

  let(:phase) do
    Struct::Phase.new(
      id: 13,
      parent_id: 5,
      merge_id: nil,
      user_id: 1,
      finished_at: finished,
      name: 'feature',
      description: 'implementing feature'
    )
  end

  let(:history) do
    Struct::History.new(
      project: project,
      phases: [phase]
    )
  end

  let(:history_data) do
    Struct::History.new(
      project: project.to_h,
      phases: [phase.to_h]
    ).to_h
  end

  let(:content) { JSON.pretty_generate history_data }

  after do
    path.delete
  end

  describe 'success' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it ' store history in file' do
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
