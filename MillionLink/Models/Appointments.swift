//
//  Appointments.swift
//  KLKutzAdmin
//
//  Created by Sardar Saqib on 11/09/2019.
//  Copyright © 2019 Sardar Saqib. All rights reserved.
//

import Foundation

class Products {
    
    var id: String
    var Date: String
    var StartTime: Int
    var EndTime: Int
    var Plan: String
    var user:User?
    var Status: String
   
    
    init(id: String, date: String, starttime: Int, endtime:Int, plan:String, user:User, status:String) {
       
        self.id = id
        self.Date = date
        self.StartTime = starttime
        self.EndTime = endtime
        self.Plan = plan
        self.user = user
        self.Status = status
        
        
    }
    
    init(json: [String:Any],key:String="") {
        
        id = key
        Date = json["Date"] as? String ?? ""
        StartTime = json["StartTime"] as? Int ?? Int(json["StartTime"] as! String)!
        EndTime = json["EndTime"] as? Int ?? Int(json["EndTime"] as! String)!
        Plan = json["Plan"] as?  String ?? ""
        Status = json["Status"] as? String ?? ""
        
        user = User(json: json["UserID"] as? [String:Any] ?? [:])
    }
    
}


extension Products {
    
    func jsonData() -> [AnyHashable:Any] {
        return [
                 "id" : id,
                 "Date" : Date,
                 "StartTime": StartTime,
                 "EndTime" : EndTime,
                 "Plan": Plan ,
                 "Status":Status,
                 "UserID":user!.JSData()
        ]
    }
}
