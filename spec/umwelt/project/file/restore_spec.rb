# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::Project::File::Restore do
  subject do
    interactor.call
  end
  let(:interactor) do
    Umwelt::Project::File::Restore.new(path: tmp)
  end

  let(:tmp) { 'tmp' }
  let(:path) { Pathname.pwd / tmp / 'project.json' }

  let(:project) { Fabricate(:project) }

  describe 'success' do
    before do
      Umwelt::Project::File::Store.new(path: tmp).call project
    end

    after do
      path.delete
    end

    it 'should be success' do
      _(subject.success?).must_equal true
    end

    it 'exposes history' do
      _(subject.struct).must_be_kind_of Struct::Project
      _(subject.struct).must_equal project
    end
  end

  describe 'when file is not exist' do
    let(:failed) { interactor.call }

    it 'should be failed' do
      _(failed.failure?).must_equal true
    end

    it 'fails with errors' do
      _(failed.errors).must_equal [
        "Failed reading #{Pathname.pwd}/tmp/project.json"
      ]
    end
  end
end
