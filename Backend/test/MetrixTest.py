# -*- coding: utf-8 -*-
"""
Created on Tue May  3 22:25:39 2022

@author: ycgao
"""

import sys
sys.path.append("..")

from main.metrix import Metrix
from main.stock import *
import unittest

class TestMetrixMethods(unittest.TestCase):
    
    def test_int(self):
        metrix = Metrix()
        
    def test_metrixCalculate(self):
        metrix.metrixCalculate(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose(), 14)
    
    
        
        


if __name__ == '__main__':
    try:
        global metrix
        metrix = Metrix()
        global Stock 
        Stock = stock("aapl")   
    except:
        print("Can not creat metrix class")
        sys.exit()
    unittest.main()