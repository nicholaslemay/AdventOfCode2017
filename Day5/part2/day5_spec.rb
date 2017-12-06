
class MazeCpu
  attr_reader :steps

  def initialize(instructions)
    @instructions = instructions
    @current_position = 0  
    @steps = 0
  end
  
  def execute
    while(@current_position < @instructions.count)
       movement = @instructions[@current_position]
       increment = movement >=3 ? -1 : 1 
       @instructions[@current_position] += increment
       @current_position += movement
       @steps +=1
    end
    
  end 

end

describe 'MazeCpu' do

  it 'can exit the sample maze in 5 steps' do
    instructions = [0,3,0,1,-3]
    cpu = MazeCpu.new(instructions)
    cpu.execute
    
    expect(cpu.steps).to eq(10)
  end

  it 'can exit the sample maze from the input' do
    instructions = File.new('input.txt').readlines.collect{|r| r.strip.to_i}
    cpu = MazeCpu.new(instructions)
    cpu.execute
    
    expect(cpu.steps).to eq(26395586)
  end
end