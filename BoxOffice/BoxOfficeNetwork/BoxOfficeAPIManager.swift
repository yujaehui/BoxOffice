//
//  BoxOfficeAPIManager.swift
//  BoxOffice
//
//  Created by Jaehui Yu on 4/8/24.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class BoxOfficeAPIManager {
    static let shared = BoxOfficeAPIManager()
    private init() {}
    
    func fetchDayBoxOffice(date: String) -> Single<BoxOffice> {
        return Single.create { single -> Disposable in
            
            AF.request(BoxOfficeAPI.boxOffice(date: date).endPoint)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: BoxOffice.self) { response in
                    switch response.result {
                    case .success(let success):
                        print(success)
                        single(.success(success))
                    case .failure(let failure):
                        single(.failure(failure))
                    }
                }
            
            return Disposables.create()
        }.debug()
    }
}
