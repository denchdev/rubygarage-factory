# Factory [![Build Status](https://travis-ci.org/timlar/rubygarage-factory.svg?branch=master)](https://travis-ci.org/timlar/rubygarage-factory)

Task: Implement your own class 'Factory' which will have the same behavior as 'Struct' class.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'factory', :git => 'https://github.com/timlar/rubygarage-factory.git'
```

And then execute:

```bash
$ bundle
```

## Usage

Require gem

```ruby
require 'factory'
```


Create a factory with a name under Factory

```ruby
Factory.new('Customer', :name, :address, :zip)
# => Customer
```

or create a factory named by its constant

```ruby
Customer = Factory.new(:name, :address, :zip)
# => Customer
```

If a block is given it will be evaluated in the context of FactoryClass, passing the created class as a parameter

```ruby
Customer = Factory.new(:name, :address, :zip) do
  def greeting
    "Hello, #{name}!"
  end
end
# => Customer
```


## Examples

```ruby
customer = Customer.new("Joe Smith", "123 Maple, Anytown NC", 12345)
# => <struct Customer name="Joe Smith", address="123 Maple, Anytown NC", zip=12345>

customer.class    # => Customer
customer.name     # => "Joe Smith"
customer["name"]  # => "Joe Smith"
customer[:name]   # => "Joe Smith"
customer[0]       # => "Joe Smith"
customer.greeting # => "Hello, Joe Smith!"
```

Other factory

```ruby
Factory.new('Person', :name, :address, :zip)
# => Person

person = Person.new("Alena Nienow", "969 Schroeder Knoll", 21599)
# => <struct Person name="Alena Nienow" address="969 Schroeder Knoll" zip="21599">

person.class # => Person
person.name  # => "Alena Nienow"

person == customer # => false

person2 = Person.new("Alena Nienow", "969 Schroeder Knoll", 21599)
# => <struct Person name="Alena Nienow" address="969 Schroeder Knoll" zip="21599">

person == customer2 # => true
```
