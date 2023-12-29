//
//  List.swift
//  DataStructure
//
//  Created by wangk on 2023/12/29.
//

import Foundation

enum ListError: Error{
    case outOfBounds(index:Int, size:Int)
}

protocol List {

    associatedtype E
    
    var count:Int {get}
    
    func clear()
    
    func isEmpty() -> Bool
    func add(element:E)
    func add(index:Int,element:E)
    func set(index:Int,element:E)
    func get(index:Int) -> E?
    func remove(index:Int) -> E?
    func contains(element:E) -> Bool
    func indexOf(element:E) -> Int?
    
}

extension List { //默认实现 以及 部分帮助方法
    
    func contains(element:E) -> Bool {
        guard let _ = indexOf(element: element) else {
            return false
        }
        return true
    }
    
    
    func isEmpty() -> Bool {
        count == 0
    }
    
    func rangeCheck(index:Int) -> Bool {
        return index < 0 || index >= count
    }
    
    func rangeCheckForAdd(index:Int) -> Bool {
        return index < 0 || index > count
    }
}

