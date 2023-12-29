//
//  LinkedList.swift
//  DataStructure
//
//  Created by wangk on 2023/12/29.
//

import Foundation

class LinkedList<E:Equatable> : List {
    
    fileprivate var head:Node<E>?
    
    private var size: Int = 0
    
    var count: Int {
        size
    }
    
    func clear() {
        head = nil
        size = 0
    }
    
    func add(element: E) {
        add(index: size, element: element)
        
    }
    
    func add(index: Int, element: E) {
        guard !rangeCheckForAdd(index: index) else {
            debugPrint("越界")
            return
        }
        size += 1
        let new = Node(element: element)
        if index == 0 {
            new.next = head
            head = new
            return
        }
        let node = node(index: index - 1)
        new.next = node?.next
        node?.next = new
    }
    
    func remove(index: Int) -> E? {
        
        guard let head = head else {
            return nil
        }
        //越界了
        guard !rangeCheck(index: index) else {
            return nil
        }
        size -= 1
        if index == 0 {
            self.head = nil
            return head.element
        }
        let pre = node(index: index - 1)
        let present = pre?.next
        pre?.next = present?.next
        return present?.element
        
    }
    
    func indexOf(element: E) -> Int? {
        guard let head = head else {
            return nil
        }
        var count = 0
        while head.next != nil {
            if head.element == element {
                return count
            }
            count += 1
        }
        return nil
    }
    
    
    func set(index:Int,element:E) {
        self.node(index: index)?.element = element
    }
    
    func get(index:Int) -> E? {
        return self.node(index: index)?.element
    }
    
    private func node(index:Int) -> Node<E>? {
        var node = head
        for _ in 0..<index {
            node = node?.next
        }
        return node
    }
    
}

extension LinkedList {
    fileprivate class Node<Item:Equatable> {
        var next:Node?
        var element:Item
        init(next: Node? = nil, element: Item) {
            self.next = next
            self.element = element
        }
    }
}

extension LinkedList : CustomDebugStringConvertible where E : CustomDebugStringConvertible {
    var debugDescription: String {
        var str = ""
        var node = head
        while node != nil {
            str.append("_\(node!.element)")
            node = node?.next
        }
        return str
    }
    
}

extension LinkedList : CustomStringConvertible where E : CustomStringConvertible {

    var description: String {
        var str = ""
        var node = head
        while node != nil {
            str.append("_\(node!.element)")
            node = node?.next
        }
        return str
    }
}
