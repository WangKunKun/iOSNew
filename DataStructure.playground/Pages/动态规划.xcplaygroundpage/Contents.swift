
import Foundation

public struct Array2D {
       let rows: Int
       let cols: Int
       fileprivate var array: [Int]
       
       public init(rows: Int, cols: Int, value: Int) {
           self.rows = rows
           self.cols = cols
           array = .init(repeating: value, count: rows * cols)
       }
       
       // 重写下标
       public subscript(row: Int, col: Int) -> Int {
           get {
               return array[row * cols + col]
           }
           set {
               array[row * cols + col] = newValue
           }
       }
   }

func charAt(_ index:Int, str:String) -> Character {
    return str[str.index(str.startIndex, offsetBy: index)]
}
/**

 动态规划：三部曲
 
 1.定义数组元素的含义
 2.找出关系数组元素间的关系式
 3.找出初始值
 
 */


/*
 编辑距离 letcode 72
 问题描述
 给定两个单词 word1 和 word2，计算出将 word1 转换成 word2 所使用的最少操作数 。
 你可以对一个单词进行如下三种操作：
 插入一个字符
 删除一个字符
 替换一个字符
 
 1. 定义
 
 d[i][j] 长度为 i 的word1 转换成 长度为 j 的word2的最短操作路径
 
 准确的定义是dp[i][j]代表word1 的前 i 位置转换成 word2 的前 j 位置需要最少步数
 2. 找关系
 
 如果 word[i] == word[j] 则 不执行操作，dp[i][j] = d[i-1][j-1]
 如果不相等则：
 对word1进行插入 d[i][j] = d[i][j-1] + 1
 对word1进行删除 d[i][j] = d[i-1][j] + 1
 使用word2的字符替换word1的 d[i][j] = d[i-1][j-1] + 1
 
 d[i][j] = min(d[i][j-1],d[i-1][j],d[i-1][j-1]) + 1
 
 3 初始化值
 
    当word1和word2都为0时，d[0][0] = 0
    当word1为0时，执行插入操作, d[0][j] = d[0][j-1] + 1
    当word2为0时，执行删除操作, d[i][0] = d[i-1][0] + 1
 */
func minDistance(_ word1: String, _ word2: String) -> Int {
    
    if word1 == word2 {
        return 0
    }
    let n1 = word1.count
    let n2 = word2.count
    var w1count = n1 + 1
    var w2count = n2 + 1
    
    var dp = Array2D(rows: w1count, cols: w2count, value: 0)

    for i in 1..<w1count {
        dp[i,0] = dp[i-1,0] + 1
    }
    
    for j in 1..<w2count {
        dp[0,j] = dp[0,j-1] + 1
    }
//    return 0
    for i in 1..<w1count {
        for j in 1..<w2count {
            if charAt(i - 1, str: word1) == charAt(j - 1, str: word2) {
                dp[i,j] = dp[i-1,j-1]
            } else {
                dp[i,j] = min(dp[i-1,j-1], dp[i,j-1], dp[i-1,j]) + 1
            }
        }
    }
    return dp[n1,n2]
}


//最大连续子序列和
func kkkk(_ list:[Int]) -> Int {
    if list.count < 2 {
        return list.first ?? 0
    }
    var dp:[Int] = .init(repeating: Int.min, count: list.count)
    var sum = Int.min
    dp[0] = list[0]
    for i in 1..<list.count {
        
        dp[i] = max((dp[i-1] + list[i]), list[i])
        if dp[i] > sum {
            sum = dp[i]
        }
    }
    return sum
}

print(kkkk([-2,1,-3,4,-1,2,1,-5,4]))
