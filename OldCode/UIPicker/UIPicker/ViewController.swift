//
//  ViewController.swift
//  UIPicker
//
//  Created by O Malley S (FCES) on 23/03/2022.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let pickerDataSource = ["A", "B", "C", "D", "E", "F"]
    
    
    // UIPicker DataSource Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("You selected a value! - \(pickerDataSource[row])")
    }
    @IBAction func getPickerValueButton(_ sender: UIButton) {
        print(pickerDataSource[letterPicker.selectedRow(inComponent: 0)])
    }
    
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var letterPicker: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func dateSet(_ sender: UIDatePicker) {
        
        print("You selected \(sender.date)")
    }
    
    @IBAction func getDateButton(_ sender: UIButton) {
        //print("Date selected is \(datePicker.date)")
        print(dateFormatter.string(from: datePicker.date))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        
        // Do any additional setup after loading the view.
    }


}


