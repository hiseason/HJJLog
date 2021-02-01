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
//
//        var quickArr = constArr
//        quickSort(&quickArr, left: 0, right: quickArr.count-1)
//        print("快排后: \(quickArr)")
//
//        if let mergeArr = mergeSort(constArr) {
//            print("归并后: \(mergeArr)")
//        }
    }
    
}

//MARK: 冒泡
extension Sort {
    
    func bubbleSort<T:Comparable>(_ arr: inout [T]) {
        for _ in 0..<arr.count {
            for j in 1..<arr.count {
                if arr[j] < arr[j-1] {
                    arr.swapAt(j, j-1)
                }
            }
        }
    }
    
    func bubbleSortOptimize<T:Comparable>(_ arr: inout [T]) {
        for i in 0..<arr.count {
            for j in 1..<arr.count - i {
                if arr[j] < arr[j-1] {
                    arr.swapAt(j, j-1)
                }
            }

        }
    }
    
}

extension Sort {
    func findMaxList() {
        var arr = [1,2,5,6,2,6,3,9,6,7,8]
        var arrGroup = [[Int]]()
        var groupIndex = 0
        for i in 1..<arr.count-1 {
            if arr[i-1] < arr[i] {
                arrGroup[groupIndex].append(arr[i-1])
            }else {
                arrGroup[groupIndex].append(arr[i-1])
                groupIndex += 1
            }
        }

        var maxIndex = 0
        for i in 0..<arrGroup.count {
            for j in 0..<arrGroup.count {
               var leftCount = arrGroup[j].count
               var rightCount = arrGroup[j+1].count
               if leftCount < rightCount {
                   maxIndex = j+1
               }else {
                   maxIndex = j
               }
            }
        }

        var maxArr = arrGroup[maxIndex]
    }
}


/*
//MARK: 归并
extension Sort {
    
    func mergeSort<T: Comparable>(_ arr: [T]) -> [T]? {
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
    
    
    func mergeArr<T: Comparable>(leftArr: [T],rightArr: [T]) -> [T] {
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
        
        while i < leftArr.count {
            mergeArr.append(leftArr[i])
            i += 1
        }
        
        while j < rightArr.count {
            mergeArr.append(rightArr[j])
            j += 1
        }
        
        return mergeArr
    }
    
}


//MARK: 快排
extension Sort {
    
    func quickSort<T: Comparable>(_ arr: inout [T], left: Int, right: Int) {
        if left < right {
            let p = partition(&arr, left: left, right: right)
            quickSort(&arr, left: 0, right: p-1)
            quickSort(&arr, left: p+1, right: right)
        }
    }
    
    func partition<T: Comparable>(_ arr: inout [T], left: Int, right: Int) -> Int {
        let pivot = arr[left]
        var i = left
        var j = right
        
        while i != j {
            while i < j && arr[j] >= pivot {
                j -= 1
            }
            
            while i < j && arr[i] <= pivot {
                i += 1
            }
            
            if (i < j) {
                arr.swapAt(i, j)
            }
        }
        
        //相遇位置交换到起始位
        arr[left] = arr[i]
        //基准数归位
        arr[i] = pivot
        
        return i
    }
    
}


//MARK: 冒泡
extension Sort {
    
    //普通冒泡
    func bubbleSort<T: Comparable>(_ arr: inout [T]) {
        for _ in 0..<arr.count {
            for j in 1..<arr.count {
                if arr[j] < arr[j-1] {
                    arr.swapAt(j, j-1)
                }
            }
        }
    }
    
    
    //冒泡优化
    func bubbleSortOptimize<T: Comparable>(_ arr: inout [T]) {
        for i in 0..<arr.count {
            for j in 1..<arr.count-i {
                if arr[j] < arr[j-1] {
                    arr.swapAt(j, j-1)
                }
            }
        }
    }
    
}

 */
