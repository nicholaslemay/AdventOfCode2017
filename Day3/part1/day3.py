import unittest
import math

class SpiralMatrix():

    def __init__(self, size):
        self.maximum_number = size * size
        self.current_number = 1
        self.matrix = [[0 for column in range(size)] for row in range(size)] 
        self.middle = size/2
        
        self.current_x_position = self.current_y_position = self.max_left_position = self.max_right_position =self.max_top_position = self.max_bottom_position = self.middle

    def run(self):
        self.matrix[self.current_y_position][self.current_x_position] = self.current_number
        while not self.limit_has_been_reached():
            self.move_right()
            self.move_up()
            self.move_left()
            self.move_down()
        return self.matrix
    
    def position_of(self, number):
        for y in range(len(self.matrix)):
            for x in range(len(self.matrix)):
                if self.matrix[y][x] == number:
                    return (x,y)
                    
    def move_right(self):
        self.max_right_position = self.max_right_position + 1
        self.move_laterally(range(self.current_x_position+1, self.max_right_position+1))

    def move_left(self):
        self.max_left_position = self.max_left_position - 1
        self.move_laterally(reversed(range(self.max_left_position , self.current_x_position )))

    def move_up(self):
        self.max_top_position = self.max_top_position - 1
        self.move_vertically(reversed(range(self.max_top_position, self.current_y_position)))
         
    def move_down(self):
        self.max_bottom_position = self.max_bottom_position + 1
        self.move_vertically(range(self.current_y_position + 1, self.max_bottom_position + 1))
    
    def move_laterally(self, x_positions):
        def update_x(x): self.current_x_position = x
        self.move(x_positions, update_x)
            
    def move_vertically(self, y_positions):
        def update_y(y): self.current_y_position = y
        self.move(y_positions, update_y)

    def move(self, positions, update_coordinate):
        for p in positions:
            self.current_number = self.current_number + 1 
            if self.limit_has_been_reached():
                return
            update_coordinate(p)
            self.matrix[self.current_y_position ][self.current_x_position] = self.current_number
    
    def limit_has_been_reached(self):
      return self.current_number > self.maximum_number
                      



class TestSpiralMatrix(unittest.TestCase):

    def test_spiral_matrix(self):
        expected = [[17,16,15,14,13],[18,5,4,3,12],[19,6,1,2,11],[20,7,8,9,10],[21,22,23,24,25]]	
        self.assertEquals(SpiralMatrix(5).run(), expected)
     
    def test_spiral_matrix_position(self):
        spiral_matrix = SpiralMatrix(5)
        spiral_matrix.run()
        self.assertEquals(spiral_matrix.position_of(1), (2,2))

    def test_the_solution(self):
        spiral_matrix = SpiralMatrix(605)
        spiral_matrix.run()
        self.assertEquals(spiral_matrix.position_of(1), (302,302))
        self.assertEquals(spiral_matrix.position_of(361527), (603,277))

if __name__ == '__main__':
    unittest.main()

