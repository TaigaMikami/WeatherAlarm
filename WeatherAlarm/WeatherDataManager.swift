//
//  WeatherDataManager.swift
//  WeatherAlarm
//
//  Created by 三上大河 on 2017/05/14.
//  Copyright © 2017年 Gutty. All rights reserved.
//

import Foundation


//　必要なフレームワークをインポートする
import Alamofire
import SwiftyJSON

//　AlamofireによるAPI通信を管理
class WeatherDataManager: NSObject{
    
    //　レスポンスデータをパースするモデルクラスのインスタンスを格納すプロパティ
    var weatherData: WeatherDataModel?
    var delegate: WeatherViewController?
    
    
    //　リクエストするurl
    let url = "http://api.openweathermap.org/data/2.5/forecast?units=metric&q=Tokyo&APPID=2ec06eb3d8b93310aa2773a10f1dafe4"
    
    // APIリクエストを実行する
    func dataRequest() {
        
        
        // AlamofireによるAPI通信
        Alamofire.request(url).responseJSON { response in
            switch response.result {
                
            case .success(let value):
                // 通信成功時の処理
                // レスポンスデータをJSON型に変換する
                // これはSwiftyJSONのルール
                let json = JSON(value)
                // JSONデータを引数に渡してモデルクラスのインスタンスを生成
                self.weatherData = WeatherDataModel(data: json)
                // デバッグ用のログ出力を行う
                self.delegate?.checkWeather()
                //self.delegate?.utter(str: "よむよ")
                print(value)
                
            case .failure(let error):
                // 通信失敗時の処理
                // ログ出力だけ
                print(error)
            }
        }
    }
}
