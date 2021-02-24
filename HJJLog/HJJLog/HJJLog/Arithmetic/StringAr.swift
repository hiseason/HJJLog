//
//  Reserve.swift
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/29.
//

import Foundation

class StringAr: NSObject {
    @objc class func execute() {
        let strAr = StringAr()
        let result = strAr.multiply("123", "456")
//        let number = strAr.strToAscII(str: "A")
//        var str = "Hello, World"
//        str = reverseString(&str)
//        print("str: \(str)")
    }
}

//MARK: 字符串相乘
extension StringAr {
    func multiply(_ num1: String, _ num2: String) -> String {
        if num1 == "0" || num2 == "0" {
            return "0"
        }
        
        let arr1: [Int] = num1.map { Int(String($0)) ?? 0 }.reversed()
        let arr2: [Int] = num2.map { Int(String($0)) ?? 0 }.reversed()
        print(arr1)
        print(arr2)

        var result = [Int](repeating: 0, count: arr1.count + arr2.count)
        for i in 0..<arr1.count {
            for j in 0..<arr2.count {
                result[i+j] += arr1[i]*arr2[j]
                print("遍历相乘: \(result)")
            }
        }
        //进位值
        var carrys = 0
        //将两两相乘的结果遍历
        for i in 0..<result.count {
            result[i] += carrys
            carrys = result[i]/10
            result[i] %= 10
        }
        if carrys != 0 {
            result[result.count-1] = carrys
        }
        //结果值正序
        result = result.reversed()

        //Int 数组转化为 String
        let resultMap = result.map {String($0)}
        let resultStr = resultMap.joined(separator:"")
        return resultStr
    }

    func strToAscII(str: String) -> Int {
        print("unicodeScalars: \(str.unicodeScalars)")
        var number = 0
        for code in str.unicodeScalars {
            number = Int(code.value)
        }
        print("number: \(number)")
        return number
    }
}
//https://blog.csdn.net/lin1109221208/article/details/91389301


//MARK: 字符串反转
extension StringAr {
    func reverseString(_ str : inout String) -> String {
        guard str.count > 1 else {
            return str
        }
        var characters = str.map { String($0) }
        var i = 0
        var j = characters.count - 1
        while i < j {
            characters.swapAt(i, j)
            i += 1
            j -= 1
        }
        str = characters.joined()
        return str
    }
}

//MARK: 链表反转
//Definition for singly-linked list.
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension StringAr {
    func reverseList(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        
        var p = head
        //newHead 是 "头指针"
        var newHead: ListNode?
        
        while p != nil {
            //记录下一个节点
            let tmp = p?.next
            //当前节点的 next 指向新链表的头部
            p?.next = newHead
            //更改新链表的头部为当前节点
            newHead = p
            //移动 p 指针
            p = tmp
        }
        return newHead
    }
}
