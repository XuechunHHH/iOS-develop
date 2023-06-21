//
//  ListViewController.swift
//  TravelBook
//
//  Created by mac on 6/11/23.
//

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    var titleArr = [String]()
    var idArr = [UUID]()
    var selectedTitle = ""
    var selectedId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButton))
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPlace"), object: nil)
    }
                                                                                          
        @objc func addButton(){
            performSegue(withIdentifier: "toViewController", sender: nil)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = titleArr[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    @objc func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                self.titleArr.removeAll(keepingCapacity: false)
                self.idArr.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title") as? String{
                        self.titleArr.append(title)
                    }
                    if let id = result.value(forKey: "id") as? UUID{
                        self.idArr.append(id)
                    }
                    tableView.reloadData()
                }
            }
        } catch {
            print("error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewController" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.selectedTitle = selectedTitle
            destinationVC.selectedId = selectedId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTitle = titleArr[indexPath.row]
        selectedId = idArr[indexPath.row]
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = idArr[indexPath.row].uuidString
            request.predicate = NSPredicate(format: "id = %@", idString)
            request.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let id = result.value(forKey: "id") as? UUID {
                            if id == idArr[indexPath.row] {
                                context.delete(result)
                                titleArr.remove(at: indexPath.row)
                                idArr.remove(at: indexPath.row)
                                tableView.reloadData()
                                do {
                                    try context.save()
                                } catch {
                                    print("error")
                                }
                                break;
                            }
                        }
                    }
                }
            } catch {
                print("error")
            }
        }
    }
}
