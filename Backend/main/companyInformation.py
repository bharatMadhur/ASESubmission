import sys
sys.path.append("..")
from main.apiConnection import *


class companyInformation():
    def getInformation(self, stockName):
        apifactory = apiConnectionFactory()
        apiCon = apifactory.getConnection("Company information") #api connection
        return apiCon.request(stockName)
