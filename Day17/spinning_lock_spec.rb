require 'rspec'

class SpinningLock

  def initialize(rotations)
    @rotations = rotations
  end

  def run_up_to(limit)
    results = []

    (0..limit).each do |value|
      results.rotate!(@rotations)
      results << value
    end

    results
  end

  def second_value_after(limit)
    second_value = 0
    insertion_point = 0

    (1..limit).each do |value|
      insertion_point = (insertion_point + @rotations) % (value) + 1
      second_value = value if insertion_point == 1
    end

    second_value
  end

end

describe SpinningLock do

  before(:each) do
    @spinning_lock = SpinningLock.new(3)
  end

  it "can generate a spinning lock up to 9" do
    expect(@spinning_lock.run_up_to(9)).to match_array([5, 7, 2, 4, 3, 8, 6, 1, 0, 9])
  end

  it "can generate a spinning lock up to 2017" do
    results = @spinning_lock.run_up_to(2017)
    expect(results[0]).to equal(638)
  end

  it "can generate a spinning lock up to 2017 with 359 rotations" do
    results = SpinningLock.new(359).run_up_to(2017)
    expect(results[0]).to equal(1506)
  end

  it "can check what value is at second rank" do
    expect(@spinning_lock.second_value_after(1)).to eq(1)
    expect(@spinning_lock.second_value_after(2)).to eq(2)
    expect(@spinning_lock.second_value_after(3)).to eq(2)
    expect(@spinning_lock.second_value_after(4)).to eq(2)
    expect(@spinning_lock.second_value_after(5)).to eq(5)
    expect(@spinning_lock.second_value_after(6)).to eq(5)
    expect(@spinning_lock.second_value_after(7)).to eq(5)
    expect(@spinning_lock.second_value_after(8)).to eq(5)
    expect(@spinning_lock.second_value_after(9)).to eq(9)
  end

  it "can solve the second day puzzle" do
    expect(SpinningLock.new(359).second_value_after(50000000)).to eq(39479736)
  end

end