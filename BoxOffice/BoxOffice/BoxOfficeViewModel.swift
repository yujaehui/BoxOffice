//
//  BoxOfficeViewModel.swift
//  BoxOffice
//
//  Created by Jaehui Yu on 4/8/24.
//

import Foundation
import RxSwift
import RxCocoa

class BoxOfficeViewModel {
    
    let bag = DisposeBag()
    
    struct Input {
        let selectedDate: ControlProperty<Date>
    }
    
    struct Output {
        let boxOfficeSubject: BehaviorSubject<[DailyBoxOfficeList]>
    }
    
    func transform(input: Input) -> Output {
        var boxOffice: [DailyBoxOfficeList] = []
        lazy var boxOfficeSubject = BehaviorSubject<[DailyBoxOfficeList]>(value: boxOffice)
        
        input.selectedDate
            .map { DateFormatterManager.shared.dateToString($0) }
            .flatMap { 
                BoxOfficeAPIManager.shared.fetchDayBoxOffice(date: $0)
                    .catch { error in
                        return Single<BoxOffice>.never()
                    }
            }
            .debug()
            .subscribe(with: self) { owner, value in
                boxOfficeSubject.onNext(value.boxOfficeResult.dailyBoxOfficeList)
            }.disposed(by: bag)
        
        return Output(boxOfficeSubject: boxOfficeSubject)
    }
}
