

def solve(puzzle)
  puzzle.gsub(/(?<=<)*(!.)(?=.*>)/,'').scan(/<(.*?)>,?/).join.length
end


describe 'Solving the puzzle' do

  it('can count the amount of garbage') do
    expect(solve('<>')).to eq(0)
    expect(solve('<random characters>')).to eq(17)
    expect(solve('<<<<>')).to eq(3)
    expect(solve('<{!>}>')).to eq(2)
    expect(solve('<!!>')).to eq(0)
    expect(solve('<!!!>>')).to eq(0)
    expect(solve('<{o"i!a,<{i<a>')).to eq(10)
    expect(solve('{{<ab>},{<ab>},{<ab>},{<ab>}}')).to eq(8)

  end

  it('solves the world') do
   input = File.read('input.txt')
   expect(solve(input)).to eq(9251)
  end

end