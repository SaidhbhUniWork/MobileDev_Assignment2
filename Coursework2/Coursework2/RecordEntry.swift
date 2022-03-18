//
//  RecordEntry.swift
//  Coursework2
//
//  Created by O Malley S (FCES) on 18/03/2022.
//

import UIKit

class NewRecord{
    var empName: String
    var dateAdded: String
    var dateIncurred: Date
    var datePaid: String
    var receiptPhoto: UIImage? // optional
    var expenseDetails: String
    var totalAmount: Double
    var isPaid: Bool
    
    //constructor
    init?(empName: String, dateAdded: String, dateIncurred: Date, datePaid: String, receiptPhoto: UIImage?, expenseDetails: String, totalAmount: Double, isPaid: Bool){
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
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    //static let
}
