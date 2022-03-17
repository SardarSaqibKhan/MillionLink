//
//  ProductListVC.swift
//  MillionLink
//
//  Created by Sardar Saqib on 06/11/2019.
//  Copyright © 2019 Sardar Saqib. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class ProductListVC: UIViewController {

    
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var filterPopupView: UIView!
    @IBOutlet weak var countriesTableview: UITableView!
    @IBOutlet weak var productSearchBar: UISearchBar!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var blureView: UIView!
    @IBOutlet weak var alpabatsTableView: UITableView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var filterPopupViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var filterPopupBottomConstraint: NSLayoutConstraint!
    
    
    var countries1 = [Country]()
    //var productList = [Products]()
    //var sections = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var sections = [Character]()
    
   

     var ref: DatabaseReference!
     var productList = [Character: [String]]()
    
     var height: CGFloat = 250
     var screenSize = CGSize()
     var isClickFilter = false
    
     var sectionKeys = [Character]()
     var groupedProduct = [[Products]]()
     var selectedProduct = Products()
     var filterdProducts = [[Products]]()
     var searchFlag = false
    
     var flatProductList = [Products]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
         ref = Database.database().reference()
         getProducts()
        
         screenSize = UIScreen.main.bounds.size
         height = CGFloat(outerView.frame.height) * 0.6
         settingTapGesturesOnView()
         self.blureView.alpha = 0
        
        
     
    }
    override func viewWillDisappear(_ animated: Bool) {
        
         //self.filterPopupView.frame = CGRect(x: 0, y: screenSize.height + self.height, width: screenSize.width, height: 0)
        //filterPopupViewHeightConstraints.constant = 0
    }
    
    @IBAction func fileter(_ sender: Any) {
        
        if !(isClickFilter){
            
           
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                //self.filterPopupView.frame = CGRect(x: 0, y: self.outerView.frame.height - self.height, width: screenSize.width, height: self.height)
                
                DispatchQueue.main.async {
                    
                    self.blureView.alpha = 0.1
                    self.filterPopupBottomConstraint.constant = 0
                    self.filterPopupViewHeightConstraints.constant = self.height
                    self.countriesTableview.reloadData()
                }
            }, completion: nil)
            isClickFilter = !isClickFilter
        }
        else{
          
            
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                //self.filterPopupView.frame = CGRect(x: 0, y: screenSize.height + self.height, width: screenSize.width, height: 0)
                //self.filterPopupViewHeightConstraints.constant = 0
                
                DispatchQueue.main.async {
                
                    self.blureView.alpha = 0
                    self.filterPopupBottomConstraint.constant = -self.height
                }

            }, completion: nil)
            isClickFilter = !isClickFilter
        }
        
        
       
        
    }
    
    @IBAction func aboutUs(_ sender: Any) {
        
        performSegue(withIdentifier: "AboutUSVC", sender: nil)
    }
    
    @IBAction func tappedOnView(_ sender: UITapGestureRecognizer) {
        
        print("tapped tapped")
    }
    
}
///////////////////////// TABLEVIEW DATASOURCE AND DELEGATES //////////////////////////
extension ProductListVC:UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if tableView.tag == 2{
            
