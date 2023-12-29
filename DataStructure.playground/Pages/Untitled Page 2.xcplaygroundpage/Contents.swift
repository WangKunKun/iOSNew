//: [Previous](@previous)

import Foundation
//
//
// MARK: - 6 N字形变换
//以行为主体
func convert1(_ s: String, _ numRows: Int) -> String {
    
    if s.count <= numRows || numRows == 1 {return s}
    
    var str:[Character] = []
    //实际最大间隔 等于 行 * 2 - 2
    var maxSpace = (numRows << 1) - 2
    //每一行的间隔组成 等于 maxspace - 2 * i 和 i
    for i in 0..<numRows {
        if i == 0 || i == numRows - 1 {
            var index = i
            while s.count > index {
                str.append(s[s.index(s.startIndex, offsetBy: index)])
                index += maxSpace
            }
        } else {
            var index = i
            var spaces = [maxSpace - i << 1, i << 1]
            var count = 0
            //字符数
            //字符间隔
            while s.count > index {
                str.append(s[s.index(s.startIndex, offsetBy: index)])
                index += spaces[count & 1]
                count += 1
            }
        }
    }
    return String(str)
}

//以字符为主体
func convert2(_ s: String, _ numRows: Int) -> String {
    
    if s.count <= numRows || numRows == 1 {return s}
    
    var dict:[Int:[Character]] = [:]
    //1-n-1-n
    var index = 0
    var add = -1
    
    for char in s {
        if index == numRows - 1  {
            add = -1
        } else if index == 0 {
            add = 1
        }
        if dict[index] == nil {
            dict[index] = [Character]()
        }
        dict[index]?.append(char)
        index += add
    }
    var chars:[Character] = []
    for i in 0..<numRows {
        if let list = dict[i] {
            chars.append(contentsOf: list)
        }
    }
    return String(chars)
}


//print(convert2("PAYPALISHIRING", 4))

//for i in "asdfas dfas" {
//    print(i)
//}
// MARK: 10 正则匹配 包含.* 并且*之前必然包含有效字符
func isMatch(_ s: String, _ p: String) -> Bool {

    var sArr = Array(s)
    var pArr = Array(p)
    var sLen = s.count
    var pLen = p.count
    var sSaveLen = sLen + 1 //因为00当做空字符串了
    var pSaveLen = pLen + 1 //因为00当做空字符串了
    //这里全定义为了假
    var dp = [[Bool]].init(repeating: .init(repeating: false, count: pSaveLen), count: sSaveLen)
    //第一个是真
    dp[0][0] = true
    for j in 1..<pSaveLen {
        if pArr[j-1] == "*" {
            dp[0][j] = dp[0][j-2] //
        }
    }
    for i in 1..<sSaveLen {
        for j in 1..<pSaveLen {

            if pArr[j-1] == sArr[i-1] || pArr[j-1] == "." {
                dp[i][j] = dp[i-1][j-1]
            } else if pArr[j-1] == "*" {
                if pArr[j-2] == sArr[i-1] || pArr[j-2] == "." {
                    //选择一个匹配上的结果，如果都没有则为false了
                    dp[i][j] = dp[i][j - 2] || dp[i - 1][j - 2] || dp[i - 1][j];
                } else {
                    dp[i][j] = dp[i][j - 2];
                }
            }
        }
    }
    
   return dp[sLen][pLen]
}

//print(isMatch("aaa", "ab*ac*a"))
// MARK: 12 整数转罗马 [1...3999]
func intToRoman(_ num: Int) -> String {
    //首先判断位数
    //根据规则分为三段 1-3 4-8 9    [III 3]  [IIIV 左减 4]  [VIII 右加 8]  [IX 9]
    var list = [1000,900,500,400,100,90,50,40,10,9,5,4,1]
    var strs = ["M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"]
    var str = ""
    var tmp = num
    var index = 0
    while tmp > 0 {
        if tmp >= list[0] {
            tmp = tmp - list[0]
            str.append(strs[0])
        } else {
            if tmp < 4 {
                tmp -= 1
                str.append("I")
                continue
            }
            if tmp <= list[index] && tmp >= list[index+1] {
                tmp -= list[index+1]
                str.append(strs[index+1])
            } else {
                index += 1
            }
        }
    }
   
    return str
    
}

