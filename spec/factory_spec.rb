require 'spec_helper'
require 'faker'

describe Factory do
  before { Object.send(:remove_const, 'Customer') if Object.const_defined?('Customer') }

  context 'Define' do
    it 'with wrong arguments' do
      expect { Factory.new([1, 2, 3]) }.to raise_error(TypeError)
    end

    it 'without arguments' do
      expect { Factory.new }.to raise_error(ArgumentError)
    end

    it 'with class_name' do
      Factory.new('Customer', :name, :address, :zip)

      expect(Customer.new).to be_a(Customer)
    end

    it 'with constant' do
      Customer = Factory.new(:name, :address, :zip)

      expect(Customer.new).to be_a(Customer)
    end

    it 'with block' do
      Customer = Factory.new(:name, :address, :zip) do
        def greeting
        end
      end

      expect(Customer.new).to respond_to(:greeting)
    end
  end

  context 'Customer' do
    let(:name) { Faker::Name.name }
    let(:address) { Faker::Address.street_address }
    let(:zip) { Faker::Address.zip_code }
    let(:output) { '<struct Customer name="%s" address="%s" zip="%s">' % [name, address, zip] }

    subject do
      Factory.new('Customer', :name, :address, :zip) do
        def greeting
          "Hello!"
        end
      end

      Customer.new(name, address, zip)
    end

    it { expect(subject.inspect).to eq(output) }
    it { expect(subject.class.to_s).to eq('Customer') }
    it { expect(subject.name).to eq(name) }
    it { expect(subject["name"]).to eq(name) }
    it { expect(subject[:name]).to eq(name) }
    it { expect(subject[0]).to eq(name) }
    it { expect(subject.greeting).to eq('Hello!') }
    it { expect(subject).to eq(Customer.new(name, address, zip)) }
    it { expect(subject).to_not eq(Customer.new('test', 'test', 'test')) }
  end
end
