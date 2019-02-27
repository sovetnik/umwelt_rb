# frozen_string_literal: true

require_relative '../../spec_helper'
describe Umwelt::Tree::Imprint do
  subject do
    Umwelt::Tree::Imprint.new(trunk, location: temp).call(:Plain)
  end

  let(:trunk) do
    Umwelt::Tree::Fill.new.call [parent, member]
  end

  let(:temp) { 'tmp' }

  let(:parent) { Fabricate.build(:root, body: 'parent', kind: 'root') }
  let(:member) do
    Fabricate.build(:member, kind: 'space', context_id: parent.id)
  end

  let(:parent_code) { trunk.node(parent.id).semantic(:Plain).code }
  let(:member_code) { trunk.node(member.id).semantic(:Plain).code }

  let(:parent_path) do
    trunk.node(parent.id).semantic(:Plain).path(location: temp)
  end
  let(:member_path) do
    trunk.node(member.id).semantic(:Plain).path(location: temp)
  end

  let(:temp_root) { Pathname.pwd / temp }

  after do
    temp_root.rmtree
  end

  describe 'when location is clean' do
    it 'writes code from tree to files' do
      _(parent_path.exist?).must_equal false
      _(member_path.exist?).must_equal false

      subject

      _(parent_path.exist?).must_equal true
      _(member_path.exist?).must_equal true

      _(parent_path.read).must_equal parent_code
      _(member_path.read).must_equal member_code

      _(subject.written_paths).must_equal [
        { parent_path => 17 },
        { member_path => 25 }
      ]
    end
  end

  describe 'when we has a file in location' do
    before do
      FileUtils.mkpath member_path.dirname
      member_path.write member_code
    end

    it 'returnes errors' do
      _(subject.failure?).must_equal true
      _(subject.errors.first).must_equal <<~WARN_MESSAGE
        #{temp_root} contain files.
        Try use another --target, or delete them.
      WARN_MESSAGE
    end
  end
end
