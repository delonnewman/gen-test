module Gen
  def generator?(val)
    val.respond_to?(:call) or val.respond_to?(:generate)
  end

  def sample(gen, n = 10)
    (0..n).map { eval_generator(gen) }
  end

  def such_that(gen, pred)
    lambda do
      val = eval_generator(gen)
      val = eval_generator(gen) until pred.call(val)
      val
    end
  end

  def one_of(generators)
    eval_generator(generators.to_a.sample)
  end

  def generate(generator, *args)
    if generator.respond_to?(:call)
      generator.call(*args)
    elsif generator.respond_to?(:generate)
      generator.generate(*args)
    else
      generator
    end
  end

  module_function :generator?, :sample, :generate, :such_that, :one_of
end
