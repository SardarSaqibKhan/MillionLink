//
//  Appointments.swift
//  KLKutzAdmin
//
//  Created by Sardar Saqib on 11/09/2019.
//  Copyright © 2019 Sardar Saqib. All rights reserved.
//

import Foundation

class Products {
  
     var name = String()
     var spects = [String]()
     var countryName = String()
   
   
    init() {
        
        self.name = ""
        self.spects = []
        self.countryName = ""
    }
    init(name:String,spects:[String],country:String) {
     
       self.name = name
       self.spects = spects
       self.countryName = country
        
        
    }
    
    init(json: [String:Any],key:String) {
        
      name = key
      spects = json["spect"] as?  [String] ?? []
       
       
    }
    
}


extension Products {
    
    func jsonData() -> [AnyHashable:Any] {
        return [
            
                 name: spects,
                
        ]
    }
}
