//
//  RecordEntry.swift
//  Coursework2
//
//  Created by O Malley S (FCES) on 18/03/2022.
//

import UIKit

class NewRecord:NSObject, NSCoding{
    func encode(with coder: NSCoder) {
        
        coder.encode(expenseType, forKey: PropertyKey.expenseType)
        coder.encode(expenseTypeString, forKey: PropertyKey.expenseTypeString)
        coder.encode(dateAdded, forKey: PropertyKey.dateAdded)
        coder.encode(dateAddedString, forKey: PropertyKey.dateAddedString)
        coder.encode(dateIncurred, forKey: PropertyKey.dateIncurred)
        coder.encode(datePaid, forKey: PropertyKey.datePaid)
        coder.encode(receiptPhoto, forKey: PropertyKey.receiptPhoto)
        coder.encode(expenseDetails, forKey:PropertyKey.expenseDetails)
        coder.encode(totalAmount, forKey: PropertyKey.totalAmount)
        coder.encode(isPaid, forKey: PropertyKey.isPaid)
        coder.encode(inclVAT, forKey: PropertyKey.inclVAT)
        coder.encode(receiptSwitch, forKey: PropertyKey.receiptSwitch)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let expenseTypeString = coder.decodeObject(forKey: PropertyKey.expenseTypeString) as? String else{
            print("Unable to decode")
            return nil
        }
        
        guard let dateAdded = coder.decodeObject(forKey: PropertyKey.dateAdded) as? Date else{
            print("Unable to decode")
            return nil
        }
        guard let dateAddedString = coder.decodeObject(forKey: PropertyKey.dateAddedString) as? String else{
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
        guard let totalAmount = coder.decodeObject(forKey: PropertyKey.totalAmount) as? String else{
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
        guard let receiptSwitch = coder.decodeObject(forKey: PropertyKey.receiptSwitch) as? Bool else{
            print("Unable to decode")
            return nil
        }
        /*guard let expenseType = coder.decodeObject(forKey: PropertyKey.expenseType) as? Int else{
            print("Unable to decode")
            return nil
        }*/
        let expenseType = 0
        let receiptPhoto = coder.decodeObject(forKey: PropertyKey.receiptPhoto) as? UIImage
        
        self.init(expenseType:expenseType, expenseTypeString:expenseTypeString, dateAdded:dateAdded, dateAddedString:dateAddedString, dateIncurred:dateIncurred, datePaid:datePaid, receiptPhoto:receiptPhoto, expenseDetails:expenseDetails, totalAmount:totalAmount, isPaid:isPaid, inclVAT:inclVAT, receiptSwitch:receiptSwitch)
        
    }
    
    //var empName: String
    var expenseType: Int
    var expenseTypeString: String
    var dateAdded: Date
    var dateAddedString: String
    var dateIncurred: Date
    var datePaid: Date
    var receiptPhoto: UIImage? // optional
    var expenseDetails: String
    var totalAmount: String
    var isPaid: Bool?
    var inclVAT: Bool?
    var receiptSwitch: Bool?
    
    //constructor
    init?(expenseType: Int, expenseTypeString: String, dateAdded: Date, dateAddedString: String, dateIncurred: Date, datePaid: Date, receiptPhoto: UIImage?, expenseDetails: String, totalAmount: String, isPaid: Bool, inclVAT: Bool, receiptSwitch: Bool){
        if(expenseDetails.isEmpty || totalAmount.isEmpty){
            return nil
        }
        
        self.expenseType = expenseType
        self.expenseTypeString = expenseTypeString
        self.dateAdded = dateAdded
        self.dateAddedString = dateAddedString
        self.dateIncurred = dateIncurred
        self.datePaid = datePaid
        self.receiptPhoto = receiptPhoto
        self.expenseDetails = expenseDetails
        self.totalAmount = totalAmount
        self.isPaid = isPaid
        self.inclVAT = inclVAT
        self.receiptSwitch = receiptSwitch
    }
    struct PropertyKey{
        static let expenseType = "ExpenseType"
        static let expenseTypeString = "ExpenseTypeString"
        static let dateAdded = "DateAdded"
        static let dateAddedString = "DateAddedString"
        static let dateIncurred = "DateIncurred"
        static let datePaid = "DatePaid"
        static let receiptPhoto = "ReceiptPhoto"
        static let expenseDetails = "ExpenseDetails"
        static let totalAmount = "TotalAmount"
        static let isPaid = "IsPaid"
        static let inclVAT = "InclVAT"
        static let receiptSwitch = "ReceiptSwitch"
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("RecordEntries")
}
