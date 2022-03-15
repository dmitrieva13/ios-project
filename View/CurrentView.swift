//
//  CurrentView.swift
//  Weather
//
//  Created by Varvara on 01.03.2022.
//

import UIKit

class RightNowView: UIView {

    var dateLabel: UILabel!
    var cityLabel: UILabel!
    var weatherLabel: UILabel!
    var temperatureLabel: UILabel!
    var feelsLikeLabel: UILabel!
    var intro: UILabel!
    var womanImage: UIImageView!
    var manImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dateLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 300, height: 30))
        addSubview(dateLabel)
        dateLabel.textAlignment = .center
        cityLabel = UILabel(frame: CGRect(x: 10, y: 50, width: 290, height: 30))
        addSubview(cityLabel)
        cityLabel.textAlignment = .center
        weatherLabel = UILabel(frame: CGRect(x: 20, y: 92, width: 280, height: 20))
        addSubview(weatherLabel)
        weatherLabel.textAlignment = .center
        temperatureLabel = UILabel(frame: CGRect(x: 20, y: 120, width: 280, height: 70))
        addSubview(temperatureLabel)
        temperatureLabel.textAlignment = .center
        feelsLikeLabel = UILabel(frame: CGRect(x: 20, y: 200, width: 280, height: 30))
        addSubview(feelsLikeLabel)
        feelsLikeLabel.textAlignment = .center
        intro = UILabel(frame: CGRect(x: 20, y: 270, width: 260, height: 20))
        addSubview(intro)
        intro.textAlignment = .center
        
        womanImage = UIImageView(frame: CGRect(x: 10, y: 300, width: 150, height: 190))
        addSubview(womanImage)
        manImage = UIImageView(frame: CGRect(x: 160, y: 300, width: 150, height: 190))
        addSubview(manImage)
      }

      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
      }
    
    func clear() {
        dateLabel.text = ""
        cityLabel.text = ""
        weatherLabel.text = ""
        temperatureLabel.text = ""
        feelsLikeLabel.text = ""
        intro.text = ""
        womanImage.image = nil
        manImage.image = nil
    }
    
    func updateView(currentWeather: Current, city: String) {
        cityLabel.text = city
        cityLabel.highlightedTextColor = .darkGray
        dateLabel.text = Date.getTodaysDate()
        weatherLabel.text = currentWeather.weather[0].description.capitalized
        let temperature = (currentWeather.temp-32)/1.8
        temperatureLabel.text = "\(Int(temperature.rounded()))°C"
        temperatureLabel.font = UIFont(name: temperatureLabel.font.fontName, size: 60)
        temperatureLabel.textColor = .white
        intro.text="Outfits for current weather:"
        
        let feels=(currentWeather.feels_like-32)/1.8
        feelsLikeLabel.text = "Feels like \(Int(feels.rounded()))°C"
        feelsLikeLabel.textColor = .white
        getOutfit(feelsLike: Int(feels.rounded()))
    }

    func getOutfit(feelsLike: Int) {
        if (feelsLike>25){
            womanImage.image=UIImage(named: "summer_w")
            manImage.image=UIImage(named: "summer_m")
        } else if (feelsLike>15){
            womanImage.image=UIImage(named: "chill_w")
            manImage.image=UIImage(named: "chill_m")
        } else if (feelsLike > -5){
            womanImage.image=UIImage(named: "cold_w")
            manImage.image=UIImage(named: "cold_m")
        } else {
            womanImage.image=UIImage(named: "winter_w")
            manImage.image=UIImage(named: "winter_m")
        }
    }
}
