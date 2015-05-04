require 'spec_helper'

class Pony < ActiveRecord::Base
  include MadID
end

class LittlePony < Pony
  identify_with :pny
end

class GreatPony < Pony
  identify_with :grtpny, to_param: false
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

  describe "to param" do
    let!(:little_pony) { LittlePony.create }
    let!(:great_pony) { GreatPony.create }

    it do
      expect(little_pony.to_param).to eql(little_pony.identifier)
      expect(great_pony.to_param).to eql(great_pony.id.to_s)
    end
  end

  describe 'Registry' do
    it 'includes identifiable objects with stringified key' do
      expect(MadID.registry).to include('pny' => LittlePony)
    end
  end

  describe 'Locator' do
    let!(:little_pony) { LittlePony.create }
    let!(:great_pony) { GreatPony.create }

    describe 'locate' do
      it 'locate the little pony just by the identifier' do
        expect(MadID.locate(little_pony.identifier)).to eq(little_pony)
      end

      it 'locate the great pony just by the identifier' do
        expect(MadID.locate(great_pony.identifier)).to eq(great_pony)
      end

      it 'returns nil if no klass is found for the identifier' do
        expect(MadID.locate("noo-getting-cold")).to be_nil
      end

      it 'returns nil if nothing is found' do
        expect(MadID.locate("pny-no-pony-there")).to be_nil
      end
    end
    describe 'locate!' do
      it 'raises an error if no class is found' do
        expect { MadID.locate!("noo-class-there") }.to raise_error(KeyError)
      end

      it 'raises an error if no record is found' do
        expect { MadID.locate!("pny-class-there") }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
