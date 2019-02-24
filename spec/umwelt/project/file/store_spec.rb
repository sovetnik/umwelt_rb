# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::Project::File::Store do
  subject do
    interactor.call(project)
  end
  let(:interactor) do
    Umwelt::Project::File::Store.new(path: tmp)
  end

  let(:tmp) { 'tmp' }
  let(:path) { Pathname.pwd / tmp / 'project.json' }

  let(:project) { Fabricate(:project) }

  let(:content) { JSON.pretty_generate project.to_h }

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
