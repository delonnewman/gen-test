require_relative '../gen'
require_relative '../ext_core'

module Gen
  module Test
    LOWER_BOUND = ENV.fetch('TEST_LOWER_BOUND', 10).to_i
    UPPER_BOUND = ENV.fetch('TEST_UPPER_BOUND', 20).to_i
  
    def self.included(base)
      base.include(Gen)
    end

    def for_all(*generators, &block)
      for_n([LOWER_BOUND, UPPER_BOUND], *generators, &block)
    end
  
    def for_any(*generators, &block)
      for_n(1, *generators, &block)
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
  
    def for_each(*collections)
      unless collections.empty?
        size = collections.first.size
        raise "All collections must be the same size" unless collections.all? { |c| c.size == size }
        zipped = collections.first.zip(*collections.drop(1))
        if block_given?
          zipped.each do |generators|
            yield(*generators.map { |g| Gen.generate(g) })
          end
        else
          raise 'A block is expected with a property definition'
        end
      end
    end
  end
end
