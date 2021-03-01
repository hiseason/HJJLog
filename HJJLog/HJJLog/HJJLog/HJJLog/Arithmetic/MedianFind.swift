//
//  MedianFind.swift
//  HJJLog
//
//  Created by haojiajia on 2021/2/21.
//

import Foundation

//MARK: 无序数组中位数
class MedianFind: NSObject {
    
    @objc class func execute() {
        let medianFind = MedianFind()
        var arr = [4,3,2,1]
        let median = medianFind.findMedian(&arr,count: arr.count)
        print("中位数: \(median)")
    }
          
   func findMedian(_ arr: inout [Int],count: Int) -> Int {
       let i = 0
       let j = count - 1

       let mid = (count - 1)/2
       var p = partSort(&arr,left: i,right: j)
       while (p != mid) {
           if (mid < p) {
              p = partSort(&arr,left: i,right: p-1)
           }else {
              p = partSort(&arr,left: p+1,right: j)
           }
       }
       return arr[mid]
   }

   func partSort(_ arr: inout [Int],left: Int, right: Int) -> Int {
       var i = left
       var j = right

       let pivot = arr[i]
       while(i != j) {
           while (i<j && arr[j]>pivot) {
               j -= 1
           }
           while (i<j && arr[i]<pivot) {
               i += 1
           }
           if (i < j) {
               let temp = arr[i]
               arr[i] = arr[j]
               arr[j] = temp
           }
       }

       arr[i] = arr[left]
       arr[left] = pivot
    
       return i
   }
    
}
