import sys
sys.path.append("..")
from main.apiConnection import *

# apifactory = apiConnectionFactory()
# apiCon = apifactory.getConnection("Company information") #api connection
# apiCon.request("AMZN")
class forexInformation():
    def getInformation(self):
        apifactory = apiConnectionFactory()
        apiCon = apifactory.getConnection("forex") #api connection
        return apiCon.request()
    
# forex = forexInformation()
# print(forex.getInformation())