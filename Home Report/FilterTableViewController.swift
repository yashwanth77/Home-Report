//
//  FilterTableViewController.swift
//  Home Report
//
//  Created by Roger on 4/6/17.
//  Copyright © 2017 PFI. All rights reserved.
//

import UIKit

protocol FilterTableviewControllerDelegate {
    func updateHomeList(filterBy : NSPredicate?,sortBy : NSSortDescriptor?);
}

class FilterTableViewController: UITableViewController {
        
    @IBOutlet weak var filterBySingleFamilyCell: UITableViewCell!
    @IBOutlet weak var filterByTownHomeCell: UITableViewCell!
    @IBOutlet weak var sortByPriceLowtoHigh: UITableViewCell!
    @IBOutlet weak var sortByLocationCell: UITableViewCell!
    @IBOutlet weak var sortByHighToLow: UITableViewCell!
    var delegate : FilterTableviewControllerDelegate!
    
    var sortDescriptor : NSSortDescriptor?
    var searchPredicate : NSPredicate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func setSortDescriptor(sortBy : String, isAscending : Bool){
        sortDescriptor = NSSortDescriptor(key: sortBy, ascending: isAscending)
        
    }
    
    func setFilterSearchPredicate(filterBy : String){
        searchPredicate = NSPredicate(format: "category.homeType = %@", filterBy);
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        switch selectedCell {
        case sortByLocationCell?:
            setSortDescriptor(sortBy: "location.city", isAscending: true);
            break
        case sortByPriceLowtoHigh?:
            setSortDescriptor(sortBy: "price", isAscending: true)
            break
        case sortByHighToLow?:
            setSortDescriptor(sortBy: "price", isAscending: false)
            break
        case filterByTownHomeCell?:
            setFilterSearchPredicate(filterBy: "Townhome")
            break
        case filterBySingleFamilyCell?:
            setFilterSearchPredicate(filterBy: "Single Family");
            break
        default:
            print("No cell is selcted");
        }
        
        selectedCell?.accessoryType = .checkmark;
        delegate.updateHomeList(filterBy: searchPredicate, sortBy: sortDescriptor)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return 3;
        }
        else if section == 1{
            return 2;
        }
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
