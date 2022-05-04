import sys

sys.path.append("..")
from flask import Flask, request
from main.stock import *
import json
from main.companyInformation import *
from main.forex import *

app = Flask(_name_)

stockCode = "AMZN"
print(stockCode)
Stock = stock(stockCode)
print(Stock.analysis("Sentiment analysis"))


@app.route('/metaData', methods=['GET'])
def meta():
    args = request.args
    name = args.get("name", default="", type=str)
    metaData = companyInformation.getInformation(name)
    return json.dumps(metaData)



@app.route('/search', methods=['GET'])
def search():
    args = request.args
    name = args.get("name", default="", type=str)
    Stock = stock(stockCode)
    analysis = [Stock.analysis("Recommendation analysis"),Stock.analysis("risk analysis"),
                Stock.analysis("Sentiment analysis"),Stock.analysis("Fundenmential analysis"),
                Stock.analysis("Technical analysis"),Stock.analysis("SWOT analysis"),
                Stock.analysis("Pe analysis"),Stock.analysis("pivot level"),
                Stock.analysis("moving average"),Stock.analysis("chart moving average"),Stock.analysis("year_on_year")]
    return json.dumps(analysis)


@app.route('/forex')
def currency():
    return json.dumps(forexInformation.getInformation())


if _name_ == '_main_':
    app.run(host='0.0.0.0', port=3000)