            view.tintColor = UIColor.clear
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = UIColor.clear
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView.tag == 1{
            
             //return productList.count
            
             //return sections.count
            return sectionKeys.count
        }
        else if tableView.tag == 2{
            return 1
        }
        else{
            return 1
        }
       
    }
    
  
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        if tableView.tag == 1{
           
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
            
            headerView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.7725490196, blue: 0.4392156863, alpha: 1)
            headerView.tintColor = .red
            let titleLabel = UILabel(frame: CGRect(x: 12, y: 0, width: 100, height: headerView.frame.height))
            titleLabel.textColor = #colorLiteral(red: 0.9607843137, green: 0.337254902, blue: 0.3137254902, alpha: 1)
            //\(Array(productList.keys)[section])
            //titleLabel.text = "\(sections[section]) (20)"
            
            /*let key = Array(productList.keys)[section]
            let totalProductAgainstKey = productList[key]?.count
            
            titleLabel.text = "\(Array(productList.keys)[section]) (\(totalProductAgainstKey ?? 0))"*/
            titleLabel.text = "\(sectionKeys[section]) (\(groupedProduct[section].count))"
            
            headerView.addSubview(titleLabel)
            
            
            
            return headerView
        }
            
        else{
            
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1{
           
            
            
            /*let key = Array(productList.keys)[section]
            return productList[key]!.count*/
            
            //let key = sectionKeys[section]
            return self.groupedProduct[section].count
          
        }
        else if tableView.tag == 2{
            
            return sections.count
        }
        else{
            
         
            return countries1.count + 1

           // return countries.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        if tableView.tag == 1{
          
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell", for: indexPath)
            
            
            let value = self.groupedProduct[indexPath.section][indexPath.row].name
            /*let key = Array(productList.keys)[indexPath.section]
            cell.textLabel?.text = productList[key]![indexPath.row]*/
            
            cell.textLabel?.text = value
            
        
            
            return cell
        }
        else if tableView.tag == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlphabaticCell", for: indexPath) as! AlphabaticCell
            
            cell.alphabetLbl.text = "\(sections[indexPath.row])"
            return cell
            
        }
        else{
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
            if indexPath.row == 0{
                
                 cell.textLabel!.text = "All"
            }
            else
            {
               cell.textLabel!.text = countries1[indexPath.row - 1].name
            }
           
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        
        if tableView.tag == 1{
         
            self.selectedProduct = self.groupedProduct[indexPath.section][indexPath.row]
            
          
            //let key = Array(productList.values)[indexPath.section]
         
            self.performSegue(withIdentifier: "ProductDetailsVC", sender: nil)
        }
        else if tableView.tag == 2{
            
           //tableView.cellForRow(at: indexPath)?.backgroundColor  = #colorLiteral(red: 0.9843137255, green: 0.7725490196, blue: 0.4392156863, alpha: 1)
            if indexPath.row < self.groupedProduct[indexPath.section].count{
               
                productTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
            }
           
            
           
           //let value = "\(sections[indexPath.row])"
           //self.showAlphabaticOrder(keyvalue: value)
            
        }
        else{
           
            if indexPath.row == 0 {
                
                isClickFilter = !isClickFilter
                groupedDictionary(products: flatProductList) { (tempPro) in
                    
                    self.groupedProduct = tempPro
                    
                    UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                        
                        
                        DispatchQueue.main.async {
                            
                            self.blureView.alpha = 0
                            self.filterPopupBottomConstraint.constant = -self.height
                            self.productTableView.reloadData()
                            self.alpabatsTableView.reloadData()
                        }
                        
                    }, completion: nil)
                    
                }
            }
            else{
              
                isClickFilter = !isClickFilter
                UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                  
                    self.blureView.alpha = 0
                    self.filterPopupBottomConstraint.constant = -self.height
                    self.filterByCountry(country: self.countries1[indexPath.row - 1].name)
                }, completion: nil)
            }
           
        }
        
    }
}
///////////////////////// GETTING THE LIST OF PRODUCTS ///////////////////////////
extension ProductListVC{
    
    func getProducts(){
        
        ref.child("Countries").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let countriesData = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            var products1 = [Products]()
            var temproducts = [Products]()
            
            
            for country in countriesData {
                let products = country.children.allObjects as? [DataSnapshot]
                for product in products!
                {
                    let pro = Products(name: product.key, spects: product.value as! [String], country: country.key)
                        //Products(name: product.key, spects: product.value as! [String])
                   
                    products1.append(pro)
                    temproducts.append(pro)
                    self.flatProductList.append(pro)
                    //self.countries1.append(Country(Products: products1,name: country.key))
                }
             
                self.countries1.append(Country(Products: temproducts,name: country.key))
                temproducts.removeAll()
            }
            //////////////////////////////////////////////////
            
            self.groupedDictionary(products: products1, completionHandler: { (products) in
                
                self.groupedProduct = products
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                    self.alpabatsTableView.reloadData()
                }
            })
            
            /*let groupedDictorery = Dictionary(grouping: products1, by: { (Products) -> Character in
                
                return Products.name.first!
            })
            var groupedProducts = [[Products]]()
            let keys = groupedDictorery.keys.sorted()
            self.sectionKeys = keys
            
            keys.forEach({ (key) in
                
                
                groupedProducts.append(groupedDictorery[key]!)
            })
            self.groupedProduct = groupedProducts
            groupedProducts.forEach({
                $0.forEach({ print($0.name)})
                print("-------------------")
            })*/
        
          
         
