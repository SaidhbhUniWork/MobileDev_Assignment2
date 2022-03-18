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
    var receiptPhoto: UIImage?
    var expenseDetails: String
    var totalAmount: Double
    var isPaid: Bool
    
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
}
