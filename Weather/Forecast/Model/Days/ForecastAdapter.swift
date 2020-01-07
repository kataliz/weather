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
    
    func transformDaysCellVM(from daysForecast: DaysForecast) -> [DayWeatherCellVM] {
        dayFormatter.configure(timezone: daysForecast.city.timezone)
        
        return daysForecast.daysWeather.map { (dayWeather) -> DayWeatherCellVM in
            let date = dayFormatter.formattedDay(from: dayWeather.date)
            let relative = dayFormatter.relativeDay(from: dayWeather.date)
            let dayTemperature = unitFormatter.temperature(dayWeather.temperature.day)
            let nightTemperature = unitFormatter.temperature(dayWeather.temperature.night)
            
            return DayWeatherCellVM(date: date, dateRelative: relative, weatherIcon: dayWeather.condition.icon, dayTemperature: dayTemperature, nightTemperature: nightTemperature)
        }
    }
    
    func transformCurrentVM(from current: CurrentWeather) -> CurrentWeatherVM {
        let temperature = unitFormatter.temperature(current.temperature)
        let feelsLike = "Feels like \(unitFormatter.temperature(current.feelsLike))"
        return CurrentWeatherVM(temperature: temperature, icon: current.condition.icon, feelsLike: feelsLike)
    }
}
