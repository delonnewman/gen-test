RSpec.describe Gen::Test do
  include Gen::Test

  AddOne = lambda { |x| x + 1 }

  it 'should increment any integer' do
    for_all Integer do |a|
      b = AddOne[a]
      expect(b).to be(a + 1)
    end
  end

  it 'should raise a TypeError for any string' do
    for_all String do |a|
      expect { AddOne[a] }.to raise_error(TypeError)
    end
  end
end
