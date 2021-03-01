//
//  Compare.swift
//  HJJLog
//
//  Created by 郝旭姗 on 2021/2/3.
//

import Foundation

class ArrayAr : NSObject {
    @objc  class func execute() {
        let co =  ArrayAr()
        var arr = [-2,1,-3,4,-1,2,1,-5,4]
        co.maxSubArray(&arr)
    }
}

//MARK: 最大子序和
extension ArrayAr {
    func maxSubArray(_ nums: inout [Int]) {
        var result = nums[0]
        var sum : Int = 0
        //动态规划的是首先对数组进行遍历，当前最大连续子序列和为 sum，结果为 ans
        //如果 sum > 0，则说明 sum 对结果有增益效果，则 sum 保留并加上当前遍历数字
        //如果 sum <= 0，则说明 sum 对结果无增益效果，需要舍弃，则 sum 直接更新为当前遍历数字
        //每次比较 sum 和 ans的大小，将最大值置为ans，遍历结束返回结果
        //时间复杂度：O(n)
        //链接：https://leetcode-cn.com/problems/maximum-subarray/solution/hua-jie-suan-fa-53-zui-da-zi-xu-he-by-guanpengchn/
        for num in nums {
           if sum > 0{
               sum += num
           }else{
               sum = num
           }
            result = max(result, sum)
            print("ans:\(result) --- sum:\(sum)")
        }
        print(result)
    }
}
