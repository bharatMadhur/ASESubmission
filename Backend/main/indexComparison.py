# -*- coding: utf-8 -*-
import sys
sys.path.append("..")
import pandas as pd
from main.stock import *

class indexComparison():
    def __init__(self):
        self.__stockCode1 = 'INDEX'
        self.__stockCode2 = 'NASDX'
        
    def Comparison(self, ticker):
        stock1 = stock(self.__stockCode1)
        stock2 = stock(self.__stockCode2)
        stock3 = stock(ticker)
        index1 = stock1.getClose()
        index2 = stock2.getClose()
        df = pd.DataFrame(stock3.getClose())
        index1_df = pd.DataFrame(index1)
        index1_comparison = (index1_df.iloc[0][0] - index1_df.iloc[-1][0])-(df.iloc[0][0] - df.iloc[-1][0])
        index2_df = pd.DataFrame(index2)
        index2_comparison = (index2_df.iloc[0][0] - index2_df.iloc[-1][0]) - (df.iloc[0][0] - df.iloc[-1][0])
        print(index1_comparison,index2_comparison)
        return index1_comparison,index2_comparison
        
        




    
    
    
