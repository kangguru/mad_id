require 'spec_helper'

class Pony < ActiveRecord::Base
  include MadID
end

class LittlePony < Pony
  identify_with :pny
end

describe MadID do

  it 'inserts #identify_with' do
    expect(Pony.respond_to?(:identify_with)).to be(true)
  end

  it 'wont set any callbacks' do
    expect(Pony._create_callbacks.select {|cb| cb.filter == :set_identifier}).to be_empty
  end

  describe 'when #identify_with is called' do
    subject { LittlePony.new }

    it 'inserts the #set_identifier callback' do
      expect(LittlePony._create_callbacks.select {|cb| cb.filter == :set_identifier}).to have(1).item
    end

    describe '#to_param' do
      before { subject.set_identifier }
      it 'will return the identifier' do
        expect(subject.to_param).to eq(subject.identifier)
      end
    end

    describe '#short_identifier' do
      before { subject.set_identifier }
      it 'will shorten the identifier to the first 12 chars' do
        expect(subject.short_identifier).to eq(subject.identifier[0..11])
      end
    end

    describe '#identifier' do
      before { subject.set_identifier }
      it 'will start with the #identify_with argument' do
        expect(subject.identifier).to match(/pny-.+/)
      end
    end

    describe 'callbacks' do
      subject { LittlePony.new }

      it 'will set the identifier upon create' do
        expect{ subject.save! }.to change{ subject.identifier }.from(nil)
      end

      describe 'persisted object' do
        subject { LittlePony.create }

        it 'will not set the identifier upon update' do
          expect{ subject.save! }.not_to change{ subject.reload.identifier }
        end

        it 'makes identifier readonly' do
          expect{ subject.update(identifier: 'FOOBAR')}.not_to change{ subject.reload.identifier }
        end
      end
    end
  end

  describe 'Registry' do
    it 'includes identifiable objects with stringified key' do
      expect(MadID.registry).to include('pny' => LittlePony)
    end
  end
end
