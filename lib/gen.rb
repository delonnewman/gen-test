module Gen
  class Generator
    def initialize(gen = nil, &blk)
      @gen = gen || blk or raise "A proc or a block is required"
    end

    def generate
      @gen.call
    end
    alias call generate
  end

  def generator?(val)
    val.respond_to?(:generate)
  end

  def sample(gen, n = 10)
    (0..n).map { generate(gen) }
  end

  def where(gen, pred, max_tries = 10)
    Generator.new do
      tries = 0
      until (val = generate(gen)) and pred.call(val)
        tries += 1
        if tries >= max_tries
          raise "We've tried generating a value from #{gen.inspect} with #{pred.inspect} #{max_tries} times and failed"
        end
      end
      val
    end
  end

  def one_of(generators)
    generate(generators.to_a.sample)
  end

  def generate(generator)
    if generator.respond_to?(:generate)
      generator.generate
    elsif generator.respond_to?(:call)
      STDERR.puts "WARN: Objects that implement `call` are no longer automatically generators you must implement `generate`"
      generator
    else
      generator
    end
  end

  module_function :generator?, :sample, :generate, :where, :one_of
end
