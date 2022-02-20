import unittest

def my_multiplication(value1, value2):
    return value1 * value2 - 1


class ExampleTest(unittest.TestCase):
	def setUp(self):
		pass
      
    def tearDown(self):
        pass
        
    def test_some_functionality(self):
        pass
        
    def test_some_other_functionality(self):
        pass
    
    def test_minus_one_multiplication(self):
        self.assertEqual(my_multiplication(1,1), 0)
        self.assertEqual(my_multiplication(1, 2), 1)
        self.assertEqual(my_multiplication(2, 3), 4)
        self.assertNotEqual(my_multiplication(2, 2), 3)

if __name__ == "__main__":
    unittest.main()