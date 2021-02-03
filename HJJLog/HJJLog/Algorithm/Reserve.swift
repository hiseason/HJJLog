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

       var newHead: ListNode?
       //保存 p 节点
       var p = head
       while p != nil {
          let tmp = p?.next
          p?.next = newHead
          newHead = p
          p = tmp
       }
      return newHead
    }
}
