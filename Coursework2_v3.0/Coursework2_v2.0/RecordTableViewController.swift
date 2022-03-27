//
//  RecordTableViewController.swift
//  Coursework2_v2.0
//
//  Created by O Malley S (FCES) on 22/03/2022.
//

import UIKit

class RecordTableViewController: UITableViewController {

    
    var recordsArray:[NewRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedRecords = loadRecords(){
            
        } else {
            //load default record if necessary
            // load welcome message?
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

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
        return recordsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = recordsArray[indexPath.row].expenseTypeString   //expenseType
        //cell.detailTextLabel?.text = "£" + recordsArray[indexPath.row].totalAmount
        cell.detailTextLabel?.text = recordsArray[indexPath.row].dateAddedString
        
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
            recordsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveRecords()

        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
                let selectedRecord = recordsArray[indexPath.row]
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
                recordsArray[selectedIndexPath.row] = record
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                recordsArray.append(record)
                let newIndexPath = IndexPath(row:recordsArray.count-1, section:0)
                tableView.insertRows(at: [newIndexPath], with: .automatic)            }
 
        }
        saveRecords()
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
