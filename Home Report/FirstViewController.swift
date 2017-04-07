


import UIKit
import CoreData

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var managedObjectContext : NSManagedObjectContext!
    var homes : [Home] = [];
    var isForSale: Bool = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        let selectedValue = sender.titleForSegment(at: sender.selectedSegmentIndex)        
        isForSale = selectedValue == "For Sale" ? true : false
        
        loadData()
    }
    
   
        func loadData() {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Home")
            request.predicate = NSPredicate(format: "status.isForSale = %@", isForSale as CVarArg)
            
            do {
                homes = try managedObjectContext.fetch(request) as! [Home]
                tableview.reloadData();
            }
            catch {
                fatalError("Error in getting list of homes by status")
            }
        }
    

    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count;
    }
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeListTableViewCell
        
        let home = homes[indexPath.row]
        
        cell.cityLbl.text = home.location?.city
        
        let category = home.category
        cell.categoryLbl.text = category?.homeType
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        cell.priceLbl.text = formatter.string(from: NSNumber(value: home.price))
        
        cell.bedLbl.text = String(home.bed)
        cell.bathLbl.text = String(home.bath)
        cell.sqftLbl.text = String(home.sqft)
        
        let image = UIImage(data: home.image! as Data)
        cell.homeImgView.image = image
        cell.homeImgView.layer.borderWidth = 1
        cell.homeImgView.layer.cornerRadius = 4
        
        return cell

     }
    

}

