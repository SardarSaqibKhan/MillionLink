//
//  Country.swift
//  MillionLink
//
//  Created by Sardar Saqib on 07/11/2019.
//  Copyright © 2019 Sardar Saqib. All rights reserved.
//

import Foundation
class Country {
    
    var name = ""
    var products = [Products]()
    
    
    init() {
        
        self.name = ""
        self.products = []
    }
    init(Products:[Products],name:String){
        self.name = name
        self.products = Products
    }
    //
}

