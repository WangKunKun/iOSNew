//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

public class ListNode {
     public var val: Int
     public var next: ListNode?
     public init() { self.val = 0; self.next = nil; }
     public init(_ val: Int) { self.val = val; self.next = nil; }
     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    guard head != nil, head?.next != nil else {
        return nil
    }
    
    var first:ListNode? = head
    var pre:ListNode?
    var k:ListNode? = head
    for _ in 0..<n {
        k = k?.next
    }
    while k?.next != nil {
        k = k?.next
        pre = first
        first = first?.next
    }
    
    pre?.next = first?.next
    
    return first
    
}
