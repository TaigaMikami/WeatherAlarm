//
//  ViewController.swift
//  WeatherAlarm
//
//  Created by 三上大河 on 2017/05/14.
//  Copyright © 2017年 Gutty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var setDP: UIDatePicker!
    private var tempTime: String = "00:00"
    private var setTime: String = "00:00"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 起動した時点の時刻をmyLabelに反映
        timeLabel.text = getNowTime()
        // 時間管理してくれる
        _ = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    // MARK: Functions

    func getNowTime()-> String {
        // 現在時刻を取得
        let nowTime: NSDate = NSDate()
        // 成形する
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        let nowTimeStr = format.string(from: nowTime as Date)
        // 成形した時刻を文字列として返す
        return nowTimeStr
    }
    
    func update() {
        // 現在時刻を取得
        let str = getNowTime()
        // myLabelに反映
        timeLabel.text = str
        // アラーム鳴らすか判断
        myAlarm(str: str)
    }
    
    func myAlarm(str: String) {
        // 現在時刻が設定時刻と一緒なら
        if str == setTime{
            //alert()
            // 移動先んビューコントローラを参照する
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "weatherPage")
            // トランジションの映像効果を指定する
            nextVC?.modalTransitionStyle = .flipHorizontal
            // シーンを移動する
            present(nextVC!, animated: true, completion: nil)
        }
    }
    
    // アラートの表示
    func alert() {
        let myAlert = UIAlertController(title: "alert", message: "ring ding", preferredStyle: .alert)
        let myAction = UIAlertAction(title: "dong", style: .default) {
            action in print("foo!!")
        }
        myAlert.addAction(myAction)
        present(myAlert, animated: true, completion: nil)
    }

    
    // MARK: IBAAction
    //シーンの遷移関数(あとで消す)
    @IBAction func gotoWeatherPage(_ sender: AnyObject){
        // 移動先んビューコントローラを参照する
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "weatherPage")
        // トランジションの映像効果を指定する
          nextVC?.modalTransitionStyle = .flipHorizontal
        // シーンを移動する
        present(nextVC!, animated: true, completion: nil)
    }


    @IBAction func setDPAction(_ sender: Any) {
        print("test: setDP moved")
        
        // DPの値を成形
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        // 一時的にDPの値を保持
        tempTime = format.string(from: setDP.date)
    }
    
    @IBAction func setButtonAction(_ sender: Any) {
        print("test: myButton Pushed")
        
        // アラームをセット
        setTime = tempTime
        // test print
        print("test: myButton Pushed!")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

