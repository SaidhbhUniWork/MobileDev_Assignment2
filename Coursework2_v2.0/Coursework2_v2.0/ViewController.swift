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
class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

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
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // hides the keyboard from view
        employeeNameTextField.resignFirstResponder()
        // launches the UIImagePicker controller to select a photo from the library
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //nallows the user keyboard to be dismissed when not in use
        let screenTap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        // prevents the 'dismissal' of keyboard from interfering with or cancelling any other interactions
        screenTap.cancelsTouchesInView = false
        
        // adds a new gesture recogsiser to the view
        view.addGestureRecognizer(screenTap)
        // Do any additional setup after loading the view.
    }
    // function is called when a tap gesture is recognised
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        let totalAmount = total_asString.toDouble() ?? 0.0
        let isPaid = isPaidSwitch.isOn
        let inclVAT = vatSwitch.isOn
        let empName = employeeNameTextField.text ?? ""
        
        record = NewRecord(empName: empName, dateAdded: dateAdded, dateIncurred: dateIncurred, datePaid: datePaid, receiptPhoto: receiptPhoto, expenseDetails: expenseDetails, totalAmount: totalAmount, isPaid: isPaid, inclVAT: inclVAT)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //if receiptSwitch.isOn {
            guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
                print("Error loading image, dismissing image picker")
                dismiss(animated: true, completion: nil)
                return
            }
            // show the selected image
            receiptImage.image = selectedImage
            dismiss(animated: true, completion: nil)
            
        /*}
        else{
            let alert = UIAlertController(title: "No Photo Enabled", message: "If you wish to upload a photo turn on 'Have Photo'", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            self.present(alert, animated: true)
        }*/
        
    }
    
    //func switchValueChanged(mySwitch: UISwitch){
     //   if !mySwitch.isOn
    //}

}


