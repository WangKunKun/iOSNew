//
//  main.swift
//  DataStructure
//
//  Created by wangk on 2023/12/29.
//

import Foundation

print("Hello, World!")

var list = LinkedList<Int>()
list.add(element: 10)
list.add(element: 20)
list.add(element: 30)
list.add(index: 0, element: 5)
list.add(index: 2, element: 15)
list.add(index: list.count, element: 40)
print(list)

list.set(index: 3, element: 25)
print(list)
print(list.remove(index: 4))
print(list.count)
