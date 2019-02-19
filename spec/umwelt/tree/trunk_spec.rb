# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::Tree::Trunk do
  subject do
    Umwelt::Tree::Fill.new.call [root, parent, uncle, member]
  end

  let(:root) { Fabricate.build(:root, body: 'Project_root', kind: 'root') }
  let(:parent) { Fabricate.build(:parent, kind: 'space') }
  let(:uncle) { Fabricate.build(:uncle, kind: 'space') }
  let(:member) { Fabricate.build(:member, kind: 'space') }

  describe '#node(id)' do
    let(:node) { subject.node(member.id) }
    it 'returnes node' do
      _(node).must_be_kind_of Umwelt::Nodes::Base
    end

    it 'is a node' do
      _(node).must_be_instance_of Umwelt::Nodes::Space
    end
  end

  describe '#childs(id)' do
    let(:childs) { subject.childs(root.id) }
    it 'returnes node' do
      _(childs).must_be_kind_of Array
    end

    it 'includes childs nodes' do
      _(childs).must_include subject.node(parent.id)
      _(childs).must_include subject.node(uncle.id)
    end
  end
end
