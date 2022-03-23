//
//  ViewController.swift
//  Coursework2_v2.0
//
//  Created by O Malley S (FCES) on 21/03/2022.
//
 
import UIKit

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
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func CancelNewRecord(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        guard let button =  sender as? UIBarButtonItem, button === saveButton
        else{
            return;
        }
        let empName = employeeNameTextField.text
        let dateAdded = currentDate.date
        let dateIncurred = expenseDate.date
        let
        
    }

}

