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
import Gifu
import Alamofire
import SwiftyJSON

class TableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // URL of random GIF using Giphy API
    let GIF_URL = "https://api.giphy.com/v1/gifs/random?api_key=5ci16c2iy4REhED98tYKaLQ6MegBELxz&tag=&rating=G"
    
    var images = [#imageLiteral(resourceName: "Image4"),#imageLiteral(resourceName: "Image3"),#imageLiteral(resourceName: "Image1"),#imageLiteral(resourceName: "Image2")]
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


        
        let gifURL = getGifData(url: GIF_URL)
        let convertedGifURL =  URL(string: gifURL)
        print(convertedGifURL)
//        var loadingGif: GIFImageView = {
//            let view = GIFImageView()
//
//            view.animate(withGIFURL: convertedGifURL)
//
//            return view
//        }()
        
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
    func getGifData(url: String) -> (String) {
        
        var gifURL = ""
        
        Alamofire.request(GIF_URL, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print ("Success! Got GIF data!")

                let gifJSON : JSON = JSON(response.result.value!)

                gifURL = gifJSON["data"]["image_original_url"].stringValue
                
                
            }
            else {
                print ("Error \(String(describing: response.result.error))")
                let alert = UIAlertController(title: "Sorry!", message: "Can't load GIF", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
                      switch action.style{
                      case .default:
                            print("default")

                      case .cancel:
                            print("cancel")

                      case .destructive:
                            print("destructive")


                      @unknown default:
                        fatalError()
                    }}))
                self.present(alert, animated: true, completion: nil)
            }
        }
        return gifURL
    }
    
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//    }

 


//MARK: - TableView Methods

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return images.count
 }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

  let cell = tableView.dequeueReusableCell(withIdentifier: "GIFViewCell") as! GIFViewCell
    
    cell.loadingGif.image = images[indexPath.row]
    cell.selectionStyle = .none
   

  return cell
}
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
}





