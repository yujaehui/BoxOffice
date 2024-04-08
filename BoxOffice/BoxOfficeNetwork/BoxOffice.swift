//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by Jaehui Yu on 4/8/24.
//

import Foundation

// MARK: - BoxOffice
struct BoxOffice: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm, openDt: String

    enum CodingKeys: String, CodingKey {
        case rank
        case movieNm, openDt
    }
}
