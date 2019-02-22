# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::Semantic::Plain::Root do
  subject do
    described_class.new(node: tree.node(root.id))
  end

  let(:tree) do
    Umwelt::Tree::Fill.new.call [root]
  end

  let(:root) { Fabricate.build(:root, body: 'project_root', kind: 'root') }

  describe '#path' do
    it 'returnes relative path' do
      _(subject.path).must_equal Pathname.pwd / 'umwelt/lib/project_root.rb'
    end
  end

  describe '#code' do
    it 'returnes unparsed code' do
      _(subject.code).must_equal "module ProjectRoot\nend"
    end
  end

  describe '#ast' do
    it 'returnes ast of node' do
      _(subject.ast).must_equal s(
        :module,
        s(:const, nil, :ProjectRoot),
        nil
      )
    end

    it 'can be unparsed to' do
      _(Unparser.unparse(subject.ast))
        .must_equal "module ProjectRoot\nend"
    end
  end

  describe 'csymbol' do
    it 'returnes symbolized body' do
      _(subject.csymbol).must_equal :ProjectRoot
    end
  end
end