func intToRoman2(_ num: Int) -> String {
    var list = ["I","V","X","L","C","D","M"]
    var tmp = num
    var str:[String] = []
    var count = 0
    var base = 1
    while tmp > 0 {
        var present = tmp % 10
        defer {
            tmp = tmp / 10
            count += 1
            base *= 10
        }
        if present <= 0 {
            continue
        }
        //组装 取数组中 [2*i...2*(i+1)] [2*i...2*i]
        
        var tmpList = count < 3 ? Array(list[count << 1 ... (count+1) << 1]) : [list[list.count - 1]]
        var new:[String] = []
        switch present {
        case 9:
            new.append(tmpList[0])
            new.append(tmpList[2])

            break
        case 4...8:
            var sub = present - 5
            
            for _ in 0..<abs(sub) {
                new.append(tmpList[0])
            }
            if sub > 0 {
                new.insert(tmpList[1], at: 0)
            } else {
                new.append(tmpList[1])
            }
        case 1...3:
            for _ in 0..<present {
                new.append(tmpList[0])
            }
        default: //0什么也不做
            break
        }
        str.insert(new.joined(), at: 0)
    }
    return str.joined()
}

//print(intToRoman(00))
// MARK: 13 罗马数字转 整数 [1-3999]
func romanToInt(_ s: String) -> Int {
    var dict:[Character:Int] = ["M":1000,"D":500,"C":100,"L":50,"X":10,"V":5,"I":1]
//    var sp = ["CM","CD","XC","XL","IX","IV"]
    var list = Array(s)
    var sum = 0
    var i = 0
    while i < list.count {
        if i == list.count - 1 {
            sum += dict[list[i]]!
            break
        }
        switch list[i] {
        case "C":
            if list[i+1] == "D" {
                sum += 400
                i += 2
            } else if list[i+1] == "M" {
                sum += 900
                i += 2
            } else {
                sum += 100
                i += 1
            }
        case "X":
            if list[i+1] == "C" {
                sum += 90
                i += 2
            } else if list[i+1] == "L" {
                sum += 40
                i += 2
            } else {
                sum += 10
                i += 1
            }
        case "I":
            if list[i+1] == "X" {
                sum += 9
                i += 2
            } else if list[i+1] == "V" {
                sum += 4
                i += 2
            } else {
                sum += 1
                i += 1
            }
        default:
            sum += dict[list[i]]!
            i += 1
        }
        
    }
    return sum
}

func romanToInt2(_ s: String) -> Int {

    var dict:[Character:Int] = ["M":1000,"D":500,"C":100,"L":50,"X":10,"V":5,"I":1]
    var sum = 0
    var lastNumber = Int.min
    //逆序遍历  上次累加值大于本次，则对本次值进行累减
    for char in s.reversed() {
        var number = dict[char]!
        sum = number < lastNumber ? sum - number : sum + number
        lastNumber = number
    }
    return sum
}

func romanToInt3(_ s: String) -> Int {

    var dict:[Character:Int] = ["M":1000,"D":500,"C":100,"L":50,"X":10,"V":5,"I":1]
    var sum = 0
    var lastNumber = Int.min
    //顺序遍历 上次累加值小于本次累计值，则减去上次累加值的两倍，并加上本次累加值
    s.forEach { char in
        var number = dict[char]!
        sum = number > lastNumber ? sum - (lastNumber << 1) + number : sum + number
        lastNumber = number
    }
    return sum
}

//print(romanToInt("MCMXCIV"))

// MARK: 14 最长公共前缀

func longestCommonPrefix(_ strs: [String]) -> String {
    if strs.count == 0 { return "" }
    if strs.count == 1 {return strs[0]}
    var listCount = strs.count
    var minLength = Int.max
    var minStr = ""
    for str in strs where str.count < minLength {
        if str.count == 0 {
            return ""
        }
        minLength = str.count
        minStr = str
    }
    var index = 0
    var flag = true
    var result:[Character] = []

    while index < minLength {
        let char = minStr[minStr.index(minStr.startIndex, offsetBy: index)]
        for i in 0..<listCount {
            let tmp = strs[i]
            let newChar = tmp[tmp.index(tmp.startIndex, offsetBy: index)]
            if newChar != char {
                flag = false
                break
            }
        }
        index += 1
        if flag {
            result.append(char)
        } else {
            break
        }
    }
    return String(result)
}

