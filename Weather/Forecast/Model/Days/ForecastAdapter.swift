//
//  DayWeatherAdapter.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import Foundation

class ForecastAdapter: IForecastAdapter {
    
    // MARK: Dependencies
    
    private var dayFormatter: IDayLocalFormatter
    private var unitFormatter: IUnitFormatter
    
    // MARK: Lifecycle
    
    init(dayFormatter: IDayLocalFormatter, unitFormatter: IUnitFormatter) {
        self.dayFormatter = dayFormatter
        self.unitFormatter = unitFormatter
    }
    
    // MARK: IForecastAdapter
    
    func transformDaysWeather(from forecast: Forecast) -> ForecastInfo {
        let current = transformCurrentVM(from: forecast.current)
        let days = transformDaysCellVM(from: forecast.days)
        return ForecastInfo(current: current, days: days)
    }
    
    private func transformDaysCellVM(from daysForecast: DaysForecast) -> [DayWeatherInfo] {
        dayFormatter.configure(timezone: daysForecast.city.timezone)
        
        return daysForecast.daysWeather.map { (dayWeather) -> DayWeatherInfo in
            let date = dayFormatter.formattedDay(from: dayWeather.date)
            let relative = dayFormatter.relativeDay(from: dayWeather.date)
            let dayTemperature = unitFormatter.temperature(dayWeather.temperature.day)
            let nightTemperature = unitFormatter.temperature(dayWeather.temperature.night)
            
            return DayWeatherInfo(date: date, dateRelative: relative, weatherIcon: dayWeather.condition.icon, dayTemperature: dayTemperature, nightTemperature: nightTemperature)
        }
    }
    
    private func transformCurrentVM(from current: CurrentWeather) -> CurrentWeatherInfo {
        let temperature = unitFormatter.temperature(current.temperature)
        let feelsLike = "Feels like \(unitFormatter.temperature(current.feelsLike))"
        return CurrentWeatherInfo(temperature: temperature, icon: current.condition.icon, feelsLike: feelsLike)
    }
}
