# frozen_string_literal: true

require_relative '../../spec_helper'

describe Umwelt::Semantics::Imprint do
  subject { tree.node(member.id).imprint(:Plain) }

  let(:tree) do
    Umwelt::Tree::Fill.new.call [root, parent, uncle, member]
  end

  let(:root) { Fabricate.build(:root, body: 'Project_root', kind: 'root') }
  let(:parent) { Fabricate.build(:parent, kind: 'space') }
  let(:uncle) { Fabricate.build(:uncle, kind: 'space') }
  let(:member) { Fabricate.build(:member, kind: 'space') }

  describe '#context' do
    let(:element) { tree.node(member.id) }
    it 'returnes context of element' do
      _(subject.context.body).must_equal parent.body
      _(subject.context).must_be_instance_of Umwelt::Semantics::Plain::Space
    end
  end

  describe 'node' do
    it 'returnes node' do
      _(subject).must_be_kind_of described_class
    end

    it 'returnes node' do
      _(subject).must_be_instance_of Umwelt::Semantics::Plain::Space
    end
  end
end
