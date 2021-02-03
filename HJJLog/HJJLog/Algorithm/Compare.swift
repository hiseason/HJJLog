//
//  Compare.swift
//  HJJLog
//
//  Created by 郝旭姗 on 2021/2/3.
//

import Foundation

class Compare: NSObject {
    @objc  class func execute() {
        let co =  Compare()
        var arr = [-2,1,-3,4,-1,2,1,-5,4]
        co.maxSubArray(&arr)
    }
}

//MARK: 最大子序和
extension Compare {
    func maxSubArray(_ nums: inout [Int]) {
        //边界条件判断，当i等于0的时候，也就是前1个元素，他能构成的最大和也就是他自己，所以
        var ans = nums[0]
        var sum : Int = 0
        //如果 num 小于0，我们直接把前面的舍弃，也就是说重新开始计算，否则会越加越小的，直接让dp[i]=num[i]
        for num in nums {
           if sum > 0{
               sum += num
           }else{
               sum = num
           }
           ans = max(ans, sum)
            print("ans:\(ans) --- sum:\(sum)")
        }
        print(ans)
    }
}
