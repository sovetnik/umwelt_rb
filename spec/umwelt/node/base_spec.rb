# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::Node::Base do
  subject { tree.node(member.id) }

  let(:tree) do
    Umwelt::Tree::Fill.new.call [root, parent, uncle, member]
  end

  let(:root) { Fabricate.build(:root, body: 'Project_root', kind: 'root') }
  let(:parent) { Fabricate.build(:parent, kind: 'space') }
  let(:uncle) { Fabricate.build(:uncle, kind: 'space') }
  let(:member) { Fabricate.build(:member, kind: 'space') }

  describe '#ancestry' do
    it 'returnes collection of ancestors' do
      _(subject.ancestry).must_equal [
        tree.node(root.id),
        tree.node(parent.id),
        tree.node(member.id)
      ]
    end
  end

  describe '#context' do
    it 'returnes node of context' do
      _(subject.context).must_equal tree.node(parent.id)
    end
  end

  describe 'semantic' do
    let(:semantic) { subject.semantic(:Plain) }
    it 'returnes node' do
      _(subject).must_be_kind_of described_class
    end

    it 'which builds semantic' do
      _(semantic).must_be_kind_of Umwelt::Semantic::Base
    end

    it 'which actually a semantic subclass' do
      _(semantic).must_be_instance_of Umwelt::Semantic::Plain::Space
    end
  end
end
