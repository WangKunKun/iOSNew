import UIKit




//动态规划：1. 定义数组元素的含义 2. 找出树组间元素的关系式 3. 找出初始条件
/*
 青蛙跳台阶
 1. 定义数组元素的含义
    跳上n级台阶共有f[n]种方法
 2. 找出数组间的元素关系公式  重点！
    由于第n级台阶，可以从n-1或者n-2的台阶处跳上来，则f(n) = f(n-1) + f(n-2)
 3. 找出初始条件
    如果只有一级台阶则只有一种跳法：f(1) = 1
    如果只有两级台阶则有两种跳法：先跳一级再跳一级或一次跳两级 f(2) = 2
*/
func claimStaries(_ n:Int) -> Int {
    //利用备忘录优化可以
    if n <= 2 {return n}
    return claimStaries(n-1) + claimStaries(n-2)
}
//改为迭代
func claimStaries2(_ n:Int) -> Int {
    var first = 1; //f(1)
    var second = 2; //f(2)
    var sum = 0
    for _ in 3...n {
        sum = first + second
        first = second
        second = sum
    }
    return sum
}


//print(claimStaries(7))
//print(claimStaries2(7))

/*
 一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为“Start” ）。

 机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为“Finish”）。

 问总共有多少条不同的路径？
 
 1. 定义数组元素的含义
    定义Finish为(i，j)，则走到此处有dp[i][j]种走法
 2.找出数组间的元素关系公式  重点！  最后一步到达方式有几种
    走到最后的(i,j)，有两种走法，从上面走过来和从左面走过来的得出：
    dp[i][j] = dp[i-1][j] + dp[i][j-1]
 3.找出初始条件
    当只有一行时，机器人只能往右走，就一种走法，则dp[0][0...n] = 1
    当只有一列时，机器人只能往下走，就一种走法，则dp[0...n][0] = 1
 
 
 */

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

func gotoFinish(i:Int, j:Int) -> Int {
    //利用备忘录优化可以
    if i == 1 || j == 1 {return 1}
    return gotoFinish(i: i-1, j: j) + gotoFinish(i: i, j: j-1)
}


func gotoFinish2(m:Int, n:Int) -> Int {
    
    if m == 0 || n == 0 {
        return 0
    }
    
    //生成数组的个数少了 0,0到2,2是 3x3的数组
    var newi = m
    var newj = n
    var dp = Array2D(rows: newi, cols: newj, value: 0)
    for k in 0..<newj {
        dp[0,k] = 1
    }
    for k in 0..<newi {
        dp[k,0] = 1
    }
    
    for i in 1..<newi {
        for j in 1..<newj {
            dp[i,j] = dp[i-1,j] + dp[i,j-1]
        }
    }
    return dp[m-1,n-1]
}


//print(gotoFinish(i:3,j:7))
//print(gotoFinish2(m:3,n:7))

/**
 给定一个包含非负整数的 m x n 网格，请找出一条从左上角到右下角的路径，使得路径上的数字总和为最小。
 **说明：**每次只能向下或者向右移动一步。
 举例：
 输入:
 arr = [
   [1,3,1],
   [1,5,1],
   [4,2,1]
 ]
 输出: 7
 解释: 因为路径 1→3→1→1→1 的总和最小。
 
 1. 定义数组元素的含义
    定义终点为(i，j)，定义dp[i][j]为从左上角走到终点的最短路径和
 2.找出数组间的元素关系公式  重点！  最后一步到达方式有几种
    走到最后的(i,j)，有两种走法，从上面走过来和从左面走过来的得出：
    dp[i][j] = min(dp[i-1][j],dp[i][j-1])  + arr[i][j]
 3.找出初始条件
    这里初始条件是 每个位都是值，计算最小值
        只有一行的情况下，只能往右走  dp[0][j] = dp[0][j-1] + arr[0][j]
        只有一列的情况下，只能往右走  dp[i][0] = dp[i-1][0] + arr[i][0]
 **/

func ShortestPath(_ list:[[Int]]) -> Int {
    let col = list.count
    if col <= 0 {
        return 0
    }
    let row = list.first!.count
    if row <= 0 {
        return 0
    }
    var dp = Array2D(rows: row, cols: col, value: 0)
    dp[0,0] = list[0][0]
    
    
    for i in 1..<row {
        dp[i,0] = dp[i-1,0] + list[i][0]
    }
    
    for j in 1..<col {
        dp[0,j] = dp[0,j-1] + list[0][j]
    }
    
    for i in 1..<list.count {
        for j in 1..<list[i].count {
            dp[i,j] = min(dp[i-1,j], dp[i,j-1]) + list[i][j]
        }
    }
    return dp[row-1,col-1]
}

//var arr = [
//  [1,3,1],
//  [1,5,2],
//  [4,2,1]
//]

//print(ShortestPath(arr))

