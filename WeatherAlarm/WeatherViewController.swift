//
//  WeatherViewController.swift
//  WeatherAlarm
//
//  Created by 三上大河 on 2017/05/14.
//  Copyright © 2017年 Gutty. All rights reserved.
//

import UIKit
import AVFoundation

class WeatherViewController: UIViewController, AVSpeechSynthesizerDelegate {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    // APIリクエストや、レスポンスデータを利用するためのクラスのインスタンス
    let dataManager = WeatherDataManager()
    
    // 音声用テキスト
    let speechTxt = "時間です！起きてください！時間です！起きてください！"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataManager.delegate = self

        // Do any additional setup after loading the view.
        
        // ここでAPIリクエストを行う
        self.dataManager.dataRequest()
        
        checkWeather()
        
        //　非同期通信確認用
        print("hogehoge")
    }

    
    
    // MARK: Functions
    func checkWeather() {
        //　お天気APIの返却値によって画像を変更する条件式
        if dataManager.weatherData?.weather == "Clouds" {
            // 曇
            weatherImage.image = UIImage(named: "cloud")
        } else if dataManager.weatherData?.weather == "Clear" {
            //　晴れ
            weatherImage.image = UIImage(named: "sunny")
        } else if dataManager.weatherData?.weather == "Rain" {
            // 雨
            weatherImage.image = UIImage(named: "rain")
        }
        
        // 気温ラベルに気温をセット
        tempLabel.text = dataManager.weatherData?.temp.description
//        let weaTxt = dataManager.weatherData?.weather.description
//        let weaTxt2 = weaTxt!
        
        utter(str: speechTxt)
//        print(type(of: tempLabel.text))
//        print(type(of: weaTxt))
    }
    
    //　読み上げ用
    func utter(str:String) {
        let speech = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: str)//読み上げる文字
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")//読み上げの言語
        utterance.rate = 0.4 //読み上げの速度
        utterance.pitchMultiplier = 1.2 //声の高さ
        utterance.preUtteranceDelay = 0 //読み上げまでの待機時間
        utterance.postUtteranceDelay = 0 //読んだあとの待機時間
        speech.delegate = self
        
        speech.speak(utterance) //発話
    }
    
    // デリゲート
    // 読み上げ開始したときに呼ばれる
    internal func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("読み上げ開始")
    }
    
    // 読み上げ終了したときに呼ばれる
    internal func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("読み上げ終了")
    }
    
    
    // MARK: Action
    //　あとで消す
    @IBAction func backAlarmPage (_sender: AnyObject){
        //現在のシーンを閉じてアラーム設定ページに戻る
        self.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}
