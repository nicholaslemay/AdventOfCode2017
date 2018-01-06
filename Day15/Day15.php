<?php

use PHPUnit\Framework\TestCase;

class NumberGenerator{

    private $previousValue;
    private $factor;
    private const MAGIC_NUMBER = 2147483647;

    public function __construct($startingValue, $factor)
    {
        $this->previousValue = $startingValue;
        $this->factor = $factor;
    }

    public function getNext($modulator = 1){
        $next = $this->getNextValue();

        while ($next % $modulator != 0)
            $next = $this->getNextValue();

        return $next;
    }

    private function getNextValue(){
        return $this->previousValue = ($this->previousValue * $this->factor) % self::MAGIC_NUMBER;
    }
}

class NumberComparator{
    private const _16_BIT_MASK  = 0b1111111111111111;

    public static function areLast16BitsMatching($numberA, $numberB){
        return ($numberA & self::_16_BIT_MASK) === ($numberB & self::_16_BIT_MASK);
    }
}


class Day15Test extends TestCase
{
    public function testCanGenerateNextNumberOfSequence()
    {
        $generator = new NumberGenerator(65, 16807);
        $this->assertEquals(1092455, $generator->getNext());
        $this->assertEquals(1181022009, $generator->getNext());
        $this->assertEquals(245556042, $generator->getNext());
        $this->assertEquals(1744312007, $generator->getNext());
        $this->assertEquals(1352636452, $generator->getNext());
    }

    public function testCanGenerateNextNumberOfSequenceWithModulator()
    {
        $generator = new NumberGenerator(65, 16807);
        $this->assertEquals(1352636452, $generator->getNext(4));
        $this->assertEquals(1992081072, $generator->getNext(4));
        $this->assertEquals(530830436, $generator->getNext(4));
        $this->assertEquals(1980017072, $generator->getNext(4));
        $this->assertEquals(740335192, $generator->getNext(4));
    }

    public function testCanCheckIfBitsOfNumbersAreMatching(){
        $this->assertEquals(false, NumberComparator::areLast16BitsMatching(1092455,430625591));
        $this->assertEquals(false, NumberComparator::areLast16BitsMatching(1181022009,1233683848));
        $this->assertEquals(true, NumberComparator::areLast16BitsMatching(245556042,1431495498));
        $this->assertEquals(false, NumberComparator::areLast16BitsMatching(1744312007,137874439));
        $this->assertEquals(false, NumberComparator::areLast16BitsMatching(1352636452,285222916));
    }

    public function testCanSolveRiddle(){
        $matches =0;
        $generatorA = new NumberGenerator(65,16807);
        $generatorB = new NumberGenerator(8921,48271);

        for ($i = 0; $i < 40000000; $i++)
            if(NumberComparator::areLast16BitsMatching($generatorA->getNext(), $generatorB->getNext()))
                $matches++;

        $this->assertEquals(588, $matches);
    }

    public function testCanSolveRiddleWithCustomInput(){
        $matches =0;
        $generatorA = new NumberGenerator(618,16807);
        $generatorB = new NumberGenerator(814,48271);

        for ($i = 0; $i < 40000000; $i++)
            if(NumberComparator::areLast16BitsMatching($generatorA->getNext(), $generatorB->getNext()))
                $matches++;

        $this->assertEquals(577, $matches);
    }

    public function testCanSolveRiddleWithCustomInputAndModulators(){
        $matches =0;
        $generatorA = new NumberGenerator(618,16807);
        $generatorB = new NumberGenerator(814,48271);

        for ($i = 0; $i < 5000000; $i++)
            if(NumberComparator::areLast16BitsMatching($generatorA->getNext(4), $generatorB->getNext(8)))
                $matches++;

        $this->assertEquals(577, $matches);
    }


}
