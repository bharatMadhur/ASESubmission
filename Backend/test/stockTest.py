# -*- coding: utf-8 -*-
"""
Created on Tue May  3 17:12:11 2022

@author: ycgao
"""
import sys
sys.path.append("..")

from main.stock import *
import unittest

class TestStockMethods(unittest.TestCase):
    
    def test_int(self):
        Stock = stock("aapl")
    
    def test_stockCode(self):
        Stock.setStockCode('AMZN')
        self.assertEqual(Stock.getStockCode(), "AMZN")
        
    def test_date(self):
        Stock.setdate(30)
        Stock.getdate()
        today = datetime.today()
        early_days = today - timedelta(30)
        date = early_days.strftime("%Y-%m-%d")
        self.assertEqual(Stock.getdate(), date)
    
    def test_load(self):
        Stock.reloadData()
    
    def test_close(self):
        self.assertNotEqual(Stock.getClose(), [])
    
    def test_high(self):
        self.assertNotEqual(Stock.getHigh(), [])
    
    def test_low(self):
        self.assertNotEqual(Stock.getLow(), [])

    def test_analysis(self):
        Stock.analysis("risk analysis")
        
    def test_currentPrice(self):
        Stock.getCurrentPrice()
        
        


if __name__ == '__main__':
    if True:   
        try:
            global Stock 
            Stock = stock("aapl")
        except:
            print("Stock information is wrong")
            sys.exit()
    unittest.main()