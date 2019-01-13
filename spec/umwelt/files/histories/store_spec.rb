# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::Files::Histories::Store do
  subject do
    interactor.call(project_id, history)
  end
  let(:interactor) do
    Umwelt::Files::Histories::Store.new(path: tmp)
  end

  let(:tmp) { 'tmp/histories' }
  let(:path) { Pathname.pwd / tmp / "#{project_id}.json" }

  let(:project_id) { 42.to_s }

  let(:project) do
    { name: 'Helen',
      description: 'Durable Rubber Watch' }
  end

  let(:phase) do
    { id: 13,
      parent_id: 5,
      merge_id: nil,
      user_id: 1,
      finished_at: Time.now.to_s,
      name: 'zeta',
      description: 'Dank foetid gambrel antediluvian indescribable.' }
  end

  let(:history) do
    Struct::History.new(
      project: {},
      phases: [phase]
    )
  end

  let(:content) { JSON.pretty_generate history.to_h }

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
