//
//  TableViewController.swift
//  LetsTravelTogether
//
//  Created by ALFA on 16.11.2022.
//

import UIKit
import CoreData


extension TableViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArray[indexPath.row]
        
        return cell
    }
    
    
    
    
}

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var titleArray = [String]()
    var idArray = [UUID]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
    }
    
    
    func getData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            
            
            if results.count > 0
            {
                self.idArray.removeAll(keepingCapacity: false)
                self.titleArray.removeAll(keepingCapacity:false)
                
                
                for result in results as! [NSManagedObject]{
                    
                    if let title = result.value(forKey: "title") as? String {
                        
                        self.titleArray.append(title)
                        
                        
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        
                        self.idArray.append(id)
                        
                    }
                    tableView.reloadData()
                }
            }
            
            
            
            
            
            
        } catch {
            
            let nserror = error as NSError
            fatalError("Hata geldi \(nserror), \(nserror.userInfo)")
        }
        
       
        
    }
    
    
    @IBAction func addButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toMap", sender: nil)
        
    }
    
  

}
