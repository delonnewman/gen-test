require_relative '../gen'
require_relative '../ext_core'

module Gen
  module Test
    LOWER_BOUND = ENV.fetch('TEST_LOWER_BOUND', 10).to_i
    UPPER_BOUND = ENV.fetch('TEST_UPPER_BOUND', 20).to_i
  
    def for_all(*generators)
      for_n([LOWER_BOUND, UPPER_BOUND], *generators, &Proc.new)
    end
  
    def for_any(*generators)
      for_n(1, *generators, &Proc.new)
    end
    alias for_one for_any
  
    def for_n(n, *generators)
      if block_given?
        n = Faker::Number.between(n.first, n.last) if n.respond_to?(:first) and n.respond_to?(:last)
        n.times do
          yield(*generators.map(&Gen.method(:generate)))
        end
      else
        raise 'A block is expected with a property definition'
      end
    end
  
    def for_each(generators)
      if block_given?
        generators.each do |generator|
          yield(Gen.generate(generator))
        end
      else
        raise 'A block is expected with a property definition'
      end
    end
  end
end
