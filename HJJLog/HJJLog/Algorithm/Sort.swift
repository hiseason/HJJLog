//
//  Algorithm.swift
//  HJJLog
//
//  Created by 郝旭姗 on 2020/12/25.
//

import Foundation


class Sort: NSObject {
        
    @objc func execute() {
        let constArr = [3,8,-1,59,-7,-1,66,5,-26,100,25,1200,-12,83,66]
        print("原数组: \(constArr)")
        
        var bubbleArr = constArr
        bubbleSort(&bubbleArr)
        print("冒泡后: \(bubbleArr)")

        var bubbleOptimizeArr = constArr
        bubbleSortOptimize(&bubbleOptimizeArr)
        print("优化后: \(bubbleOptimizeArr)")

        var quickArr = constArr//[6,1,2,5,9,3,4,7,10,8]
        quickSort(&quickArr, left: 0, right: quickArr.count-1)
        print("快排后: \(quickArr)")

        if let mergeArr = mergeSort(constArr) {
            print("归并后: \(mergeArr)")
        }
    }
    
}



//MARK: 归并
extension Sort {
    func mergeSort<T:Comparable>(_ arr: [T]) -> [T]? {
        var tempArr = [[T]]()
        for item in arr {
            let subArr = [item]
            tempArr.append(subArr)
        }
        
        while tempArr.count != 1 {
            var i = 0
            while i < tempArr.count - 1 {
                tempArr[i] = mergeArr(leftArr: tempArr[i], rightArr: tempArr[i+1])
                tempArr.remove(at: i+1)
                i += 1
            }
        }
        
        return tempArr.first
    }
    
    func mergeArr<T:Comparable>(leftArr: [T], rightArr: [T]) -> [T] {
        var mergeArr = [T]()
        mergeArr.reserveCapacity(leftArr.count + rightArr.count)
        var i = 0
        var j = 0
        while i < leftArr.count && j < rightArr.count {
            if leftArr[i] < rightArr[j] {
                mergeArr.append(leftArr[i])
                i += 1
            }else {
                mergeArr.append(rightArr[j])
                j += 1
            }
        }
        
        //把剩下的按序归位
        //两段 while 只有一个会执行
        while i < leftArr.count {
            mergeArr.append(leftArr[i])
            i += 1
        }
        
        while j < rightArr.count {
            mergeArr.append(rightArr[j])
            j += 1
        }
        
        print("mergeArr: \(mergeArr)")
        return mergeArr
    }
    
}


//MARK: 快排
extension Sort {
    func quickSort<T:Comparable>(_ arr: inout [T], left: Int, right: Int) {
        if left < right {
            let p = partition(&arr, left: left, right: right)
            quickSort(&arr, left: 0, right: p-1)
            quickSort(&arr, left: p+1, right: right)
        }
    }
    
    func partition<T:Comparable>(_ arr: inout [T], left: Int, right: Int) -> Int {
        let pivot = arr[left]
        var i = left
        var j = right
        
        while i != j {
            //循环找到右边比 pivot 小的
            while i < j && arr[j] >= pivot {
                j -= 1
            }
            
            while i < j && arr[i] <= pivot {
                i += 1
            }
            
            //左边找到大数,右边找到小数,两个条件都满足才能走到这
            if (i < j) {
                arr.swapAt(i, j)
            }
        }
        
        //交换 left 和相遇位 i/j(现在 i == j)
        //pivot 相当于 temp
        arr[left] = arr[i]
        arr[i] = pivot
        
        return i
    }
    
}

//MARK: 冒泡
extension Sort {
    func bubbleSort<T:Comparable>(_ arr: inout [T]) {
        for _ in 0..<arr.count {
            for j in 1..<arr.count {
                if arr[j] < arr[j-1] {
                    arr.swapAt(j, j-1)
                    print("\(arr)")
                }
            }
        }
    }
    
    func bubbleSortOptimize<T:Comparable>(_ arr: inout [T]) {
        var change = false
        for i in 0..<arr.count {
            for j in 1..<arr.count-i {
                if arr[j-1] > arr[j] {
                    arr.swapAt(j-1, j)
                    change = true
                }
            }
            if !change {
                break
            }
            print("\(arr)")
        }
    }
    
}


