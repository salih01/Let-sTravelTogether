//
//  TableViewController.swift
//  LetsTravelTogether
//
//  Created by ALFA on 16.11.2022.
//

import UIKit


extension TableViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "hello"
        
        return cell
    }
    
    
}

class TableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func addButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toMap", sender: nil)
        
    }
    
  

}
