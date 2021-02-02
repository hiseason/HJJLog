//
//  Judge.swift
//  HJJLog
//
//  Created by haojiajia on 2021/2/2.
//

import Foundation

class Judge: NSObject {
    
    func isValidIP(ipAddress: String?) -> Bool {
        guard let ipAddress = ipAddress else {
            return false
        }
        
        if ipAddress.count <= 0 {
            return false
        }
        
        let ipArr = ipAddress.components(separatedBy: ".")
        guard ipArr.count == 4 else {
            return false
        }
        
        var isValid = true
        for str in ipArr {
            if let strASCII = Int(str) {
                if strASCII < 0 || strASCII > 255 {
                    isValid = false
                    break
                }
            }
            
        }
        return isValid
    }
}
