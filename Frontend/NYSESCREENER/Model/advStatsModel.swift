//
//  advStatsModel.swift
//  NYSESCREENER
//
//  Created by roshan polasa on 5/4/22.
//

import Foundation
import SwiftUI

//{"ticker": "tsla", "indexComparison": [236.22999999999996, 237.40999999999997], "Strength": ["Not in Dow30"], "Weakness": ["Not in Dow30"], "Opportunity": ["Not in Dow30"], "Threat": ["Not in Dow30"], "MovingAverage": 910.5228571428571, "RisK": "Risky as the earn rate coefficient is not under control that is35.57740524781686", "Sentimental": "This stock is sentimentally bearish", "RecommendationValue": [0, -12.160749383180768, 0.22326243194597573, 27.917688136096857], "Recommendation": "BUY BECAUSE STOCK IS OVERSOLD", "fundamental": "Calculated Kutosis Value: 0.32992289859591173 Therefore this stock is Fundamentally Bullish", "Technical": "Technically Calculated value of the stock is 923.42 with a return of 1.53 and if you buy now, the probability of breakeven is 0.4682"}

struct advStatsModel: Codable, Hashable {

    
    var ticker: String?
    var indexComparison: [Double]?
    var Strength: [String]?
    var Weakness: [String]?
    var Opportunity: [String]?
    var Threat: [String]?
    var MovingAverage: Double?
    var ChartMovingAverage: [Double]?
    var YoYgrowth: Double?
    var S1: Double?
    var S2: Double?
    var S3: Double?
    var R1: Double?
    var R2: Double?
    var R3: Double?
    var pe_ratio: String?
    var RisK: String?
    var Sentimental: String?
    var RecommendationValue: [Double]?
    var Recommendation: String?
    var fundamental: String?
    var Technical: String?
    
}

//"ChartMovingAverage": [1085.965, 1085.225, 1087.1333333333332, 1088.3525, 1085.965, 1084.485, 1090.95, 1096.15, 1092.01, 1092.01, 1095.77, 1102.21, 1095.945, 1103.94, 1099.86, 1099.0, 1099.0, 1103.52, 1105.35, 1104.75, 1100.49, 1092.37, 1093.28, 1093.28, 1100.3, 1098.2, 1088.76, 1092.04, 1091.36, 1077.2, 1077.2, 1091.8, 1079.46, 1080.86, 1079.205, 1079.53, 1084.98, 1084.98, 1120.96, 1132.1, 1133.635, 1147.35, 1145.935, 1145.54, 1145.54, 1120.375, 1103.01, 1099.835, 1101.885, 1103.49, 1091.345, 1091.345, 1042.765, 1041.575, 1032.47, 1050.12, 1056.05, 1045.57, 1045.57, 1051.84, 1033.38, 1026.87, 1047.035, 1058.91, 1056.66, 1056.66, 1035.75, 1033.48, 1042.765, 1032.13, 1035.52, 1025.335, 1025.335, 986.23, 984.63, 985.07, 988.44, 987.78, 975.725, 975.725, 997.07, 998.495, 997.6, 990.51, 983.545, 987.01, 987.01, 994.09, 1006.98, 1016.5, 1014.415, 1018.22, 1022.78, 1022.78, 985.86, 988.115, 984.78, 995.57, 987.6, 984.46, 984.46, 984.46, 984.46, 984.46, 984.46, 984.46, 984.46, 984.46, 1003.395, 999.555, 987.93, 1006.385, 1009.255, 1003.97, 1003.97, 1029.5, 1029.06, 1026.47, 1026.49, 1024.55, 1028.225, 1028.225, 1002.13, 989.32, 986.72, 988.4, 977.83, 976.79, 976.79, 1056.79, 1037.195, 1033.64, 1028.5, 1003.09, 1009.15, 1009.15, 1024.71, 1015.24, 1011.0, 1003.01, 1004.77, 1005.175, 1005.175, 994.55, 991.37, 992.93, 995.925, 991.645, 998.17, 998.17, 904.68, 893.66, 902.34, 886.57, 897.87, 875.72, 875.72, 896.255, 901.85, 902.59, 900.48, 886.985, 881.68, 881.68, 838.57, 839.12, 869.385, 878.29, 888.685, 877.49, 877.49, 908.59, 911.06, 895.835, 892.05, 883.68, 870.77, 870.77, 875.86, 877.96, 865.41, 867.2, 871.495, 903.17, 903.17, 908.44, 914.13, 906.97, 916.27], "YOYgrowth": -235.64999999999998, "S1": 909.32, "S2": 909.32, "S3": 909.32, "R1": 909.32, "R2": 909.32, "R3": 909.32, "pe_ratio": "not in DOW30",
