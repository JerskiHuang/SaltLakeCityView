//
//  ViewController.swift
//  SaltLakeCityView
//
//  Created by Jerski on 2021/12/18.
//

import UIKit

 class ViewController: UIViewController {

     //IBO
         @IBOutlet weak var slider: UISlider!
         @IBOutlet weak var imageView: UIImageView!
         @IBOutlet weak var datechoose: UIDatePicker!
         @IBOutlet weak var label: UILabel!
         @IBOutlet weak var autoSwitch: UISwitch!
         //設定變數在 @IBAction func yearChangeSlider 中使用
         var sliderNumber = 0
         //設定變數在 func compare和@IBAction func autoTimer 中使用
         var imageNumber = 0
         //讀取系統日期
         let dateformatter = DateFormatter()
         
         let image = [ 1900, 1920, 1940, 1960, 1980, 2000, 2020]
         override func viewDidLoad() {
             super.viewDidLoad()
            
             dateformatter.dateFormat = "yyyy/MM/dd"
         }
         //利用 switch 與 image array 取元件的對應 抓取日期與文字的呈現
         //以下三個 func 均與 autoSwitch 的作用有關。尤其與 timer()搭配的應用
         var dateString : String = ""
         func choosePicture (num1 : Int){
             switch num1 {
             case 0:
                 dateString = "1900/08/01"
             case 1:
                 dateString = "1920/11/01"
             case 2:
                 dateString = "1940/06/01"
             case 3:
                 dateString = "1960/08/01"
             case 4:
                 dateString = "1980/10/01"
             case 5:
                 dateString = "2000/06/01"
             default:
                 dateString = "2020/01/01"
             }
             let date = dateformatter.date(from: dateString)
             datechoose.date = date!
             
             let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datechoose.date)
             let year = dateComponents.year!
             label.text = "\(year)"
        }
         
         //啟動時間timer的寫法
         var timer : Timer?
         func time () {
             timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                 self.compare()
             })
         }
         //利用 if else 比較陣列圖片，用在 @IBAction func autoTimer 上
         func compare () {
             if imageNumber >= image.count {
                 imageNumber = 0
                 choosePicture(num1: imageNumber)
                 imageView.image = UIImage(named: String(image[imageNumber]))
             } else {
                 choosePicture(num1: imageNumber)
                 imageView.image = UIImage(named: String(image[imageNumber]))
             }
             slider.value = Float(imageNumber)
             imageNumber += 1
         }
         
         //改變日期對應image/label/slider的更改 (連datechoose)
         @IBAction func yearChangeDatePicker(_ sender: UIDatePicker) {
             let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datechoose.date)
             let year = dateComponents.year!
             let pictureDate = "\(year)"
             imageView.image = UIImage(named: pictureDate)
             slider.value = Float(year - 1900)
             label.text = "\(year)"
         }
         
         //image/label/datapicker更改 （連slider）
         @IBAction func yearChangeSlider(_ sender: UISlider) {
             sender.value = round(sender.value)
             let newDate = DateComponents(calendar: Calendar.current, year: image[sliderNumber]).date
             datechoose.date = newDate!
             sender.value.round()
             sliderNumber = Int(slider.value)
             label.text = String(image[sliderNumber])
     //        timeLapseImageView.image = UIImage(named: "\(Int(dateSlider.value))")
             imageView.image = UIImage(named: String(image[sliderNumber]))
         }
         
         
         //autoSwitch
         @IBAction func autoTimer(_ sender: UISwitch) {
             if sender.isOn {
                 time()
                 imageNumber = sliderNumber
                 slider.value = Float(imageNumber)
             } else {
                 timer?.invalidate()
             }

     }
     }