            //var sortedNames = temproducts.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
           // print(sortedNames) //Logs ["Alpha", "alpha","beta", "bravo"]
            
           
            
        }) { (error) in
            
            print(error.localizedDescription)
        }
    }
}

////////////////////// SORTING THE ARRAY AND CONVERTING INTO DICTORNORY //////////////////////
extension ProductListVC{
    
    func sortArray(data:[String],completionHandler:@escaping (_ result:[Character: [String]]) -> Void){
       
    }
}
////////////////////////// PREPARE FOR SEGUES //////////////////////////////////
extension ProductListVC{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "ProductDetailsVC"{
         
            let destination = segue.destination as! ProductDetailsVC
            destination.productDetails = self.selectedProduct
        }
    }
}
/////////////////// AFTER FILTERTION OF PRODUCTS ////////////////////
extension ProductListVC{
    func filterByCountry(country:String){
        
       
        
         self.groupedProduct.removeAll()
         self.sectionKeys.removeAll()
        
         var products1 = [Products]()
        
        print(countries1)
        
        for item in countries1{
            
            if item.name == country{
               
               products1 = item.products
            }
        }
        
        groupedDictionary(products: products1) { (proList) in
        
            self.groupedProduct = proList
            DispatchQueue.main.async {
                
                self.productTableView.reloadData()
                self.alpabatsTableView.reloadData()
            }
            
        }
        
        
        
    }
}

//////////////// SEARCH DELEGATE METHOD AND CALLING TO DB ////////////////////////
extension ProductListVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        
        
        let tempFilterProducts = self.flatProductList.filter({
            
            $0.name.lowercased().prefix(searchText.count) == searchText.lowercased()
        })
        
        groupedDictionary(products: tempFilterProducts) { (tempPro) in
            
            self.groupedProduct = tempPro
            DispatchQueue.main.async {
                
                self.productTableView.reloadData()
                self.alpabatsTableView.reloadData()
                
            }
            
        }
        
    }
    func searchRestaurant(searchString:String){
    
    }
}
///////////////////// GROUPING THE DICTONARY /////////////////////
extension ProductListVC{
    
    func groupedDictionary(products:[Products],completionHandler:@escaping (_ groupedProducts:[[Products]]) -> Void){
        
        var tempgroupedProducts = [[Products]]()
        let groupedDictorery = Dictionary(grouping: products, by: { (Products) -> Character in
            
            return Products.name.first!
        })
        
        let keys = groupedDictorery.keys.sorted()
        self.sectionKeys = keys
        self.sections = keys
        
       
        keys.forEach({ (key) in
            
            tempgroupedProducts.append(groupedDictorery[key]!)
        })
        //self.groupedProduct = groupedProducts
        completionHandler(tempgroupedProducts)
       
    }
}

/////////// SETTING GESTUES ON MEMBER TYPE VIEWS  //////////////
extension ProductListVC{
    func settingTapGesturesOnView(){
        let tapOnView = UITapGestureRecognizer(target: self, action: #selector(ProductListVC.handleTap(_:)))
        self.navigationController?.navigationBar.addGestureRecognizer(tapOnView)
        
        let tapOnTopView = UITapGestureRecognizer(target: self, action: #selector(ProductListVC.handleTap(_:)))
        self.topView.addGestureRecognizer(tapOnTopView)
        
    }
    @objc func handleTap(_ sender:UITapGestureRecognizer){
        
        view.endEditing(true)
    }
}

///////////////////// SHOWING SELECTED ALPHABAT PRODUCT LIST //////////////////////
extension ProductListVC{
    
    func showAlphabaticOrder(keyvalue:String){
    
        
        let character = Character(keyvalue)
        
       
        
        var tempgroupedProducts = [[Products]]()
        let groupedDictorery = Dictionary(grouping: self.flatProductList, by: { (Products) -> Character in
            
            return Products.name.first!
        })
        tempgroupedProducts = [groupedDictorery[character]!]
        
        DispatchQueue.main.async {
        
             self.sectionKeys = [character]
             self.groupedProduct = tempgroupedProducts
             self.productTableView.reloadData()
            
        }
        
    }
}
