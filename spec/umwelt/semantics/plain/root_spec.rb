# frozen_string_literal: true

require_relative '../../../spec_helper'

describe Umwelt::Semantics::Plain::Root do
  subject do
    described_class.new(node: tree.node(root.id))
  end

  let(:tree) do
    Umwelt::Tree::Fill.new.call [root]
  end

  let(:root) { Fabricate.build(:root, body: 'project_root', kind: 'root') }

  describe '#path' do
    it 'returnes relative path' do
      _(subject.path).must_equal Pathname.new('project_root.rb')
    end
  end

  describe '#to_ast' do
    let(:ast) { subject.to_ast }
    it 'returnes ast node' do
      _(ast).must_equal s(
        :module,
        s(:const, nil, :ProjectRoot),
        nil
      )
    end

    it 'can be unparsed to' do
      _(Unparser.unparse(ast))
        .must_equal "module ProjectRoot\nend"
    end
  end

  describe 'csymbol' do
    it 'returnes symbolized body' do
      _(subject.csymbol).must_equal :ProjectRoot
    end
  end
end
