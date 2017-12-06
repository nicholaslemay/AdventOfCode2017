def passphrases_of(file)
   File.new(file).readlines.collect{|line| line.strip.split(' ')}
end

def as_sorted_anagrams(passphrase)
   passphrase.collect{|word| word.chars.sort.join}	
end

def valid_passphrases_from(passphrases)
   passphrases.collect{|p| as_sorted_anagrams(p)}.select{|p| p.uniq == p}	
end

describe 'Passphrases' do

  it 'finds unique passphrases without duplicate anagrams from passphrase' do
    expect(valid_passphrases_from(passphrases_of('sample.txt')).count).to eq(3)
  end

  it 'finds unique passwords from puzzle' do
    expect(valid_passphrases_from(passphrases_of('solution.txt')).count).to eq(231)
  end
end