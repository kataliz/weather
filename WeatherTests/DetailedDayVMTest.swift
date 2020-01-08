//
//  DetailedDayVMTest.swift
//  WeatherTests
//
//  Created by Chimit Zhanchipzhapov on 08/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
@testable import Weather

class DetailedDayVMTest: XCTestCase {

    // MARK: Properties
    
    private var detailedDayVM: DetailedDayVM!
    private var didClose: Bool = false
    private var scheduler = TestScheduler(initialClock: 0)
    
    // MARK: XCTestCase
    
    override func setUp() {
        super.setUp()
        let coldDay = DayWeather.mockVeryColdSnowDay()
        let city = ForecastCity.mockParis()
        let locale = Locale(identifier: "en_US")
        let calendar = Calendar(identifier: .gregorian)
        let dayFormatter = DayLocalFormatter(locale: locale, calendar: calendar)
        let adapter = DayDetailedAdapter(dayFormatter: dayFormatter, unitFormatter: UnitFormatter())
        
        detailedDayVM = DetailedDayVM(day: coldDay, city: city, adapter: adapter, onClose: {
            self.didClose = true
        })
    }
    
    override func tearDown() {
        super.tearDown()
        scheduler.stop()
        didClose = false
    }
    
    func testDidClose() {
        let close = PublishSubject<Void>()
        
        scheduler.scheduleAt(201) {
            close.onNext(())
        }
        
        let _ = scheduler.start { () -> Observable<Void> in
            let output = self.detailedDayVM.transform(input: DetailedDayVC.Input(tapOnClose: close.asObservable()))
            return output.hold
        }
        
        XCTAssertTrue(didClose)
    }
    
    func testTransform() {
        let close = PublishSubject<Void>()
        
        let result = scheduler.start { () -> Observable<[DayDetailedCellInfo]> in
            let output = self.detailedDayVM.transform(input: DetailedDayVC.Input(tapOnClose: close.asObservable()))
            return output.dayDetailed
        }
        
        XCTAssertEqual((result.events.first?.value.element?.first as? DetailedTemperatureCellInfo)?.relative, .cold)
        XCTAssertEqual((result.events.first?.value.element?.first as? DetailedTemperatureCellInfo)?.feels.day, "-23°")
    }
}
