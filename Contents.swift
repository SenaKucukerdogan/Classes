import Foundation

// classes mutable and use reference type
// classes have inheritance
// classes have two type initializer; convenience initializer and designated initializer
// between classes and structures in that classes allow for "" internal mutability "" with "" let ""
// without you having to create an "" actual var "" out of them


class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func increaseAge() {
        self.age += 1
    }
}

let foo = Person(name: "Foo", age: 20) // let constant equal to an instance of a class,
foo.age
foo.increaseAge()                      // this class internally has changed
foo.age

let bar = foo
bar.age
bar.increaseAge()
bar.age

foo.increaseAge()
foo.age
bar.age // because reference type, copyin age's address

if foo === bar { //In swift === this logic pointing to the same memory allocation
    "Foo and Bar point to the same memory location"
} else {
    "They don't point to the same memory location"
}

// **************************************************

class Vehicle {  // super class
    func goVroom() {
       "Vroom vroom"
    }
}

class Car: Vehicle { // subclass
    
}

let car = Car()
car.goVroom()

// **************************************************


class Person2 {
    
    private(set) var age: Int // using private sets we're saying that only can be set this
                              // class implementation and can be read from the outside
    init(age: Int) {
        self.age = age
    }
    
    func increaseAge(){
        self.age += 1
    }
}

let baz = Person2(age: 20)
// baz.age += 1
// private set then it can't be modified from outside the class implementation itself
// "Left side of mutating operator isn't mutable: 'age' setter is inaccessible" hatasını alırız

baz.age
// private kapsüllemesini set ile birlikte tanımladığımız için dışarıdan okuyabiliyoruz.

baz.increaseAge()
// however you can use still this function which then modifies that increase age

baz.age


// ******************************************************

// designated initializers and convenience initializers can define more than once

class Tesla {
    let manufacturer = "Tesla"
    let model: String
    let year: Int
    
    init() {                               // designated initializer
//  self.init(model: String, year: Int)    // designated initializers cannot delegate another designated initializer
        
        self.model = "X"
        self.year = 2022
    }
    
    init(model: String, year: Int) {       // designated initializer
        self.model = model
        self.year = year
    }
    
    convenience init(model: String) {      // convenience initializers
        self.init(model: model, year: 2024)
        // convenience initializer is delegating its work to a designated initializer in here
    }
}

class TeslaModelY: Tesla {
    
// TeslaModelY, Tesla super class'ından kalıtıldığı için aynı isimle direkt init() adında tekrar initializer tanımlayamayız. override etmemiz gerekir.
    override init() {
        
        // Must call a designated initializer of the superclass
        super.init(model: "Y", year: 2023)

     // super.init(model: "Y")
     // musn't' call a convenience initializer of the superclass
    }
}

let modelY = TeslaModelY()
modelY.manufacturer
modelY.model
modelY.year

let modelX = Tesla()
modelX.manufacturer
modelX.model
modelX.year

let modelZ = Tesla(model: "Z", year: 2025)
modelZ.manufacturer
modelZ.model
modelZ.year

let modelS = Tesla(model: "S")
modelS.manufacturer
modelS.model
modelS.year

// **************************************************

// classes reference type

let foozBar = Person2(age: 22)
foozBar.age

func doSomething(with person: Person2) {
    person.increaseAge()
}

doSomething(with: foozBar)
foozBar.age

// different examples

let fozBar = Person(name: "fozBar", age: 30)
fozBar.age

let newPer = fozBar
newPer.age

func do_something(with person: Person) {
    person.increaseAge()
}

do_something(with: fozBar)
fozBar.age
newPer.age

// **************************************************
// deinitializer

class MyClass {
    
    init(){
        "Initialized"
    }
    
    func doSomething() -> String {
        "Do Something"
    }
    
    deinit {
        "Deinitialized"
    }
}

let myClosure = {
    let myClass = MyClass()
    myClass.doSomething()
}
myClosure()
