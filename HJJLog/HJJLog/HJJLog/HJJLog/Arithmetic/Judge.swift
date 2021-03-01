//
//  Judge.swift
//  HJJLog
//
//  Created by haojiajia on 2021/2/2.
//

import Foundation

class Judge: NSObject {
    
    func validIPAddress(_ IP: String) -> String {
        guard !IP.isEmpty else {
            return "Neither"
        }
        
        if IP.contains(":") {
            return validIPV6Address(IP)
        } else if IP.contains(".") {
            return validIPV4Address(IP)
        } else {
            return "Neither"
        }
        
    }
    func validIPV4Address(_ IP: String) -> String {
        let ipv4Chunk = "([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])"
        let regexStr = "^(" + ipv4Chunk + "\\.){3}" + ipv4Chunk + "$"
        let ret = RegularExpression(regex: regexStr, validateString: IP)
        if !ret.isEmpty {
            return "IPv4"
        } else {
            return "Neither"
        }
        
    }
    func validIPV6Address(_ IP: String) -> String {
        let ipv6Chunk = "([0-9a-fA-F]{1,4})"
        let regexStr = "^(" + ipv6Chunk + "\\:){7}" + ipv6Chunk + "$"
        let ret = RegularExpression(regex: regexStr, validateString: IP)
        if !ret.isEmpty {
            return "IPv6"
        } else {
            return "Neither"
        }
    }
    func RegularExpression (regex:String,validateString:String) -> [String]{
        do {
            let regex: NSRegularExpression = try NSRegularExpression(pattern: regex, options: [])
            let matches = regex.matches(in: validateString, options: [], range: NSMakeRange(0, validateString.count))
            
            var data:[String] = Array()
            for item in matches {
                let string = (validateString as NSString).substring(with: item.range)
                data.append(string)
            }
            
            return data
        }
        catch {
            return []
        }
    }

    //作者：karl9102
    //链接：https://leetcode-cn.com/problems/validate-ip-address/solution/swift-zheng-ze-jie-fa-by-karl9102/
    //来源：力扣（LeetCode）
    //著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
}
