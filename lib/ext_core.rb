require 'date'

# Some extentions to the core Object class
class Object
  # Return self
  def generate(*_args)
    self
  end
end

# Some extentions to the core String class
class String
  # Randomly generate a String
  #
  # @see Faker::String
  # @return [String]
  # TODO: add filtering
  def self.generate(*_args)
    Faker::String.random
  end
end

# Some extentions to the core Symbol class
class Symbol

  # Randomly generate a Symbol
  #
  # @see String#generate
  # @return [Symbol]
  def self.generate(*_args)
    String.generate.to_sym
  end
end

# Some extentions to the core Float class
class Float

  # Randomly generate a Float instance
  #
  # @return [Float]
  def self.generate(*_args)
    Random.rand(10e10)
  end
end

# Some extentions to the core Integer class
class Integer
  # Randomly generate an Integer
  #
  # @return [Integer]
  def self.generate(min: nil, max: nil, bit_length: nil)
    i = Random.rand(10e10).to_i
    if !min.nil? or !max.nil? or !bit_length.nil?
      while i > max or i < min or i.bit_length > bit_length
        i = Random.rand(10e10).to_i
      end
    end

    if Random.rand < 0.5
      i
    else
      i * -1
    end
  end
end

# Some extentions to the core FalseClass
class FalseClass
  # Return false
  def self.generate(*_args)
    false
  end
end

# Some extentions to the core TrueClass
class TrueClass
  # Return true
  def self.generate(*_args)
    true
  end
end

# Some extentions to the core NilClass
class NilClass
  # Return nil
  def self.generate(*_args)
    nil
  end
end

# Some extentions to the core Array class
class Array
  DEFAULT_GENERATIVE_TYPES = [
      Integer,
      String,
      Float,
      FalseClass,
      TrueClass,
      NilClass
  ]

  # Randomly generate an Array
  def self.generate(min: 0, max: 30, type: nil)
    (0..Faker::Number.between(min, max)).map do
      if type.nil?
        DEFAULT_GENERATIVE_TYPES.sample.generate
      else
        type.generate
      end
    end
  end

  # Randomly generate an Array from an Array instance, use the values of the array as generators.
  #
  # @example
  #     [Integer, Float, String].generate => [2341234, 2.24, "asdfawqsafdrawdsfasds"]
  #
  # @return [Array]
  def generate
    map(&:generate)
  end
end

# Some extentions to the core Set class
class Set
  # Randomly generate a Set
  def self.generate(*args)
    new(Array.generate(*args))
  end

  # Randomly select an element of the Set
  def generate(*_args)
    to_a.sample
  end
end

# Some extentions to the core Hash class
class Hash
  DEFAULT_GENERATIVE_KEY_TYPES = [
      Symbol,
      String,
      Integer
  ]

  DEFAULT_GENERATIVE_VALUE_TYPES = [
      Integer,
      String,
      Float,
      FalseClass,
      TrueClass,
      NilClass
  ]

  # Randomly generate a Hash
  def self.generate(min: 0, max: 30, key_type: nil, value_type: nil)
    (0..Faker::Number.between(min, max)).reduce({}) do |h, _|
      kt = key_type || DEFAULT_GENERATIVE_KEY_TYPES.sample
      vt = value_type || DEFAULT_GENERATIVE_VALUE_TYPES.sample
      h.merge(kt.generate => vt.generate)
    end
  end

  def generate(*_args)
    transform_values(&:generate)
  end
end

# Some extentions to the core Range class
class Range
  # Randomly generate a value within the range
  def generate(*_args)
    if first.is_a? Numeric and last.is_a? Numeric
      Faker::Number.between(first, last)
    else
      to_a.sample
    end
  end
end

class Regexp
  def generate(*_args)
    random_example
  end
end

class DateTime
  def self.generate(*args)
    if args.empty?
      Time.at(Faker::Number.between(0, Time.now.to_i))
    else
      Faker::Time.between(*args)
    end.to_datetime
  end
end

class Date
  def self.generate(*args)
    if args.empty?
      Time.at(Faker::Number.between(0, Time.now.to_i))
    else
      Faker::Date.between(*args)
    end.to_date
  end
end

class Time
  def self.generate(*args)
    if args.empty?
      Time.at(Faker::Number.between(0, Time.now.to_i))
    else
      Faker::Time.between(*args)
    end.to_time
  end
end

class Proc
  def generate(*args)
    call(*args)
  end
end
