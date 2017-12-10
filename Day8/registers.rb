class Registers
  
  @@registers = Hash.new(0)
  @@max_ever = 0
  
  def self.process(instructions)
    instructions.each do |line|
      target, operation, value, source, comparator, comparison = parse(line)  
      if @@registers[source].send(comparator, comparison.to_i) 
        self.send(operation,target,value.to_i)
      end 
      @@max_ever = self.max if(self.max > @@max_ever)
    end  
  end  
  
  def self.max 
    @@registers.values.max || 0
  end
  
  def self.max_ever
    @@max_ever
  end  
  
  private
  
  def self.parse(line)
    line.match(/(\w+) (\w+) (-?\d+) if (\w+) (\W{1,2}) (-?\d+)/).captures
  end 
  
  def self.inc(name, value)
    @@registers[name] += value
  end  

  def self.dec(name, value)
    @@registers[name] -= value
  end  
end