func longestCommonPrefix2(_ strs: [String]) -> String {
    //string数组的排序是 利用字符依次对比，有可能数量多的还在前面。 例如["abcde","aaeeee"] 由于第二个a小于b，则aaeeee位于了前面
    //所以排序后 前面的字符串和第一个字符串的接近程度是高于最后一个字符串的，只用取第一个数据和最后一个数据对比即可 得出最大的公共前缀
    guard strs.count > 1 else {
        return strs.first ?? ""
    }
    var sorted = strs.sorted()
    var first = sorted.first!
    var last = sorted.last!
    var result = ""
    for index in first.indices {
        if first[index] == last[index] {
            result.append(first[index])
        } else {
            return result
        }
    }
    return result
}

func longestCommonPrefix3(_ strs: [String]) -> String {
    //string数组的排序是 利用字符依次对比，有可能数量多的还在前面。 例如["abcde","aaeeee"] 由于第二个a小于b，则aaeeee位于了前面
    //所以排序后 前面的字符串和第一个字符串的接近程度是高于最后一个字符串的，只用取第一个数据和最后一个数据对比即可 得出最大的公共前缀
    guard strs.count > 1 else {
        return strs.first ?? ""
    }
    var sorted = strs.sorted()
    var first = sorted.first!
    var last = sorted.last!
    var result = ""
    //利用zip方式处理
    for (f,l) in zip(first, last) {
        if f == l {
            result.append(f)
        } else {
            return result
        }
    }
    
    return result
}

print(longestCommonPrefix(["flower","flow","flight"]))

//var strs = ["abcde","aaeeee"]
//strs.sort()
//print(strs)

//MARK: 15 取出数组中三数之和等于target的 所有不重复组合 双指针
func threeSum(_ nums: [Int]) -> [[Int]] {
if nums.count < 3 {
    return []
}
let new = nums.sorted{$0<$1}

//从
let count = new.count
var res:[[Int]] = []

for i in 0..<count {
    //排序后如果第一位就大于0了 则后续不需要再判断了
    if (new[i] > 0) {
        return res
    }
    //过滤相同
    if i > 0 && new[i - 1] == new[i]  {
        continue
    }
    
    var left = i + 1
    var right = count - 1
    while left < right {
        
        let sum = new[left] + new[right] + new[i]
        
        if sum == 0 {
            
            let ans = [new[right],new[left],new[i]]
            res.append(ans)
            //过滤相同
            while left < right && new[left] == new[left+1] {
                left += 1
            }
            //过滤相同
            while left < right && new[right] == new[right-1] {
                right -= 1
            }
            //最后因为他们都算过了 但是i 没变，则他们需要都变
            left += 1
            right -= 1
        } else if sum > 0 {
            //和过大，则最大数减小
            right -= 1
        } else {
            //和过小，则次小数增大
            left += 1
        }
    }
    
}

return res
}

//MARK: 16 最接近的三数之和 nums.count >= 3
func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
    
    guard nums.count > 3 else {
        return nums.reduce(0, +)
    }
    
    let new = nums.sorted()

    var res = nums[1]+nums[0]+nums[2]

    for i in 0..<new.count {

//        //过滤相同
        if i > 0 && new[i - 1] == new[i]  {
            continue
        }
        
        var left = i + 1
        var right = new.count - 1
        while left < right {
            let sum = new[left] + new[right] + new[i]
            if abs(res - target) > abs(sum - target) {
                res = sum
            }
            if sum > target {
                right -= 1
            } else if sum < target {
                left += 1
            } else {
                return sum
            }
            
        }
        
    }
    return res
}

//print(threeSumClosest([-1000,-5,-5,-5,-5,-5,-5,-1,-1,-1], -14))
//MARK: 17. 电话号码的字母组合
/*
 *迭代形式
 */
