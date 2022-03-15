//
//  ForecastView.swift
//  Weather
//
//  Created by Varvara on 01.03.2022.
//

import UIKit

class WeatherDetailView: UIView {

    var segmentedControl: UISegmentedControl!
    
    var topLabel1: UILabel!
    var topLabel2: UILabel!
    var topLabel3: UILabel!
    var topLabel4: UILabel!
    var topLabel5: UILabel!
    
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    var imageView3: UIImageView!
    var imageView4: UIImageView!
    var imageView5: UIImageView!
    
    var bottomLabel1: UILabel!
    var bottomLabel2: UILabel!
    var bottomLabel3: UILabel!
    var bottomLabel4: UILabel!
    var bottomLabel5: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        
        segmentedControl = UISegmentedControl(items: ["Hourly","Daily"])
        segmentedControl.frame = CGRect(x: 100, y: 2, width: 80, height: 15)
        
        addSubview(segmentedControl)
        
        topLabel1 = UILabel(frame: CGRect(x: 20, y: 15, width: 40, height: 20))
        addSubview(topLabel1)
        topLabel2 = UILabel(frame: CGRect(x: 70, y: 15, width: 40, height: 20))
        addSubview(topLabel2)
        topLabel3 = UILabel(frame: CGRect(x: 120, y: 15, width: 40, height: 20))
        addSubview(topLabel3)
        topLabel4 = UILabel(frame: CGRect(x: 170, y: 15, width: 40, height: 20))
        addSubview(topLabel4)
        topLabel5 = UILabel(frame: CGRect(x: 220, y: 15, width: 40, height: 20))
        addSubview(topLabel5)
        
        bottomLabel1 = UILabel(frame: CGRect(x: 20, y: 75, width: 40, height: 20))
        addSubview(bottomLabel1)
        bottomLabel2 = UILabel(frame: CGRect(x: 70, y: 75, width: 40, height: 20))
        addSubview(bottomLabel2)
        bottomLabel3 = UILabel(frame: CGRect(x: 120, y: 75, width: 40, height: 20))
        addSubview(bottomLabel3)
        bottomLabel4 = UILabel(frame: CGRect(x: 170, y: 75, width: 40, height: 20))
        addSubview(bottomLabel4)
        bottomLabel5 = UILabel(frame: CGRect(x: 220, y: 75, width: 40, height: 20))
        addSubview(bottomLabel5)
        
        imageView1 = UIImageView(frame: CGRect(x: 20, y: 40, width: 40, height: 30))
        addSubview(imageView1)
        imageView2 = UIImageView(frame: CGRect(x: 70, y: 40, width: 40, height: 30))
        addSubview(imageView2)
        imageView3 = UIImageView(frame: CGRect(x: 120, y: 40, width: 40, height: 30))
        addSubview(imageView3)
        imageView4 = UIImageView(frame: CGRect(x: 170, y: 40, width: 40, height: 30))
        addSubview(imageView4)
        imageView5 = UIImageView(frame: CGRect(x: 220, y: 40, width: 40, height: 30))
        addSubview(imageView5)
      }

      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
      }
    
    func clear() {
        let labels = [topLabel1, topLabel2, topLabel3, topLabel4, topLabel5, bottomLabel1, bottomLabel2, bottomLabel3, bottomLabel4, bottomLabel5], images = [imageView1, imageView2, imageView3, imageView4, imageView5]
        for label in labels {
            label?.text = ""
        }
        for image in images {
            image?.image = nil
        }
    }
    
    func updateViewForToday(_ hourly: [Hourly]) {
        updateHours(hourly: hourly)
    }
    
    func updateViewForWeekly(_ daily: [Daily]) {
        updateDays(daily: daily)
    }
    
    func getSelectedTitle() -> String {
        let index = segmentedControl.selectedSegmentIndex
        let title = segmentedControl.titleForSegment(at: index) ?? ""
        
        return title
        
    }
    
    func updateHours(hourly: [Hourly]) {
        let topLabels = [topLabel1, topLabel2, topLabel3, topLabel4, topLabel5], bottomLabels = [bottomLabel1, bottomLabel2, bottomLabel3, bottomLabel4, bottomLabel5], images = [imageView1, imageView2, imageView3, imageView4, imageView5]
        print(hourly.count)
        for i in 0...4 {
            
            let hour = hourly[i + 1]
            let date = Date(timeIntervalSince1970: Double(hour.dt))
            let hourString = Date.getHourFrom(date: date)
            let weatherIconName = hour.weather[0].icon
            let weatherTemperature = hour.temp
            
            topLabels[i]?.text = hourString
            images[i]?.image = UIImage(named: weatherIconName)
            bottomLabels[i]?.text = "\(Int(weatherTemperature.rounded()))°F"
        }
        
    }
    
    func updateDays(daily: [Daily]) {
        let topLabels = [topLabel1, topLabel2, topLabel3, topLabel4, topLabel5], bottomLabels = [bottomLabel1, bottomLabel2, bottomLabel3, bottomLabel4, bottomLabel5], images = [imageView1, imageView2, imageView3, imageView4, imageView5]
        for i in 0...4 {
            
            let day = daily[i + 2]
            let date = Date(timeIntervalSince1970: Double(day.dt))
            let dayString = Date.getDayOfWeekFrom(date: date)
            let weatherIconName = day.weather[0].icon
            let weatherTemperature = day.temp.day
            
            topLabels[i]?.text = dayString
            images[i]?.image = UIImage(named: weatherIconName)
            bottomLabels[i]?.text = "\(Int(weatherTemperature.rounded()))°C"
        }
    }
}
