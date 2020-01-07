//
//  DayDetailedAdapter.swift
//  Weather
//
//  Created by Chimit Zhanchipzhapov on 06/01/2020.
//  Copyright © 2020 Chimit Zhanchipzhapov. All rights reserved.
//

import UIKit

class DayDetailedAdapter: IDayDetailedAdapter {
    
    // MARK: Dependencies
    
    private var dayFormatter: IDayLocalFormatter
    private var unitFormatter: IUnitFormatter
    
    // MARK: Lifecycle
    
    init(dayFormatter: IDayLocalFormatter, unitFormatter: IUnitFormatter) {
        self.dayFormatter = dayFormatter
        self.unitFormatter = unitFormatter
    }
    
    // MARK: IDayDetailedAdapter
    
    func dayName(dayInfo: DayWeather, for city: ForecastCity) -> String {
        dayFormatter.configure(timezone: city.timezone)
        return dayFormatter.formattedDay(from: dayInfo.date)
    }
    
    func transform(dayInfo: DayWeather, for city: ForecastCity) -> [DayDetailedCellVM] {
        dayFormatter.configure(timezone: city.timezone)
        var trasnformed = [DayDetailedCellVM]()
        trasnformed.append(temperature(dayInfo: dayInfo))
        trasnformed.append(SeparatorCellVM())
        trasnformed.append(contentsOf: units(dayInfo: dayInfo))
        trasnformed.append(SeparatorCellVM())
        trasnformed.append(contentsOf: sunset(dayInfo: dayInfo))
        
        return trasnformed
    }
    
    // MARK: Properties
    
    private func temperature(dayInfo: DayWeather) -> DayDetailedCellVM {
        let temperatureDay = unitFormatter.dayTemperature(from: dayInfo.temperature)
        let feelsTemperature = unitFormatter.dayTemperature(from: dayInfo.feelsLike)
        let relative = TemperatureRelative(temperature: dayInfo.temperature.day)
        
        return DetailedTemperatureCellVM(name: "Temperature", icon: #imageLiteral(resourceName: "temperature_icon"), relative: relative, value: temperatureDay, feels: feelsTemperature)
    }
    
    private func units(dayInfo: DayWeather) -> [DayDetailedCellVM] {
        let pressure = DetailedUnitCellVM(icon: #imageLiteral(resourceName: "pressure_icon"), name: "Pressure", info: unitFormatter.pressure(dayInfo.pressure))
        let humidity = DetailedUnitCellVM(icon: #imageLiteral(resourceName: "wet_icon"), name: "Humidity", info: unitFormatter.humidity(dayInfo.humidity))
        let wind = DetailedUnitCellVM(icon: #imageLiteral(resourceName: "wind_icon"), name: "Wind", info: unitFormatter.wind(dayInfo.windSpeed, degrees: dayInfo.windDegree))
        
        var unitsResults = [pressure,humidity,wind]
        
        if let rainVolume = dayInfo.rainVolume {
            unitsResults.append(DetailedUnitCellVM(icon: #imageLiteral(resourceName: "volume_icon"), name: "Rain", info: unitFormatter.volume(rainVolume)))
        }
        
        if let snowVolume = dayInfo.snowVolume {
            unitsResults.append(DetailedUnitCellVM(icon: #imageLiteral(resourceName: "volume_icon"), name: "Snow", info: unitFormatter.volume(snowVolume)))
        }
        
        return unitsResults
    }
    
    private func sunset(dayInfo: DayWeather) -> [DayDetailedCellVM] {
        let sunrise = DetailedUnitCellVM(icon: #imageLiteral(resourceName: "sunrise_icon"), name: "Sunrise", info: dayFormatter.formattedTime(from: dayInfo.sunrise))
        let sunset = DetailedUnitCellVM(icon: #imageLiteral(resourceName: "sunset_icon"), name: "Sunset", info: dayFormatter.formattedTime(from: dayInfo.sunset))
        return [sunrise,sunset]
    }
}
