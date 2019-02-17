# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::History::File::Restore do
  subject do
    interactor.call(project_id)
  end
  let(:interactor) do
    Umwelt::History::File::Restore.new(path: tmp)
  end

  let(:tmp) { 'tmp/histories' }
  let(:path) { Pathname.pwd / tmp / "#{project_id}.json" }

  let(:project_id) { 42.to_s }

  let(:project) do
    Fabricate(:project)
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

  let(:history) do
    Struct::History.new(
      project: project,
      phases: [phase]
    )
  end

  before do
    Umwelt::History::File::Store
      .new(path: tmp)
      .call(project_id, history)
  end

  after do
    path.delete
  end

  describe 'success' do
    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes history' do
      _(subject.struct).must_be_kind_of Struct::History
      _(subject.struct).must_equal history
    end
  end

  describe 'when file is not exist' do
    let(:failed) { interactor.call(23) }

    it 'should be failed' do
      _(failed.failure?).must_equal true
    end

    it 'fails with errors' do
      _(failed.errors).must_equal [
        "Failed reading #{Pathname.pwd}/tmp/histories/23.json"
      ]
    end
  end
end