/**
 给定两个单词 word1 和 word2，计算出将 word1 转换成 word2 所使用的最少操作数 。
 你可以对一个单词进行如下三种操作：
 插入一个字符
 删除一个字符
 替换一个字符
 
 1. 定义数组元素的含义
    word1 转换为 word2，使用它们的长度来定义数据，将长度为 i 的word1转换为长度为 j 的word2
    dp[i][j]  使用上一题的路径思想
 2.找出数组间的元素关系公式  重点！  最后一步到达方式有几种
    由于有三个操作定义，有i和j两个维度，则可以对操作进行定义: 【可以替换吗】
    1. 把字符 word1[i] 替换成与 word2[j] 相等的字符， 则 dp[i][j] = dp[i-1][j-1] + 1
    2. 在字符串 word1末尾插入一个与 word2[j] 相等的字符，则有 dp[i] [j] = dp[i] [j-1] + 1;
    3. 把字符 word1[i] 删除，则有 dp[i] [j] = dp[i-1] [j] + 1;
    则dp[i][j] = min(dp[i-1][j-1],dp[i] [j-1],dp[i-1] [j]) + 1
 3.找出初始条件
    当word1为0，word2也为0时，则不执行操作：dp[0][0] = 0
    当word1为0，word2为j时，则执行插入操作 dp[0][1..<j] = dp[0][j-1] + 1
    当word1为i，word2为0时，则执行删除操作 dp[1..<i][0] = dp[i-1][0] + 1
 **/

func W1ToW2(word1:String,word2:String) -> Int {
    if word1 == word2 {
        return 0
    }
    let w1Count = word1.count + 1
    let w2Count = word2.count + 1
    var dp = Array2D(rows: w1Count, cols: w2Count, value: 0)
    dp[0,0] = 0
    for i in 1..<w1Count {
        dp[i,0] = dp[i-1,0] + 1
    }
    for j in 1..<w2Count {
        dp[0,j] = dp[0,j-1] + 1
    }
    for i in 1..<w1Count {
        for j in 1..<w2Count {
            if charAt(i-1, with: word1) == charAt(j-1, with: word2) {
                dp[i,j] = dp[i-1,j-1]
            } else {
                dp[i,j] = min(dp[i-1,j-1],dp[i,j-1],dp[i-1,j]) + 1
            }
        }
    }
    
    func charAt(_ index:Int, with str:String) -> Character {
        return str[str.index(str.startIndex, offsetBy: index)]
    }
    
    return dp[w1Count - 1,w2Count - 1]
}

//print(W1ToW2(word1: "horse", word2: "ros"))

/**
最大连续子序列和
 -2，1，-3，4，-1，2，1，-5，4
 
 1. 定义数组元素的含义
    dp[i] 为 以 nums[i] 结尾的最大连续子序列和
 2.找出数组间的元素关系公式  重点！
    dp[i] = max(dp[i] + nums[i],nums[i])
 3.找出初始条件
    dp[0] = nums[0]
 **/

func contiuneSum(_ list:[Int]) -> Int {
    if list.count <= 1 {
        return list.first ?? 0
    }
    var dp = [Int].init(repeating: Int.min, count: list.count)
    dp[0] = list[0]
    var maxSum = dp[0]
    for i in 1..<list.count {
        dp[i] = max((dp[i-1] + list[i]),list[i])
        if dp[i] > maxSum {
            maxSum = dp[i]
        }
    }
    return maxSum
}
print(contiuneSum([-2,1,-3,4,-1,2,1,-5,4]))
class Queue {
    
    
}

////二叉搜索树
//class Node<E:Comparable> {
//    var element:E
//    var left:Node<E>?
//    var right:Node<E>?
//    var parent:Node<E>?
//    
//    init(element: E, left: Node<E>? = nil, right: Node<E>? = nil, parent: Node<E>?) {
//        self.element = element
//        self.left = left
//        self.right = right
//        self.parent = parent
//    }
//}
//
////左小右大
//struct BinarySearchTree<E:Comparable> {
//    
//    
//    var root:Node<E>?
//    
//    private var count = 0
//    func size() -> Int {
//        return count
//    }
//    
//    func isEmpty() -> Bool {
//        return true
//    }
//    
//    func clear() {
//        
//    }
//    
//    mutating func add(element:E) {
//
//        guard let root = root else {
//            self.root = Node(element: element, parent: nil)
//            count += 1
//            return
//        }
//        var parent = root
//        while true {
//            if parent.element > element { //left
//                guard let left = parent.left else {
//                    parent.left = Node(element: element, parent: parent)
//                    break
//                }
//                parent = left
//            } else if parent.element < element { //right
//                guard let right = parent.right else {
//                    parent.right = Node(element: element, parent: parent)
//                    break
//                }
//                parent = right
//            } else {
//                return
//            }
//        }
//        count += 1
//    }
//    
//    mutating func remove(element:E) {
//        guard let root = root else {
//            return
//        }
//        
//        var node = root
//        while true {
//            if node.element == element {
//                //删除它
//            } else if node.element > element { //left
//                
//            } else if node.element < element { //right
//                
//            }
//        }
//    }
//    
//    func contains(element:E) -> Bool {
//        return false
//    }
//}
//
//extension BinarySearchTree {
//    
//}
