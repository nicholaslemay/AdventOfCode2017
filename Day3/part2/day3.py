import unittest
import math

class SpiralMatrix():

    def __init__(self, size):
        self.size = size
        self.inserted_values = []
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
            new_value = self.sum_of_neighbouring_cells()
            self.matrix[self.current_y_position ][self.current_x_position] = self.sum_of_neighbouring_cells()
            self.inserted_values.append(new_value)
    
    def limit_has_been_reached(self):
      return self.current_number > self.maximum_number
                      
    def sum_of_neighbouring_cells(self):
        relative_siblings = [(-1,0),(-1,1),(0,1),(1,1),(1,0),(1,-1),(0,-1),(-1,-1)]
        return sum(map(self.value_at, relative_siblings)) 
    
    def value_at(self, relative_position):
        target_y = self.current_y_position + relative_position[0]
        target_x = self.current_x_position + relative_position[1]
        if self.is_invalid(target_y) or self.is_invalid(target_x):
            return 0
        return self.matrix[target_y][target_x]
    
    def is_invalid(self, position): 
      return position < 0 or position >= self.size

class TestSpiralMatrix(unittest.TestCase):

    def test_spiral_matrix(self):
        expected = [[147,142,133,122,59],[304,5,4,2,57],[330,10,1,1,54],[351,11,23,25,26],[362,747,806,880,931]]	
        self.assertEquals(SpiralMatrix(5).run(), expected)

    def test_the_solution(self):
        spiral_matrix = SpiralMatrix(9)
        spiral_matrix.run()
        result = next(value for value in spiral_matrix.inserted_values if value > 361527)
        self.assertEquals(363010, result)

if __name__ == '__main__':
    unittest.main()

