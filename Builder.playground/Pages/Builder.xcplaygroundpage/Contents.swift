//: [Previous](@previous)

import Foundation

@resultBuilder
enum AnimalBuilder {
    //可以像下面一样写，但是没必要 因为我的本质是要将any 转换为 some
    static func buildBlock<A: Animal>(_ builder:Animal) -> some Animal {
        builder
    }
    
//    //空的 则
//    public static func buildBlock() -> Animal {
//        Dog()
//        Cat()
//    }
//
//    // 对应 block 中有 n 个 component 的情况（ n 为正整数 ）
    public static func buildBlock(_ components: Animal...) -> [some Animal] {
        var list:[Animal] = []
        for animal in components {
            list.append(animal)
        }
        return list
    }
}

extension AnimalBuilder {
    //MARK: 这个方法是处理不带else的if 以及 if let的逻辑
    static func buildOptional<A: Animal>(_ component: A?) -> some Animal {
      component ?? Animal()
    }
    //MARK: 下面两个方法是处理带else的if 以及 switch的逻辑
    static func buildEither<A: Animal>(first component: A) -> some Animal {
      component
    }

    static func buildEither<A: Animal>(second component: A) -> some Animal {
      component
    }
    //MARK: 针对for循环的处理
    static func buildArray(_ components: [Animal]) -> [Animal] {
        components
    }
    //MARK: 处理版本兼容性问题 方法并不会独立存在，它会和 buildOptional 或 buildEither 一并使用
    static func buildLimitedAvailability(_ component: AttributedString) -> AttributedString {
        component
    }
}

class Animal {
    func action() {
        print("基类animal 不会叫")
    }
    
    func eat() {
        print("基类animal 也不能吃东西")
    }
}

class Dog : Animal {
    
    override func action() {
        print("汪汪")
    }
    
    override func eat() {
        print("肉")
    }
}

class Cat: Animal {
    override func action() {
        print("喵喵")
    }
    
    override func eat() {
        print("草")
    }
}

//@AnimalBuilder
//var list:[Animal] {
//    Cat()
//    Dog()
//}

//var list:[Animal] = [Cat(),Dog()]
//for i in list {
//    kkk(i)
//}
//解决返回值只能是animal，或者 any animal的问题，这样就将any转为了some
@AnimalBuilder
func kkk(flag:Bool) -> some Animal {
    if flag {
        Cat()
    } else {
        Dog()
    }
}

print(kkk(flag: true).action())
print(kkk(flag: false).action())


protocol WWW {
    associatedtype T
    var content:T {get}
}

@resultBuilder
enum WWWBuilder {
    
    static func buildBlock<A: WWW>(_ builder:any WWW) -> some WWW {
        builder
    }
}
