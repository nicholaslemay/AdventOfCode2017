def depth_of(array,depth)
  array.inject(depth){|sum,x| sum + depth_of(x, depth + 1) }
end

def solve(puzzle)
  parsed_string = puzzle.gsub(/(?<=<)*(!.)(?=.*>)/,'').gsub(/(<.*?>,?)/, '').gsub('{','[').gsub('}', ']')
  arrays = eval(parsed_string)
  depth_of(arrays,1)
end


describe 'Solving the puzzle' do

  it('extract the distance from a move directive') do
    expect(solve('{}')).to eq(1)
    expect(solve('{{{}}}')).to eq(6)
    expect(solve('{{},{}}')).to eq(5)
    expect(solve('{{{},{},{{}}}}')).to eq(16)
    expect(solve('{<<<<>,<{!>}>,<!!>, <!!!>>, <{o"i!a,<{i<a>, <<<<>}')).to eq(1)
    expect(solve('{<{o"i!a,<{i<a>,<a>,<a>,<!!!>>,{<ab>}}')).to eq(3)
    expect(solve('{{<ab>},{<ab>},{<ab>},{<ab>}}')).to eq(9)
    expect(solve('{{<!!>},{<!!>},{<!!>},{<!!>}}')).to eq(9)
    expect(solve('{{<a!>},{<a!>},{<a!>},{<ab>}}')).to eq(3)
  end

  it('solves the world') do
   input = File.read('input.txt')
   expect(solve(input)).to eq(9251)
  end

end