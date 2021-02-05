//
//  Reserve.swift
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/29.
//

import Foundation

class Reserve: NSObject {
    @objc func execute() {
        var str = "Hello, World"
        str = reverseString(&str)
        print("str: \(str)")
    }
}

//MARK: 字符串反转
extension Reserve {
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

extension Reserve {
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
