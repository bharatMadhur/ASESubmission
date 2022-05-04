import sys
sys.path.append("..")
from main.metrix import Metrix
import numpy as np
from scipy import stats
import pandas as pd
from scipy.stats import norm

class AnalysisFactory:
    def getAnalyst(self, AnalystType):
        if AnalystType==None:
            return None
        if AnalystType=="Recommendation analysis":
            return RecommendationAnalysis()
        elif AnalystType=="risk analysis":
            return riskAnalysis()
        elif AnalystType=="Sentiment analysis":
            return sentimentalAnalysis()
        elif AnalystType=="Fundenmential analysis":
            return fundenmentialAnalysis()
        elif AnalystType=="Technical analysis":
            return technicalAnalysis()
        elif AnalystType=="SWOT analysis":
            return SWOTAnalysis()
        elif AnalystType=="Pe analysis":
            return PeAnalysis()
        elif AnalystType=="pivot level":
            return pivot_level()
        elif AnalystType=="moving average":
            return moving_average()
        elif AnalystType=="chart moving average":
            return chart_moving_average()
        elif AnalystType=="year_on_year":
            return year_on_year()
        return None
    
from abc import ABC, abstractmethod
class analysis(ABC):
    def __int__(self):
        self._metrix = {}
        
    @abstractmethod
    def getAnalysis(self):
        pass
    
    def Evaluation(self):
        pass
    
    def getMetrix(self, stockName, high, low, close, days=14):
        m = Metrix()
        self._metrix = m.metrixCalculate(stockName, high, low, close, days)
        
'''
risk analysis
calculate the coefficient of earn_rate
if earn_rate more than a fix value, means this is risk
this value depend on experiment
'''
class riskAnalysis(analysis):  
    def getAnalysis(self):
        earn_rate_data = self._metrix["earn_rate"]
        earn_rate_range = np.max(earn_rate_data) - np.min(earn_rate_data)
        earn_rate_interquartile_range = np.quantile(earn_rate_data, 0.75) - np.quantile(earn_rate_data, 0.25)
        earn_rate_var = np.var(earn_rate_data)
        earn_rate_std = np.std(earn_rate_data)
        earn_rate_coefficient = earn_rate_std / np.mean(earn_rate_data)
        if earn_rate_coefficient > 10:
            return "risk"
        else:
            return "no risk"

'''
Sentiment analysis
Use Skewness refers to asymmetry deviates from normal distrubution. Use it for fundenmentional analysis
If the value more than 0 means higher profit probability 
'''
class sentimentalAnalysis(analysis):
    def getAnalysis(self):
        earn_rate_data = self._metrix["earn_rate"]
        earn_rate_skew = stats.skew(earn_rate_data)
        print(earn_rate_skew)
        print("Sentiment analysis:")
        if earn_rate_skew > 0:
            print("good")
        else:
            print("bad")

'''
technical analysis, which is depend on Monte Carlo Simulation
'''
class technicalAnalysis(analysis):
    def getAnalysis(self):
        earn_rate_data = self._metrix["earn_rate"]
        close = self._metrix["close"]
        close_data = pd.DataFrame(close)
        log_returns = np.log(1 + close_data.pct_change())

        u = log_returns.mean()
        var = log_returns.var()
        drift = u - (0.5 * var)

        stdev = log_returns.std()
        days = 50
        trials = 10000
        Z = norm.ppf(np.random.rand(days, trials))  # days, trials
        daily_returns = np.exp(drift.values + stdev.values * Z)

        price_paths = np.zeros_like(daily_returns)
        price_paths[0] = close_data.iloc[-1]
        for t in range(1, days):
            price_paths[t] = price_paths[t - 1] * daily_returns[t]

        print(f"Expected Value: ${round(pd.DataFrame(price_paths).iloc[-1].mean(), 2)}")
        print(
            f"Return: {round(100 * (pd.DataFrame(price_paths).iloc[-1].mean() - price_paths[0, 1]) / pd.DataFrame(price_paths).iloc[-1].mean(), 2)}%")
        print(f"Probability of Breakeven: {self.probs_find(pd.DataFrame(price_paths), 0, on='return')}")
        
            
    def probs_find(self, predicted, higherthan, on = 'value'):
        if on == 'return':
            predicted0 = predicted.iloc[0,0]
            predicted = predicted.iloc[-1]
            predList = list(predicted)
            over = [(i*100)/predicted0 for i in predList if ((i-predicted0)*100)/predicted0 >= higherthan]
            less = [(i*100)/predicted0 for i in predList if ((i-predicted0)*100)/predicted0 < higherthan]
        elif on == 'value':
            predicted = predicted.iloc[-1]
            predList = list(predicted)
            over = [i for i in predList if i >= higherthan]
            less = [i for i in predList if i < higherthan]
        else:
            print("'on' must be either value or return")
        return (len(over)/(len(over)+len(less)))


