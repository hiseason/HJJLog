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
        print("最大值:\(co.maxSubArrayDynamic(&arr))")
    }
}

//MARK: 最大子序和
extension ArrayAr {
    /*
     贪心算法
     时间复杂度  O(n) 空间复杂度 O(2)
     */
    func maxSubArray(_ nums: inout [Int]) -> Int {
        guard nums.count > 0 else { return 0 }
        var result = nums[0]
        var sum : Int = 0
        //动态规划的是首先对数组进行遍历，当前最大连续子序列和为 sum，结果为 ans
        //如果 sum > 0，则说明 sum 对结果有增益效果，则 sum 保留并加上当前遍历数字
        //如果 sum <= 0，则说明 sum 对结果无增益效果，需要舍弃，则 sum 直接更新为当前遍历数字
        //每次比较 sum 和 ans的大小，将最大值置为ans，遍历结束返回结果
        //时间复杂度：O(n)
        //链接：https://leetcode-cn.com/problems/maximum-subarray/solution/hua-jie-suan-fa-53-zui-da-zi-xu-he-by-guanpengchn/
        //1,2,5,-7,8,-10
        //1 sum = 1 result = max(1,1) 1
        //2 sum = 3 result == max(1,3) 3
        //5 sum = 9 result == max(3,9) 9
        //-7 sum = 2 result == max(9,2) 9
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
        return result
    }
    
    //动态规划法
    func maxSubArrayDynamic(_ nums: inout [Int]) -> Int {
        guard nums.count > 0 else { return 0 }
        for i in 1..<nums.count {
            if nums[i-1] > 0 {
                nums[i] += nums[i-1]
            }
        }
        return nums.max() ?? 0
    }
}
