//: [Previous](@previous)

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() {
        self.val = 0; self.left = nil; self.right = nil;
    }

    public init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}


func preorderTraversal(_ root: TreeNode?) -> [Int] {
    
    guard let head = root else {
        return []
    }
    var list:[Int] = []
    var left:[TreeNode] = []
    var right:[TreeNode] = []
    left.append(head)
    while left.count > 0 || right.count > 0 {
        var this = left.count > 0 ? left.remove(at: 0) : right.remove(at: 0)
        list.append(this.val)
        if left.left != nil {
            tmp.append(this.left!)
        }
        //右边插入
        if right.right != nil {
            tmp.append(this.right!)
        }
    }
    return list
}
