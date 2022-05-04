# -*- coding: utf-8 -*-
"""
Created on Tue May  3 21:26:08 2022

@author: ycgao
"""

import sys
sys.path.append("..")

import unittest
from main.companyInformation import *

    
class TestCompanyInfoMethods(unittest.TestCase):
    
    def test_int(self):
        global companyInf 
        companyInf = companyInformation()
        
    def test_getInfo(self):
        print(companyInf.getInformation("aapl"))
        
if __name__ == '__main__':
    try:
        global companyInf 
        companyInf = companyInformation()
    except:
        print("Can not creat company inf class")
    unittest.main()