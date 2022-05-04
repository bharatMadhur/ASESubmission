# -*- coding: utf-8 -*-
"""
Created on Wed May  4 00:28:12 2022

@author: ycgao
"""
import sys
sys.path.append("..")
from main.indexComparison import *
import unittest

class TestCompareMethods(unittest.TestCase):
    
    def test_int(self):
        compare = indexComparison()
        
    def test_getInfo(self):
        compare.Comparison("aapl")
        
if __name__ == '__main__':
    try:
        global compare
        compare = indexComparison()
    except:
        print("Can not creat forex class")
        sys.exit()
    unittest.main()