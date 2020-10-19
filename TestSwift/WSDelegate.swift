//
//  WSDelegate.swift
//  TestSwift
//
//  Created by Blaz Oblak on 9/20/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

import Foundation


protocol WSDelegate {
    
    func getDataFinished(status: Int, response: String)
    
}
