//
//  Reserve.swift
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/29.
//

import Foundation

class Reserve: NSObject {
    
    override init() {
        super.init()
        
        var str = "Hello, World"
        str = reverseString(&str)
        print("str: \(str)")
    }

}


//MARK: 字符串反转
extension Reserve {
    
    func reverseString(_ s : inout String) -> String {
        guard s.count > 1 else {
            return s
        }
        var chars = s.utf8CString
        var low = 0
        var high = chars.count - 2
        while low < high {
            chars.swapAt(low, high)
            low += 1
            high -= 1
        }
        return String(cString: Array(chars))
    }

}