class fundenmentialAnalysis(analysis):
    def getAnalysis(self):
        earn_rate_data = self._metrix["earn_rate"]
        print("fundenmential")
        earn_rate_kutosis = stats.kurtosis(earn_rate_data)
        print("kutosis", earn_rate_kutosis)
        if earn_rate_kutosis > 0:
            print("This stock is Bullish")
        else:
            print("This stock is Bearish")
        
            
class RecommendationAnalysis(analysis):
    def getAnalysis(self):
        KDJ = self._metrix["KDJ"]
        RSI = self._metrix["RSI"]
        CCI = self._metrix["CCI"]
        if CCI<=-100 or RSI <= 55 or KDJ <=80:
            return "buy"
        else:
            return "sell"

class SWOTAnalysis(analysis):
    def getAnalysis(self):
        stren = []
        weak = []
        oppur = []
        threat = []
        incoming_d = self._metrix["incoming_data"]
        df = pd.DataFrame(incoming_d)
        if df.iloc[0]['marketCap'] < 100:
            oppur.append("Small Cap")
            threat.append("Small Cap")
        else:
            stren.append("established Company")
        if df.iloc[0]['enterpriseVal'] > 10:
            threat.append("Scary enterprise Val")
        else:
            stren.append("good enterprise Val")
            oppur.append("good enterprise Val")
        if df.iloc[0]['peRatio'] > 25:
            threat.append("OverValued")
            weak.append("Poor peRatio")
        else:
            stren.append("Undervalued")
            oppur.append("Undervalued")
        if df.iloc[0]['pbRatio'] > 1.5:
            threat.append("poor pbRatio")
        else:
            stren.append("Good PbRatio")
            oppur.append("Lucrative PbRatio")
        if df.iloc[0]['trailingPEG1Y'] > 1:
            threat.append("isn't necessarily supported by growth forecasts")
            weak.append("isn't necessarily supported by growth forecasts")
        else:
            stren.append("not currently accounting for expected earnings growth")
            oppur.append("not currently accounting for expected earnings growth")
        return stren, weak, oppur, threat

class PeAnalysis(analysis):  
    def getAnalysis(self):
        incoming_d = self._metrix["incoming_data"]
        df = pd.DataFrame(incoming_d)
        if df.iloc[0]['peRatio'] > 0:
            print("The Company is Profitable")
            return 1
        else:
            print("The company at loss")
            return "The company at loss"

class pivot_level(analysis):
    def getAnalysis(self):
        incoming_d = self._metrix["intraday"]
        df = pd.DataFrame(incoming_d)
        # pivot_point=0 'high', 'low','close'
        curr_high, curr_low, curr_close = df['high'].tail(1), df['low'].tail(1), df['close'].tail(1)
        pivot_point = (curr_low + curr_high + curr_close) / 3

        resistance_r1 = (2 * pivot_point) - df['low'].tail(1)
        support_s1 = (2 * pivot_point) - df['high'].tail(1)
        resistance_r2 = pivot_point + (df['high'].tail(1) - df['low'].tail(1))
        support_s2 = pivot_point - (df['high'].tail(1) - df['low'].tail(1))
        resistance_r3 = df['high'].tail(1) + (2 * (pivot_point - df['low'].tail(1)))
        support_s3 = df['low'].tail(1) - (2 * (df['high'].tail(1) - pivot_point))
        return resistance_r1, support_s1, resistance_r2, support_s2, resistance_r3, support_s3
# print(intradayChartingPrices(1, 2, 3))

class moving_average(analysis):
    def getAnalysis(self):
        incoming_d = self._metrix["intraday"]
        timeFrame = 7  # Remove afterwards
        df = pd.DataFrame(incoming_d)
        calc_ma = (df['close'].tail(timeFrame).sum()) / timeFrame
        return calc_ma

class chart_moving_average(analysis):
    def getAnalysis(self):
        incoming_d = self._metrix["intraday"]
        timeFrame = 4  # Remove afterwards
        df = pd.DataFrame(incoming_d)
        series_mv = [df.loc[1, "close"], ((df.loc[1, "close"] + df.loc[2, "close"]) / 2),
                     ((df.loc[1, "close"] + df.loc[2, "close"] + df.loc[3, "close"]) / 3),
                     ((df.loc[1, "close"] + df.loc[2, "close"] + df.loc[3, "close"] + df.loc[5, "close"]) / 4)]
        for i in range(timeFrame, len(df)):
            temp = i if i in [0, 1] else (df.loc[i - (timeFrame - 1), 'close'] + df.loc[i - (timeFrame - 1), 'close'] +
                                          df.loc[i - (timeFrame - 1), 'close'] + df.loc[
                                              i - (timeFrame - 1), 'close']) / timeFrame
            series_mv.append(temp)
        return series_mv

class year_on_year(analysis):
    def getAnalysis(self):
        incoming_d = self._metrix["intraday"]
        timeFrame = 7  # Remove afterwards
        df = pd.DataFrame(incoming_d)
        calc_ma = (df['close'].tail(timeFrame).sum()) / timeFrame
        return calc_ma