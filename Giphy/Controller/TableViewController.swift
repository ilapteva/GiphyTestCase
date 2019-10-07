//
//  View.swift
//  Giphy
//
//  Created by Ира on 30/09/2019.
//  Copyright © 2019 Irina Lapteva. All rights reserved.
//

import Foundation
import UIKit
import TinyConstraints
import Alamofire
import SwiftyJSON

class TableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     fileprivate var items = [CellItem]()
    
    // URL of random GIF using Giphy API
    let GIF_URL = "https://api.giphy.com/v1/gifs/trending?api_key=5ci16c2iy4REhED98tYKaLQ6MegBELxz&rating=G&limit=35"
    
    let totalEntries = 30
    
    //MARK: - Creating UI Elements
    
    let label = UILabel()
    
    let tableView: UITableView = {
        let gif = UITableView()
        gif.separatorStyle = .none
        gif.allowsSelection = false
        
        return gif
    }()
    
    //MARK: - Updating UI with methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupLabel()
        
        self.tableView.register(GIFViewCell.self, forCellReuseIdentifier: "GIFViewCell")
        startRequest()

    }

    //MARK: - UI ELements setup
    func setupLabel() {
        view.addSubview(label)
        label.text = "GIPHY"
        label.topToSuperview(offset: 20, usingSafeArea: true)
        label.centerXToSuperview()
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.sizeToFit()
        
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.edgesToSuperview(insets: TinyEdgeInsets(top: 70, left: 0, bottom: 0, right: 0),  usingSafeArea: true)
    }
    
    
    //MARK: - Get random GIF URL method using Alamofire and SwiftyJSON
    func startRequest()  {
                
        Alamofire.request(GIF_URL, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print ("Success! Got GIF data!")

                let gifJSON : JSON = JSON(response.result.value!)
            
            
                for gifArrayItem in gifJSON["data"].arrayValue {
                    let gifId = gifArrayItem["id"]
                    let url = "https://media0.giphy.com/media/\(gifId)/giphy.gif"
                    let imageURL = UIImage.gifImageWithURL(url)
                    let item = CellItem(uiImage: imageURL!)
                                       self.items.append(item)
                                       DispatchQueue.main.async {
                                           self.tableView.reloadData()
                                       }
                    debugPrint(url)
                
                }
                
            }
            else {
                print ("Error \(String(describing: response.result.error))")
                let alert = UIAlertController(title: "Sorry!", message: "Can't load GIF", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in print ("pressed")
                      }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    }


//MARK: - UITableView Methods
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
 }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

  let cell = tableView.dequeueReusableCell(withIdentifier: "GIFViewCell") as! GIFViewCell
    let item = items[indexPath.row]
    cell.loadingGif.image = item.uiImage
    
    cell.selectionStyle = .none
   

  return cell
}
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    

}



struct CellItem {
    let uiImage: UIImage
}