func letterCombinations(_ digits: String) -> [String] {
    if digits.count == 0 {return []}
    var dict:[Character:[String]] = ["2":["a","b","c"],"3":["d","e","f"],"4":["g","h","i"],"5":["j","k","l"],"6":["m","n","o"],"7":["p","q","r","s"],"8":["t","u","v"],"9":["w","x","y","z"]]
    if digits.count == 1 {return dict[digits.first!]!}
    var list:[[String]] = []
    var newStr = digits//.replacingOccurrences(of: "1", with: "")
    for index in newStr.indices {
        list.append(dict[newStr[index]]!)
    }
    var count = list.count
    var strs = list[0] //拿出第一个
    var result = list[0]
    //第一次进去的是0 + 1
    var listIndex = 1
    while listIndex < list.count { //每一次两两组合，组合完成生成新的数组，和下一个组合
        var tmpResult:[String] = []
        for i in result.indices {
            for j in list[listIndex].indices {
                var new = String()
                new.append(result[i])
                new.append(list[listIndex][j])
                tmpResult.append(new)
            }
        }
        result = tmpResult
        listIndex += 1
    }

    return result
}
//递归法
func letterCombinations1(_ digits: String) -> [String] {
    /*
     实际递归 23456
     第一层 2 3456
     第二层 3 456
     第三层 4 56
     第四层 5 6 开始计算并且往上递归
     */
    func combinationTwo(_ one:[String], _ two: inout [[String]]) -> [String] {
        if two.count == 1 {
            //组合返回
            var tmpResult:[String] = []
            for i in one.indices {
                for j in two[0].indices {
                    var new = String()
                    new.append(one[i])
                    new.append(two[0][j])
                    tmpResult.append(new)
                }
            }
            return tmpResult
        } else {
            //继续往下递归
            var new = two.remove(at: 0)
            var next = [combinationTwo(new, &two)]
            //需要拿到递归结果和当前再组合再返回上一级
            return combinationTwo(one,&next)
        }
    }
    
    if digits.count == 0 {return []}
    var dict:[Character:[String]] = ["2":["a","b","c"],"3":["d","e","f"],"4":["g","h","i"],"5":["j","k","l"],"6":["m","n","o"],"7":["p","q","r","s"],"8":["t","u","v"],"9":["w","x","y","z"]]
    if digits.count == 1 {return dict[digits.first!]!}
    var list:[[String]] = []
    var newStr = digits//.replacingOccurrences(of: "1", with: "")
    for index in newStr.indices {
        list.append(dict[newStr[index]]!)
    }
    var one = list.remove(at: 0)
    var two = list
    return combinationTwo(one, &two)
}

//print(letterCombinations1("23456"))

//MARK: 18. 四数之和
/*
 解题思路：双指针
 0 1 ... n-2 n-1，先将指针s定位到1  e定位到n-2 相当于固定两个数0 和 n-1 来计算 找到所有组合 然后s++   有问题
 0 1
 */

func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
    if nums.count < 4 { return [] }
    if nums.count == 4 {
        if nums.reduce(0, +) == target {
            return [nums]
        }
        return []
    }
    //初始位置
    var newNums = nums.sorted()
    
    if newNums[0] == newNums[newNums.count-1] && (target >> 2) == newNums[0] {
        return [[newNums[0],newNums[0],newNums[0],newNums[0]]]
    }
    
    var left = 2
    var right = newNums.count - 1
    var result:Set<[Int]> = []
    
    var isLeft = 0
    //defaultRight - defaultLeft + 1 >= 4 才能接着走循环
    for i in 0..<(newNums.count - 3) {
        for j in (i+1)..<(newNums.count - 2) {
            var left = j+1
            var right = newNums.count - 1
            while left < right {
                var sum = newNums[i] + newNums[j] + newNums[left] + newNums[right]
                if sum == target {
                    let one = [newNums[i],newNums[j],newNums[left],newNums[right]]
                    result.insert(one)
                    
                    //过滤相同
                    while left < right && newNums[left] == newNums[left+1] {
                        left += 1
                    }
                    //过滤相同
                    while left < right && newNums[right] == newNums[right-1] {
                        right -= 1
                    }
                    left += 1
                    right -= 1
                } else if sum > target {
                    right -= 1
                } else {
                    left += 1
                }
            }
        }
    }

    return Array.init(result)
}

print(fourSum([1,0,-1,0,-2,2], 0))
//print(fourSum([-3,-1,0,2,4,5], 2))
