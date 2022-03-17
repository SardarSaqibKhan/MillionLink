//
//  ProductDetailsVC.swift
//  MillionLink
//
//  Created by Sardar Saqib on 06/11/2019.
//  Copyright © 2019 Sardar Saqib. All rights reserved.
//

import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var productsDetailsTableView: UITableView!
    
     var sections = ["SPECIFICATIONS","COUNTRY OF REGION"]
     var specificationArray = ["abc","ddd","ere","uu","opi"]
     var country = ["USA"]
    
     var productDetails = Products()
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         self.navigationItem.title = productDetails.name
        // Do any additional setup after loading the view.
    }
    

}
///////////////////////// TABLEVIEW DATASOURCE AND DELEGATES //////////////////////////
extension ProductDetailsVC:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
       
            return 2
    
    
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
       
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
            
            headerView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.7294117647, blue: 0.3647058824, alpha: 1)
            headerView.tintColor = .red
            let titleLabel = UILabel(frame: CGRect(x: 12, y: 0, width: 200, height: headerView.frame.height))
            titleLabel.textColor = #colorLiteral(red: 0.9607843137, green: 0.337254902, blue: 0.3137254902, alpha: 1)
            titleLabel.text = "\(sections[section])"
            headerView.addSubview(titleLabel)
            
            
            
            return headerView

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
          
            return self.productDetails.spects.count
        }
        else{
          return country.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.section == 0{
           
            cell.textLabel?.text = self.productDetails.spects[indexPath.row]
        }
        else{
            
             cell.textLabel?.text = self.productDetails.countryName
        }
           
            return cell
      
    }
   
}
