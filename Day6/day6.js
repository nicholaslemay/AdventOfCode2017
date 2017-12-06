class Debugger {
  constructor(memory_blocks) {
    this.cycles = 0;
    this.encountered_states = {};
    this.memory_blocks = memory_blocks;
  }

  find_loop() {
    while (!this.encountered_states[this.memory_blocks]) {
      this.encountered_states[this.memory_blocks.slice(0)] = this.cycles;
      this.distribute();
      this.cycles++;
    }
    return this.cycles - this.encountered_states[this.memory_blocks];
  }

  distribute() {
    var bank = this.bank_with_most_blocks();
    this.memory_blocks[bank.position] = 0;
    while (bank.value > 0) {
      this.memory_blocks[++bank.position % this.memory_blocks.length]++;
      bank.value--;
    }
  }
  
  bank_with_most_blocks() {
    let max = Math.max.apply(Math, this.memory_blocks);
    let position = this.memory_blocks.indexOf(max);
    return { value: max, position: position };
  }
}
new Debugger([0, 2, 7, 0]).find_loop();
//new Debugger([10,3,15,10,5,15,5,15,9,2,5,8,5,2,3,6]).find_loop();

