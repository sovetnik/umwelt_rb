# frozen_string_literal: true

require_relative '../../spec_helper'
describe Umwelt::Command::Convey do
  subject do
    Umwelt::Command::Convey.new.call(
      phase_id: 7,
      semantic: :Plain,
      source: examples,
      target: temp
    )
  end

  let(:examples) { 'spec/examples' }
  let(:temp) { 'temp' }

  let(:temp_root) { Pathname.pwd / temp }

  describe 'restore history from examples' do
    let(:history) do
      Umwelt::History::File::Restore
        .new(path: examples)
        .call
    end

    it 'should be success' do
      _(history.success?).must_equal true
    end

    it 'exposes history' do
      _(history.struct).must_be_kind_of Struct::History
    end
  end

  describe 'writes code from tree to files' do
    after do
      temp_root.rmtree
      pp temp_root.entries if temp_root.exist?
    end

    it 'exposes written_paths' do
      _(subject.written_paths).must_equal Hash[
         temp_root / 'example/alfa_alive/gamma_alive/zeta_one.rb' => 50,
         temp_root / 'example/alfa_alive/gamma_alive/delta_alive.rb' => 53,
         temp_root / 'example/alfa_theta/gamma_theta/delta_theta.rb' => 53,
         temp_root / 'example/alfa_alive/gamma_alive.rb' => 41,
         temp_root / 'example/alfa_theta/gamma_theta.rb' => 41,
         temp_root / 'example/alfa_alive.rb' => 29,
         temp_root / 'example/alfa_beta.rb' => 28,
         temp_root / 'example/alfa_epsilon.rb' => 31,
         temp_root / 'example/alfa_theta.rb' => 29,
         temp_root / 'example.rb' => 18
      ]
    end
  end
end
