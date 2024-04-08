//
//  BoxOfficeAPI.swift
//  BoxOffice
//
//  Created by Jaehui Yu on 4/8/24.
//

import Foundation

enum BoxOfficeAPI {
    case boxOffice(date: String)
    
    var baseURL: String {
        return "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.apiKey)"
    }
    
    var endPoint: URL {
        switch self {
        case .boxOffice(let date):
            return URL(string: baseURL + "&targetDt=\(date)")!
        }
    }
}
