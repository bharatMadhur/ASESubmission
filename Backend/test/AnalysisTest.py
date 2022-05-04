# -*- coding: utf-8 -*-
"""
Created on Tue May  3 22:42:22 2022

@author: ycgao
"""

import sys
sys.path.append("..")

from main.metrix import Metrix
from main.stock import *
import unittest

class TestAnalysisMethods(unittest.TestCase):
    
    def test_int(self):
        analysisFactory = AnalysisFactory()
        
    def test_Recommendation(self):
        analyst = analysisFactory.getAnalyst("Recommendation analysis")
        analyst.getMetrix(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose())
        analyst.getAnalysis()
        
    def test_risk(self):
        analyst = analysisFactory.getAnalyst("risk analysis")
        analyst.getMetrix(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose())
        analyst.getAnalysis()
    
    def test_Sentiment(self):
        analyst = analysisFactory.getAnalyst("Sentiment analysis")
        analyst.getMetrix(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose())
        analyst.getAnalysis()
        
    def test_Fundenmential(self):
        analyst = analysisFactory.getAnalyst("Fundenmential analysis")
        analyst.getMetrix(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose())
        analyst.getAnalysis()
        
    def test_Technical(self):
        analyst = analysisFactory.getAnalyst("Technical analysis")
        analyst.getMetrix(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose())
        analyst.getAnalysis()
        
    def test_SWOT(self):
        analyst = analysisFactory.getAnalyst("SWOT analysis")
        analyst.getMetrix(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose())
        analyst.getAnalysis()
        
    def test_Pe(self):
        analyst = analysisFactory.getAnalyst("Pe analysis")
        analyst.getMetrix(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose())
        analyst.getAnalysis()
        
    def test_pivot(self):
        analyst = analysisFactory.getAnalyst("pivot level")
        analyst.getMetrix(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose())
        analyst.getAnalysis()
        
    def test_moving_average(self):
        analyst = analysisFactory.getAnalyst("moving average")
        analyst.getMetrix(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose())
        analyst.getAnalysis()
        
    def test_chart_moving_average(self):
        analyst = analysisFactory.getAnalyst("chart moving average")
        analyst.getMetrix(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose())
        analyst.getAnalysis()
        
    def test_year_on_year(self):
        analyst = analysisFactory.getAnalyst("year_on_year")
        analyst.getMetrix(Stock.getStockCode(), Stock.getHigh(), Stock.getLow(), Stock.getClose())
        analyst.getAnalysis()
    
        
        


if __name__ == '__main__':
    try:
        global analysisFactory
        analysisFactory = AnalysisFactory()
        global Stock 
        Stock = stock("aapl")   
    except:
        print("Can not creat corrent class")
        sys.exit()
    unittest.main()