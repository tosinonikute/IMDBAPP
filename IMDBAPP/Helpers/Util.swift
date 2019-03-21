//
//  Util.swift
//  IMDBAPP
//
//  Created by MACBOOK PRO on 21/03/2019.
//  Copyright © 2019 MACBOOK PRO. All rights reserved.
//

import Foundation

class Util {
    
    static func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from:dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
}
