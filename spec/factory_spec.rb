require 'faker'
require_relative '../factory'

describe Factory do
  before { Object.send(:remove_const, 'Customer') if Object.const_defined?('Customer') }

  context 'Define' do
    it 'with class_name' do
      Factory.new('Customer', :name, :address, :zip)

      expect(Object.const_defined?('Customer')).to be(true)
      expect(Customer.new).to be_a(Customer)
    end

    it 'with constant' do
      Customer = Factory.new(:name, :address, :zip)

      expect(Customer.new).to be_a(Customer)
    end
  end

  context 'Customer' do
    let(:name) { Faker::Name.name }
    let(:address) { Faker::Address.street_address }
    let(:zip) { Faker::Address.zip_code }
    let(:output) { '<struct Customer name="%s" address="%s" zip="%s">' % [name, address, zip] }

    subject do
      Factory.new('Customer', :name, :address, :zip)
      Customer.new(name, address, zip)
    end

    it { expect(subject.inspect).to eq(output) }
    it { expect(subject.class.to_s).to eq('Customer') }
    it { expect(subject.name).to eq(name) }
    it { expect(subject["name"]).to eq(name) }
    it { expect(subject[:name]).to eq(name) }
    it { expect(subject[0]).to eq(name) }
    it { expect(subject).to eq(Customer.new(name, address, zip)) }
    it { expect(subject).to_not eq(Customer.new('test', 'test', 'test')) }
  end
end
