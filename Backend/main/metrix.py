# -*- coding: utf-8 -*-
import sys
sys.path.append("..")
import numpy as np
from main.apiConnection import *

class Metrix():  
    def __KDJ(self, high, low, close):
        K = 50
        D = 50
        for i in range(high.shape[0]):
            RSV = (close[i] - low[i]) / (high[i] - low[i])
            K = 2 / 3 * K + 1 / 3 * RSV
            D = 2 / 3 * D + 1 / 3 * K
        J = 3 * D - 2 * K
        return J
    
    def __RSI(self, close, days=10):  # Relative Strength Index
        closeRSI = close[close.shape[0] - days - 1:close.shape[0]]
        closeDiff = np.diff(closeRSI)
        riseIndex = np.where(closeDiff >= 0)
        downIndex = np.where(closeDiff <= 0)
        a = sum(closeDiff[riseIndex])
        b = -1 * sum(closeDiff[downIndex])
        RSI = a / (a + b) * 100
        return RSI
    
    def __CCI(self, high, low, close, days=7):
        TP = (high[-1] + low[-1] + close[-1]) / 3
        MA = sum(close[close.shape[0] - days - 1:close.shape[0]]) / len(close[close.shape[0] - days - 1:close.shape[0]])
        MD = sum(abs(MA - close[close.shape[0] - days - 1:close.shape[0]])) / len(
            close[close.shape[0] - days - 1:close.shape[0]])
        # print(MD)
        CCI = 1 / 0.015 * (TP - MA) / MD
        return CCI
    
    def __earn_rate_data(self, close):
        return (close[1:] - close[0:close.shape[0] - 1]) / close[0:close.shape[0] - 1]
    
    def __incoming_data(self, stockName):
        apifactory = apiConnectionFactory()
        apiCon = apifactory.getConnection("fundamentalDow30") #api connection
        return apiCon.request(stockName)
    
    def __intraday(self, stockName):
        apifactory = apiConnectionFactory()
        apiCon = apifactory.getConnection("intradayChartingPrices") #api connection
        return apiCon.request(1, stockName, 3)
    
    def metrixCalculate(self, stockName, high, low, close, days):
        #print(self.KDJ(high, low, close))
        metrixs={}
        metrixs["KDJ"] = self.__KDJ(high, low, close)
        metrixs["RSI"] = self.__RSI(close)
        metrixs["CCI"] = self.__CCI(high, low, close)
        metrixs["earn_rate"] = self.__earn_rate_data(close)
        metrixs["close"] = close
        metrixs["incoming_data"] = self.__incoming_data(stockName)
        metrixs["intraday"] = self.__intraday(stockName)
        return metrixs
    
    
    
# m=Metrix()
# m.metrixCalculate(AMZN._stock__high, AMZN._stock__low, AMZN._stock__close, 11)