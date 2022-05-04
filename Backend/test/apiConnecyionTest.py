# -*- coding: utf-8 -*-
"""
Created on Tue May  3 17:46:11 2022

@author: ycgao
"""

import sys
sys.path.append("..")

from main.apiConnection import *
from datetime import datetime, timedelta
import unittest

class TestApiConnection(unittest.TestCase): #run all the methods
    def test_Stock_data(self):
        analysisType = "Stock data"
        factory = apiConnectionFactory()
        stockApi = factory.getConnection(analysisType)
        today = datetime.today()
        early_days = today - timedelta(365)
        date = early_days.strftime("%Y-%m-%d")
        #request error
        self.assertNotEqual(stockApi.request("AMZN", date), '')
        #right company code
        #This should reqpor a failed
        self.assertNotEqual(stockApi.request("dddd", date), {'detail': "Error: Ticker 'DDDD' not found"})
        
        
    def test_CompanyInformation(self):
        apifactory = apiConnectionFactory()
        apiCon = apifactory.getConnection("Company information")
        #company do not exit
        self.assertNotEqual(apiCon.request("AMZN"), {'detail': 'Not found.'})
        #request error
        self.assertNotEqual(apiCon.request("AMZN"), "")
        
    def test_forex(self):
        apifactory = apiConnectionFactory()
        apiCon = apifactory.getConnection("forex")
        #if do not get request, return ""
        self.assertNotEqual(apiCon.request(), "")
        
        
    def test_currentPrice(self):
        apifactory = apiConnectionFactory()
        apiCon = apifactory.getConnection("currentPrice")
        #if do not get request, return ""
        self.assertNotEqual(apiCon.request("AMZN"), "")
    
    def test_intradayChartingPricesx(self):
        apifactory = apiConnectionFactory()
        apiCon = apifactory.getConnection("intradayChartingPrices")
        #if do not get request, return ""
        self.assertNotEqual(apiCon.request(1, "aapl", 3), "")
        
    def test_fundamentalDow30(self):
        apifactory = apiConnectionFactory()
        apiCon = apifactory.getConnection("fundamentalDow30")
        #if do not get request, return ""
        self.assertNotEqual(apiCon.request("aapl"), "")

if __name__ == '__main__':
    unittest.main()