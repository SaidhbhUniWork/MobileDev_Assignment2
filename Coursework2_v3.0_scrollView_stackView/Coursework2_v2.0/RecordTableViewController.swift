//
//  RecordTableViewController.swift
//  Coursework2_v2.0
//
//  Created by O Malley S (FCES) on 22/03/2022.
//

import UIKit



class RecordTableViewController: UITableViewController, UISearchBarDelegate {
    
    var recordsArray:[NewRecord] = []       // original unfiltered array of saved records
    var filteredRecords:[NewRecord] = []    // structure to save filtered records
    var dateToday = Date()
    let dateFormatter = DateFormatter()
    

    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertController = UIAlertController(title: "Welcome to EXPENSIFY", message: "App Loading...", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
      
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMdYYYY")
       
        //if let savedRecords = loadRecords()
        let savedRecords = loadRecords()
        if savedRecords!.count != 0
        {
            recordsArray = savedRecords!
        } else {
            // load default record if necessary
            // "1999-01-01 00:00:00"
            // dateFormatter.string(from: "1999-01-01 00:00:00")
            if let initRecord = NewRecord.init(expenseType: 0, expenseTypeString: "Default", dateAdded: dateToday, dateAddedString: dateFormatter.string(from: dateToday), dateIncurred: dateToday, datePaid: dateToday, receiptPhoto: nil, expenseDetails: "Default Expense", totalAmount: "100", isPaid: false, inclVAT: true, receiptSwitch: false){
                recordsArray.append(initRecord)
            }
         }
        
        recordsArray.sort(by: {$0.dateIncurred < $1.dateIncurred})
        filteredRecords.sort(by: {$0.dateIncurred < $1.dateIncurred})
        tableView.reloadData()

        // create an exact copy of all saved records
        filteredRecords = recordsArray
        
        //Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredRecords.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = filteredRecords[indexPath.row].expenseTypeString
        cell.detailTextLabel?.text = filteredRecords[indexPath.row].dateAddedString
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            // simultaneously delete the record from the array and delete the selected row from the tableView
            let record = filteredRecords[indexPath.row]
            filteredRecords.remove(at: indexPath.row)
            
            for index in indexPath.row ..< recordsArray.count {
                if (recordsArray[index].expenseTypeString == record.expenseTypeString && recordsArray[index].dateAddedString == record.dateAddedString){
                    recordsArray.remove(at: index)
                    break;
                }
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveRecords()

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Implement swipt right
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let paidAction = UIContextualAction(style: .normal, title: "Paid") {[weak self] (action, view, completionHandler) in
            self?.markAsPaidSwipeRight(indexPath: indexPath)
            completionHandler(true)
        }
        paidAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [paidAction])
    }
    
    private func markAsPaidSwipeRight(indexPath: IndexPath){
        let record = filteredRecords[indexPath.row]
        record.isPaid = true
        saveRecords()
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch(segue.identifier ?? ""){
            case "viewRecord":
                guard let recordViewController = segue.destination as? ViewController else{
                    break;
                }
                guard let indexPath = tableView.indexPathForSelectedRow else{
                    break;
                }
                let selectedRecord = filteredRecords[indexPath.row]
                recordViewController.record = selectedRecord
                break
            default:
                break;
        }
    }
    
    
    @IBAction func unwindToRecords(sender:UIStoryboardSegue){
        if let sourceViewController = sender.source as? ViewController, let record = sourceViewController.record{
            // Check if source was editing or adding
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let originalRecord = filteredRecords[selectedIndexPath.row]
                filteredRecords[selectedIndexPath.row] = record
                for index in selectedIndexPath.row ..< recordsArray.count{
                    if(recordsArray[index].expenseTypeString == originalRecord.expenseTypeString && recordsArray[index].dateAddedString == originalRecord.dateAddedString){
                        recordsArray[index] = record
                    }
                }
                
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                filteredRecords.append(record)
                recordsArray.append(record)

                let newIndexPath = IndexPath(row:filteredRecords.count-1, section:0)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                filteredRecords.sort(by: {$0.dateIncurred < $1.dateIncurred})
                recordsArray.sort(by: {$0.dateIncurred < $1.dateIncurred})
                tableView.reloadData()
            }
        }
        saveRecords()
    }
    
    var scopeChanged: Bool = false
    
    
    //MARK: - Search Bar methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if scopeChanged == true{
            searchBar.isHidden = true
        } else {
            if (searchText.isEmpty){
                filteredRecords = recordsArray
            } else{
                // first check if searchText is contained in the expenseTypeString value (LHS of table cell)
                filteredRecords = recordsArray.filter({record -> Bool in return record.expenseTypeString.lowercased().contains(searchText.lowercased())})
                // if searchText is not found, filteredRecords is empty, so next search dateAdded for searchText
                if filteredRecords.isEmpty{
                    filteredRecords = recordsArray.filter({record -> Bool in return record.dateAddedString.lowercased().contains(searchText.lowercased())})
                }
            }
            
        }
        tableView.reloadData()
    }
    //MARK: - Array Function FIX THIS?
    /*func scopeChange() -> [NewRecord] {
        if scopeChanged == 0{
            //scopeChanged = 0
            return recordsArray
        }
        if scopeChanged == 1{
            //scopeChanged = 1
            return recordsArray.filter({record -> Bool in return record.isPaid == true})
        }
        if scopeChanged == 2{
            //scopeChanged = 2
            return recordsArray.filter({record -> Bool in return record.isPaid == false})
        }
    }*/
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //let selectedScopeButtonText = searchBar.scopeButtonTitles![selectedScope]
        
        if selectedScope == 0{
            scopeChanged = false
            filteredRecords = recordsArray
        }
        if selectedScope == 1{
            scopeChanged = true
            filteredRecords = recordsArray.filter({record -> Bool in return record.isPaid == true})
        }
        if selectedScope == 2{
            scopeChanged = true
            filteredRecords = recordsArray.filter({record -> Bool in return record.isPaid == false})
        }
        tableView.reloadData()
    }
  
    //MARK: Private Methods
    
    private func saveRecords(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(recordsArray, toFile: NewRecord.ArchiveURL.path)
        if(!isSuccessfulSave){
            print("Save Failed")
        }
    }
    
    private func loadRecords() -> [NewRecord]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: NewRecord.ArchiveURL.path) as? [NewRecord]
    }
    
}
