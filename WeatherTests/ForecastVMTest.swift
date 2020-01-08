//
//  ForecastVMTest.swift
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

class ForecastVMTest: XCTestCase {

    // MARK: Properties
    
    private var forecastVM: ForecastVM!
    private var mockProvider = MockForecastProvider()
    private var mockStorage = MockCacheStorage()
    private var daySelected: DayWeather?
    private var scheduler = TestScheduler(initialClock: 0)
    
    // MARK: XCTestCase
    
    override func setUp() {
        super.setUp()
        let locale = Locale(identifier: "en_US")
        let calendar = Calendar(identifier: .gregorian)
        let dayFormatter = DayLocalFormatter(locale: locale, calendar: calendar)
        let adapter = ForecastAdapter(dayFormatter: dayFormatter, unitFormatter: UnitFormatter())
        forecastVM = ForecastVM(adapter: adapter, provider: mockProvider, storage: mockStorage, scheduler: scheduler, onSelect: { (day, city) in
            self.daySelected = day
        })
    }

    override func tearDown() {
        super.tearDown()
        daySelected = nil
        mockStorage.clear()
        mockProvider.clear()
        scheduler.stop()
    }
    
    func testTransformDays() {
        let reload = PublishSubject<Void>()
        let selected = PublishSubject<Int>()

        scheduler.scheduleAt(201) {
            reload.onNext(())
        }
        
        scheduler.scheduleAt(203) {
            self.mockProvider.configure(with: Forecast.mockFull())
        }

        let result = scheduler.start { () -> Observable<ForecastInfo> in
            let output = self.forecastVM.transform(input: ForecastVC.Input(reload: reload.asObservable(), selected: selected.asObservable()))
            return output.forecast
        }

        XCTAssertEqual(result.events.count, 1)
        XCTAssertEqual(result.events.first?.value.element?.days.first?.nightTemperature, "-25°")
        XCTAssertEqual(result.events.first?.value.element?.days.first?.date, "08 January")
    }
    
    func testTransformCurrent() {
        let reload = PublishSubject<Void>()
        let selected = PublishSubject<Int>()

        scheduler.scheduleAt(201) {
            reload.onNext(())
        }
        
        scheduler.scheduleAt(203) {
            self.mockProvider.configure(with: Forecast.mockFull())
        }
        
        let result = scheduler.start { () -> Observable<ForecastInfo> in
            let output = self.forecastVM.transform(input: ForecastVC.Input(reload: reload.asObservable(), selected: selected.asObservable()))
            return output.forecast
        }

        XCTAssertEqual(result.events.count, 1)
        XCTAssertEqual(result.events.first?.value.element?.current.feelsLike, "Feels like -19°")
        XCTAssertEqual(result.events.first?.value.element?.current.temperature, "-14°")
    }
    
    func testReload() {
        let reload = PublishSubject<Void>()
        let selected = PublishSubject<Int>()

        scheduler.scheduleAt(201) {
            reload.onNext(())
        }
        
        scheduler.scheduleAt(203) {
            reload.onNext(())
        }
        
        scheduler.scheduleAt(204) {
            self.mockProvider.configure(with: Forecast.mockFull())
        }
                
        scheduler.scheduleAt(220) {
            reload.onNext(())
        }

        scheduler.scheduleAt(230) {
            self.mockProvider.configure(with: Forecast.mockFullHot())
        }

        let result = scheduler.start { () -> Observable<ForecastInfo> in
            let output = self.forecastVM.transform(input: ForecastVC.Input(reload: reload.asObservable(), selected: selected.asObservable()))
            return output.forecast
        }
        
        XCTAssertEqual(result.events.count, 2)
        XCTAssertEqual(result.events[0].value.element?.current.feelsLike, "Feels like -19°")
        XCTAssertEqual(result.events[0].value.element?.current.temperature, "-14°")
        XCTAssertEqual(result.events[1].value.element?.current.temperature, "+22°")
    }
    
    func testShownError() {
        let reload = PublishSubject<Void>()
        let selected = PublishSubject<Int>()

        scheduler.scheduleAt(201) {
            reload.onNext(())
        }
        
        scheduler.scheduleAt(204) {
            self.mockProvider.configure(error: NetworkError.parsingFailed)
        }
                
        scheduler.scheduleAt(210) {
            reload.onNext(())
        }

        scheduler.scheduleAt(220) {
            self.mockProvider.configure(with: Forecast.mockFullHot())
        }
        
        scheduler.scheduleAt(230) {
            reload.onNext(())
        }
        
        scheduler.scheduleAt(240) {
            self.mockProvider.configure(error: NetworkError.parsingFailed)
        }

        let result = scheduler.start { () -> Observable<Bool> in
            let output = self.forecastVM.transform(input: ForecastVC.Input(reload: reload.asObservable(), selected: selected.asObservable()))
            return output.isErrorHidden
        }
        
        XCTAssertEqual(result.events.count, 4)
        XCTAssertEqual(result.events[1].value.element, false)
        XCTAssertEqual(result.events[2].value.element, true)
        XCTAssertEqual(result.events[3].value.isCompleted, true)
    }
    
    func testSelect() {
        let reload = PublishSubject<Void>()
        let selected = PublishSubject<Int>()
        let mockForecast = Forecast.mockFull()
        
        scheduler.scheduleAt(201) {
            reload.onNext(())
        }
        
        scheduler.scheduleAt(203) {
            self.mockProvider.configure(with: mockForecast)
        }
        
        scheduler.scheduleAt(210) {
            selected.onNext(mockForecast.days.daysWeather.count - 1)
        }
        
        let _ = scheduler.start { () -> Observable<Void> in
            let output = self.forecastVM.transform(input: ForecastVC.Input(reload: reload.asObservable(), selected: selected.asObservable()))
            return output.hold
        }

        XCTAssertEqual(daySelected?.date, Forecast.mockFull().days.daysWeather.last?.date)
    }
}
