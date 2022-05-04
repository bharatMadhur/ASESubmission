# -*- coding: utf-8 -*-
"""
Created on Tue May  3 21:32:11 2022

@author: ycgao
"""

import sys
sys.path.append("..")

import unittest
from main.forex import *


class TestforexMethods(unittest.TestCase):
    
    def test_int(self):
        forex = forexInformation()
        
    def test_getInfo(self):
        print(forex.getInformation())
        
if __name__ == '__main__':
    try:
        global forex
        forex = forexInformation()
    except:
        print("Can not creat forex class")
        sys.exit()
    unittest.main()