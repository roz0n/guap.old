//
//  ERPairConversionModel.swift
//  Guap
//
//  Created by Arnaldo Rozon on 2/2/21.
//

import Foundation

struct ERPairConversionModel: Codable {
    var result: String
    var documentation: String
    var termsOfUse: String
    var timeLastUpdateUnix: Int
    var timeLastUpdateUtc: String
    var timeNextUpdateUnix: Int
    var timeNextUpdateUtc: String
    var baseCode: String
    var targetCode: String
    var conversionRate: Float
}
