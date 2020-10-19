//
//  WS.swift
//  TestSwift
//
//  Created by Blaz Oblak on 9/20/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

import Foundation


let URL_TEST: String = "http://app-stag.csod.si/api/starting_points"

class WS {
    
    var burek: String
    var delegate: WSDelegate?
    
    init() {
        burek = "njam"
    }
    
    
    
    func getDataFromServer() {
        
        print("dobivam podatke")
        print("Podatki so prenešeni is strežnika :)")
        
        //let url: URL = URL(fileURLWithPath: URL_TEST)
        let url: URL = URL(string: URL_TEST)!
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            print(response ?? "ni odgovora")
            
            
            if let data = data, let dataString = String(data:data, encoding: .utf8){
                print(dataString)
                
                
                
            }else{
                print("jeba")
            }
            
        }
        
        task.resume()
        
        delegate?.getDataFinished(status: 200, response: "{great: success :)}")
        
    }
    
}




