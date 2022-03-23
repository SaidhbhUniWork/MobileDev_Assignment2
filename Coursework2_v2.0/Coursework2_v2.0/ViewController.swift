//
//  ViewController.swift
//  Coursework2_v2.0
//
//  Created by O Malley S (FCES) on 21/03/2022.
//
 
import UIKit

extension String{
    func toDouble() -> Double?{
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
class ViewController: UIViewController {

    var record:NewRecord?
    
    
    @IBOutlet weak var employeeNameTextField: UITextField!
    @IBOutlet weak var currentDate: UIDatePicker!
    @IBOutlet weak var expenseDate: UIDatePicker!
    @IBOutlet weak var receiptSwitch: UISwitch!
    @IBOutlet weak var receiptImage: UIImageView!
    @IBOutlet weak var expenseDetailsTextField: UITextField!
    @IBOutlet weak var totalPriceTextField: UITextField!
    @IBOutlet weak var vatSwitch: UISwitch!
    @IBOutlet weak var isPaidSwitch: UISwitch!
    @IBOutlet weak var paidDate: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func CancelNewRecord(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenTap = UITapGestureRecognizer(target: self, action selector(UIInputViewController.))
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        guard let button =  sender as? UIBarButtonItem, button === saveButton
        else{
            return;
        }
        
        let dateAdded = currentDate.date
        let dateIncurred = expenseDate.date
        let datePaid = paidDate.date
        let receiptPhoto = receiptImage.image
        let expenseDetails = expenseDetailsTextField.text ?? ""
        let total_asString = totalPriceTextField.text ?? ""
        let totalAmount = total_asString.toDouble()
        let isPaid = isPaidSwitch.isOn
        let inclVAT = vatSwitch.isOn
        let empName = employeeNameTextField.text ?? ""
        
        record = NewRecord(empName: empName, dateAdded: dateAdded, dateIncurred: dateIncurred, datePaid: datePaid, receiptPhoto: receiptPhoto, expenseDetails: expenseDetails, totalAmount: totalAmount!, isPaid: isPaid, inclVAT: inclVAT)
    }

}


