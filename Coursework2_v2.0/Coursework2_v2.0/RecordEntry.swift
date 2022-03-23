//
//  RecordEntry.swift
//  Coursework2
//
//  Created by O Malley S (FCES) on 18/03/2022.
//

import UIKit

class NewRecord:NSObject, NSCoding{
    func encode(with coder: NSCoder) {
        coder.encode(empName, forKey: PropertyKey.empName)
        coder.encode(dateAdded, forKey: PropertyKey.dateAdded)
        coder.encode(dateIncurred, forKey: PropertyKey.dateIncurred)
        coder.encode(datePaid, forKey: PropertyKey.datePaid)
        coder.encode(receiptPhoto, forKey: PropertyKey.receiptPhoto)
        coder.encode(expenseDetails, forKey:PropertyKey.expenseDetails)
        coder.encode(totalAmount, forKey: PropertyKey.totalAmount)
        coder.encode(isPaid, forKey: PropertyKey.isPaid)
        coder.encode(inclVAT, forKey: PropertyKey.inclVAT)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let empName = coder.decodeObject(forKey: PropertyKey.empName) as? String else{
            print("Unable to decode")
            return nil
        }
        guard let dateAdded = coder.decodeObject(forKey: PropertyKey.dateAdded) as? Date else{
            print("Unable to decode")
            return nil
        }
        guard let dateIncurred = coder.decodeObject(forKey: PropertyKey.dateIncurred) as? Date else{
            print("Unable to decode")
            return nil
        }
        guard let datePaid = coder.decodeObject(forKey: PropertyKey.datePaid) as? Date else{
            print("Unable to decode")
            return nil
        }
        guard let expenseDetails = coder.decodeObject(forKey: PropertyKey.expenseDetails) as? String else{
            print("Unable to decode")
            return nil
        }
        guard let totalAmount = coder.decodeObject(forKey: PropertyKey.totalAmount) as? Double else{
            print("Unable to decode")
            return nil
        }
        guard let isPaid = coder.decodeObject(forKey: PropertyKey.isPaid) as? Bool else{
            print("Unable to decode")
            return nil
        }
        guard let inclVAT = coder.decodeObject(forKey: PropertyKey.inclVAT) as? Bool else{
            print("Unable to decode")
            return nil
        }
        let receiptPhoto = coder.decodeObject(forKey: PropertyKey.receiptPhoto) as? UIImage
        
        self.init(empName:empName, dateAdded:dateAdded, dateIncurred:dateIncurred, datePaid:datePaid, receiptPhoto:receiptPhoto, expenseDetails:expenseDetails, totalAmount:totalAmount, isPaid:isPaid, inclVAT:inclVAT)
        
    }
    
    var empName: String
    var dateAdded: Date
    var dateIncurred: Date
    var datePaid: Date
    var receiptPhoto: UIImage? // optional
    var expenseDetails: String
    var totalAmount: Double
    var isPaid: Bool
    var inclVAT: Bool
    
    //constructor
    init?(empName: String, dateAdded: Date, dateIncurred: Date, datePaid: Date, receiptPhoto: UIImage?, expenseDetails: String, totalAmount: Double, isPaid: Bool, inclVAT: Bool){
        if(empName.isEmpty || expenseDetails.isEmpty || totalAmount.isZero){
            return nil
        }
        
        self.empName = empName
        self.dateAdded = dateAdded
        self.dateIncurred = dateIncurred
        self.datePaid = datePaid
        self.receiptPhoto = receiptPhoto
        self.expenseDetails = expenseDetails
        self.totalAmount = totalAmount
        self.isPaid = isPaid
        self.inclVAT = inclVAT
    }
    struct PropertyKey{
        static let empName = "Name"
        static let dateAdded = "DateAdded"
        static let dateIncurred = "DateIncurred"
        static let datePaid = "DatePaid"
        static let receiptPhoto = "ReceiptPhoto"
        static let expenseDetails = "ExpenseDetails"
        static let totalAmount = "TotalAmount"
        static let isPaid = "IsPaid"
        static let inclVAT = "InclVAT"
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("RecordEntries")
}
