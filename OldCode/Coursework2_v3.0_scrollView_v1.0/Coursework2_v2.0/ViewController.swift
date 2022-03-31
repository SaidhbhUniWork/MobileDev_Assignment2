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
extension Double{
    func toString() -> String?{
        return String(format: "%.1f", self)
    }
}

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    

    var record:NewRecord?
    var pickerValue: Int?
    let dateFormatter = DateFormatter()
    var date = Date()
    let pickerDataSource = ["Petrol", "Stationary", "Food", "Travel", "Postage", "Other"]
        
    @IBOutlet weak var expenseTypePicker: UIPickerView!
    @IBOutlet weak var currentDate: UIDatePicker!
    @IBOutlet weak var expenseDate: UIDatePicker!
    @IBOutlet weak var receiptSwitch: UISwitch!
    @IBOutlet weak var receiptImage: UIImageView!
    @IBOutlet weak var expenseDetailsTextField: UITextField!
    @IBOutlet weak var totalPriceTextField: UITextField!
    @IBOutlet weak var vatSwitch: UISwitch!
    @IBOutlet weak var isPaidSwitch: UISwitch!
    @IBOutlet weak var paidDate: UIDatePicker!
    @IBOutlet weak var datePaidLabel: UILabel!
    @IBOutlet weak var paidSwitchLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func CancelNewRecord(_ sender: UIBarButtonItem) {
        // is the parent a navigation view controller?
        let isPresentingInAddContactMode = presentingViewController is UINavigationController
        if isPresentingInAddContactMode{
            dismiss(animated: true, completion: nil)    // works for modal view
        } else{
            // dismiss back to table view
            if let owningNavigationController = navigationController{
                owningNavigationController.popViewController(animated: true)    // if view is 'pushed' then we need to 'pop' it from view
            }
        }
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // hides the keyboard from view
        expenseDetailsTextField.resignFirstResponder()
        // launches the UIImagePicker controller to select a photo from the library
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion:nil)
    }
    
    @IBAction func getPickerValue(_ sender:UIPickerView){
        //let pickerIndex = expenseTypePicker.selectedRow(inComponent: 0)
        //pickerValue = pickerDataSource[pickerIndex]
    }
    
    
    
    //MARK: - Toggle Switch Actions
    @IBAction func recieptSwitchToggleAction(_ sender: UISwitch) {
        if sender.isOn == false{
            receiptImage.isHidden = true
        } else{
            receiptImage.isHidden = false
        }
    }
    
    @IBAction func vatSwitchToggleAction(_ sender: UISwitch) {
        
        let isPresentingInAddContactMode = presentingViewController is UINavigationController
        let VATpercent = 1.2
        var totalAmountAsDouble = totalPriceTextField.text?.toDouble()
        var totalInclVAT = (totalAmountAsDouble ?? 0.0)*VATpercent
        var totalExclVAT = (totalAmountAsDouble ?? 0.0)/VATpercent
        if !isPresentingInAddContactMode{

            if sender.isOn == false {
                totalPriceTextField.text = totalExclVAT.toString()
            }
            if sender.isOn == true {
                totalPriceTextField.text = totalInclVAT.toString()
            }
        }
    }
    @IBAction func isPaidSwitchToggleAction(_ sender: UISwitch) {
        let isPresentingInAddContactMode = presentingViewController is UINavigationController
        if !isPresentingInAddContactMode{
            if sender.isOn == true{
                isPaidSwitch.isOn = true
                
            }
        }
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        receiptSwitch .setOn(false, animated: true)
        isPaidSwitch .setOn(false, animated: true)

        // formatting the date to correct output
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMdYYYY")
        
        let isPresentingInAddContactMode = presentingViewController is UINavigationController
        if isPresentingInAddContactMode{
            isPaidSwitch.isEnabled = false
            paidDate.isEnabled = false
            datePaidLabel.isEnabled = false
            paidSwitchLabel.isEnabled = false
            receiptImage.isHidden = true
        } else{
            isPaidSwitch.isEnabled = true
            paidDate.isEnabled = true
            datePaidLabel.isEnabled = true
            paidSwitchLabel.isEnabled = true
        }
        
        // allows the user keyboard to be dismissed when not in use
        let screenTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        // prevents the 'dismissal' of keyboard from interfering with or cancelling any other interactions
        screenTap.cancelsTouchesInView = false
        // adds a new gesture recogsiser to the view
        view.addGestureRecognizer(screenTap)
        
        if let record = record{
            
            expenseTypePicker.selectRow(record.expenseType, inComponent: 0, animated: true)
            currentDate.date = record.dateAdded
            expenseDate.date = record.dateIncurred
            receiptSwitch.isOn = record.receiptSwitch ?? false
            receiptImage.image = record.receiptPhoto
            expenseDetailsTextField.text = record.expenseDetails
            totalPriceTextField.text = record.totalAmount
            vatSwitch.isOn = record.inclVAT ?? true
            isPaidSwitch.isOn = record.isPaid!
            paidDate.date = record.datePaid
            if receiptSwitch.isOn == true{
                receiptImage.isHidden = false
            }
            //if (hasPhotoBeenChosen == true){ //(receiptImage != nil) == false{
            if receiptSwitch.isOn == false{
                receiptImage.isHidden = true
            }
        }
    }
    // function is called when a tap gesture is recognised
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    // MARK: - Prepare for Segue
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){

        guard let button =  sender as? UIBarButtonItem, button === saveButton
        else{
            return;
        }
        let expenseType = expenseTypePicker.selectedRow(inComponent: 0)
        let expenseTypeString = pickerDataSource[expenseTypePicker.selectedRow(inComponent: 0)]
        let dateAdded = currentDate.date
        let dateIncurred = expenseDate.date
        let dateAddedString = dateFormatter.string(from: expenseDate.date)
        let datePaid = paidDate.date
        let receiptPhoto = receiptImage.image
        let expenseDetails = expenseDetailsTextField.text ?? ""
        let totalAmount = totalPriceTextField.text ?? ""
        let isPaid = isPaidSwitch.isOn
        let inclVAT = vatSwitch.isOn
        let receiptSwitch = receiptSwitch.isOn
                    
        record = NewRecord(expenseType: expenseType, expenseTypeString: expenseTypeString, dateAdded: dateAdded, dateAddedString: dateAddedString, dateIncurred: dateIncurred, datePaid: datePaid, receiptPhoto: receiptPhoto, expenseDetails: expenseDetails, totalAmount: totalAmount, isPaid: isPaid, inclVAT: inclVAT, receiptSwitch: receiptSwitch)
    }
    
    // UIPicker Datasource functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //MARK: - PickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerValue = expenseTypePicker.selectedRow(inComponent: 0)
        //pickerValue = pickerDataSource[expenseTypePicker.selectedRow(inComponent: 0)]
        //pickerValue = expenseTypePicker.selectedRow(inComponent: 0)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    //MARK: - ImagePicker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            print("Error loading image, dismissing image picker")
            dismiss(animated: true, completion: nil)
            return
        }
        // show the selected image
        receiptImage.image = selectedImage
        dismiss(animated: true, completion: nil)
         
    }
}


