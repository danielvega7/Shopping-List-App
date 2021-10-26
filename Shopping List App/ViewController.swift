//
//  ViewController.swift
//  Shopping List App
//
//  Created by DANIEL VEGA on 10/25/21.
//

import UIKit

public struct ShopItems: Codable {
    var name: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    var shopArray = [ShopItems]()
    

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        shopArray.append(ShopItems(name: "Banana"))
        shopArray.append(ShopItems(name: "Strawberries"))
        
        if let items = UserDefaults.standard.data(forKey: "shoppingList") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ShopItems].self, from: items){
                shopArray = decoded
                print("reading data")
            }
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = shopArray[indexPath.row].name
        
        return cell
    }
    
    @IBAction func addAction(_ sender: UIButton) {
     
        if let inText = textFieldOutlet.text {
            var count = 0
            var check = false
            while(count < shopArray.count){
                if inText == shopArray[count].name {
                    check = true
                }
                count += 1
            }
            
            if check{
                let alert = UIAlertController(title: "Error", message: "Item is already in the shopping cart", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes, will do", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            else{
            shopArray.append(ShopItems(name: inText))
            }
        }
        else{
            let alert = UIAlertController(title: "Error", message: "TextField could not be converted", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes, will do", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
           
        
        
    }
    
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        shopArray.append(ShopItems(name: "banana"))
        
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(shopArray) {
            
            UserDefaults.standard.set(shopArray, forKey: "shoppingList")
            
        }
        
    }
    

}

