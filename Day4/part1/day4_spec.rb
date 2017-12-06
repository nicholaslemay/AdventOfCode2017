def passphrases_of(file)
   File.new(file).readlines.collect{|line| line.strip.split(' ')}
end

def valid_passphrases_from(passphrases)
   passphrases.select{|p| p.uniq == p}	
end

describe 'Passphrases' do

  it 'can parse passphrase from file' do
    expected =[['aa','bb', 'cc', 'dd', 'ee'], ['aa','bb', 'cc', 'dd', 'aa'],['aa','bb', 'cc', 'dd', 'aaa']]
    expect(passphrases_of('sample.txt')).to eq(expected)
  end

  it 'finds unique passwords from passwords' do
    expect(valid_passphrases_from(passphrases_of('sample.txt'))).to eq([['aa','bb', 'cc', 'dd', 'ee'], ['aa','bb', 'cc', 'dd', 'aaa']])
  end

  it 'finds unique passwords from puzzle' do
    expect(valid_passphrases_from(passphrases_of('solution.txt')).count).to eq(337)
  end
end