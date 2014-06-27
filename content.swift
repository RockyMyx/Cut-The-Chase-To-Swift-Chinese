
//使用fuc定义函数，使用: 定义参数及类型，使用->定义返回类型
//如果参数在函数 调用时被省略了，就会使用初始值。如果参数没有省略，那么它在函数调用是必须有自己的名字.举例来讲， f()和f(x:7)都是只有一个变量x的函数的有效调用，但是f(7)是非法的，因为它提供了一个值而不是名称。
func greet(name: String, day: String) -> String {
	return "Hello \(name), today is \(day)";
}
greet("bob", "monday");



//函数参数默认是constant，所以不可以在函数内部对参数的值进行修改，否则会导致编译错误
//如果要修改参数的值，需要在定义函数时设置参数为var
func greet(var name: String, day: String) -> String {
	name = 'myx'
	return "Hello \(name), today is \(day)";
}
greet("bob", "monday");

//函数可以使用元组返回多个值
func getGasPrices() -> (Double, Double, Double) {
	return (1.00, 2.00, 3.00);
}

//使用...表示可变参数，一个函数最多只有一个可变参数，并且必须出现在函数的最后
//如果函数中有带默认值的参数，则可变参数出现在默认值参数的后面
func sumOf(numbers: Int...) -> Int {
	var sum = 0;
	for num in numbers {
		sum += num
	}
	return sum;
}

//使用inout指明参数的值在函数内部可以修改，并且当函数运行结束后，修改后的值会替换函数外部同名的变量值
//inout参数不能被指明为var或let，不可以有默认值，不可以是可变参数
//当传递input参数时，需要在变量名之前加&符号，表明可以被函数修改
func swapTwoInts(inout a: Int,  inout b: Int) {
    let temp = a
    a = b
    b = temp
}
var someInt = 1
var anotherInt = 2
swapTwoInts(&someInt,  &anotherInt)

//函数可以嵌套
func returnFifteen() -> Int(){
	var y = 10;
	func add(){
		y += 5;
	}
	add();
	return y;
}

//函数可以返回另一个函数作为返回值
fun makeIncrementer() -> (Int->Int) {
	func addOne(numbers: Int) -> Int {
		return 1 + numbers;
	}

	return addOne
}
var increment = makeIncrementer();
increment(7);

//函数可以使用另一个函数作为参数
func hasAnyMatches(list: Int[], condition: Int->Bool) -> Bool {
	for item in list {
		if (condition(item)) {
			return true
		}
	}
	return false
}

func lessThanTen(number: Int) -> Bool {
	return number < 10;
}

hasAnyMatches([1,5,8,10,34,11,62,4], lessThanTen);

//全局函数是一个拥有名字但不捕获任何值的闭包
//嵌套函数是一个拥有名字并且能够捕获包含函数中的值的闭包
//闭包表达式是匿名的并且可以在包含的上下文中捕获值

//闭包表达式格式，使用in分隔函数定义和实现：{(parameters) -> return type in statements }
//闭包表达式中支持变量和常量参数，支持inout参数，支持可变类型参数（需在最后），支持元组参数和返回类型，不支持默认值参数
//闭包可以省略 它的参数的type 和返回值的type. 如果省略了参数和参数类型，就也要省略 'in'关键字。 如果被省略的type 无法被编译器获知（inferred） ，那么就会抛出编译错误。
//闭包可以省略参数，转而在方法体（statement）中使用 $0, $1, $2 来引用出现的第一个，第二个，第三个参数。
//如果闭包中只包含了一个表达式，那么该表达式就会自动成为该闭包的返回值。 在执行 'type inference '时，该表达式也会返回。
//下面几个闭包是等价的
myFunction {
    （x: Int, y: Int） -> Int in
    return x + y
}

myFunction {
    （x, y） in
    return x + y
}

myFunction { return $0 + $1 }

myFunction { $0 + $1 }

-----------------------------------

numbers.map({
	(number: Int) -> Int in
	let result = 3* number;
	return result;
})

let names = ["Chris",  "Alex",  "Ewa",  "Barry",  "Daniella"]
reversed = sort(names, { (s1: String, s2: String) -> Bool in return s1 > s2 })

//更加简洁的闭包：当已知闭包的类型时，比如委托回调，可以忽略参数类型和返回值类型
numbers.map({ number in 3 * number})
reversed = sort(names, { s1, s2 in return s1 > s2})

//闭包自动提供参数的缩写，可以用$0,$1,$2...来表示参数
sort(names, {$0 > $1})

//操作符函数
//Swift中字符串类型定义了String相关的实现，如>符号表示两个比较两个String，并返回Bool，这正好匹配sort函数，所以可以简写为：
sort(names, >)

//如果想在函数参数中使用闭包表达式并且闭包表达式很长，则可以使用后缀闭包
//后缀闭包是一个写在调用函数括号后的闭包表达式
func someFunctionThatTakesAClosure(closure: () -> ()) {
    //function body
}
//不使用后缀闭包调用函数
someFunctionThatTakesAClosure({
	//closure's body
})
//使用后缀闭包调用函数
someFunctionThatTakesAClosure(){
	//trailing closure's body
}
//使用后缀闭包调用sort
sort(names) {$0 > $1}

//在闭包表达式是函数的唯一参数并且使用后缀闭包的情况下，可以省略调用时的()，如Array的map函数
let digitNames = [
    0: "Zero",  1: "One",  2: "Two",    3: "Three",  4: "Four",
    5: "Five",  6: "Six",  7: "Seven",  8: "Eight",  9: "Nine"
]
let numbers = [16,  58,  510]
let strings = numbers.map {
	//number的类型可以隐式推断
	(var number) -> String in
	var output = ""
	while number > 0 {
		output = digitNames[number % 10]! + output
		number /= 10
	}
	return output
}

//在闭包的参数列表（ capture list）中， 参数可以声明为 'weak' 或者 'unowned' .
myFunction { print（self.title） }                    // strong capture
myFunction { [weak self] in print（self!.title） }    // weak capture
myFunction { [unowned self] in print（self.title） }  // unowned capture

//函数如果没有返回值可以不写，但实际上Swift内部会处理函数返回值为Void，这是一个没有元素的元组，即()

//在函数定义时，为了指明参数，可以为参数定义一个名字
func join(s1: String,  s2: String,  joiner: String) -> String {
	return s1 + joiner + s2
}
join("hello",  "world",  ", ")  //调用时对应的参数不清楚

func join(string s1: String, toString s2: String, withJoiner joiner: String) -> String {
	return s1 + joiner + s2
}
join(string: "hello", toString: "world", withJoiner: ", ")  //当需要明确调用时的参数作用时才使用此方法

//可以为函数参数指定默认值，Swift会为有默认值的参数自动创建名字
func join(s1: String,  s2: String,  joiner: String = ", ") -> String {
	return s1 + joiner + s2
}
join("hello",  "world",  joiner: ", ")

//如果指明参数名字的时候和参数的: 名字相同，则不必重复写两次参数的名字，可以使用#前缀代替
func containsCharacter(#string: String,  #characterToFind: Character) -> Bool  {
	for character in string {
        if character == characterToFind {
            return true
		}
	}
    return false
}
//两种调用方式皆可
//let containsAVee = containsCharacter("aardvark", "v")
//let containsAVee = containsCharacter(string: "aardvark", characterToFind: "v")

//类似于C#中委托，Swift中可以定义一个变量或者常量表示拥有特定参数类型和返回值的函数
func addTwoInts(firstInt: Int, secondInt: Int) -> Int {
	return firstInt + secondInt
}
var mathFunction: (Int, Int) -> Int = addTwoInts
//在调用时可以使用：
mathFunction(2,3)
//可以将委托赋值为任何符合参数和返回类型约束的函数
func multiplyTwoInts(firstInt: Int, secondInt: Int) -> Int {
	return firstInt * secondInt
}
mathFunction = multiplyTwoInts

//类似地，可以使用“委托”作为函数的参数
func printMathResult(mathFunction: (Int, Int) -> Int, a: Int, b: Int) {
	println(mathFunction(a, b))
}
printMathResult(addTwoInts, 1, 2)

//可以使用函数作为另一个函数的返回类型
func stepForward(input: Int) -> Int {
	return input + 1
}
func stepBackward(input: Int) -> Int {
	return input - 1
}
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(currentValue > 0)
while currentValue ! = 0 {
    println("\(currentVal ue). . .  ")
    currentValue = moveNearerToZero(currentValue)
}
println("zero! ")

//可以使用在函数这种定义并使用函数（函数中定义的函数在外部不可访问）
func chooseStepFunction(backwards: Bool ) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input -  1 }
    return backwards ? stepBackward : stepForward
}

//定义类使用class
//类可以有指定和方便的构造器。当你声明任一中构造器时，你可以使用requierd变量来标记构造器，要求任意子类来重写它。指定类的构造器必须初始化类所有的已声明的属性， 它必须在子类构造器调用前被执行。
//超类的属性和方法声明可以被当前类继承，但是超类声明的指定构造器却不能。这意味着，如果当前类重写了超类 的所有指定构造器，它就继承了超类的方便构造器。
class Shape {
	var numberOfSides = 0
	func simpleDescription() -> String {
		return "Shape simpleDescription"
	}

	var name: String
	//构造函数
	init(name: String) {
		self.name = name;
	}
}
//声明类实例
var shape = SomeClass();
//调用实例方法
shape.simpleDescription();

//跟函数（function）不同， initializer 不能返回值。
var xx = SomeClass.init              // error

//弱引用和无主引用允许循环引用中的一个实例引用另外一个实例而不保持强引用。这样实例能够互相引用而不产生循环强引用。
//对于生命周期中会变为nil的实例使用弱引用。相反的，对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用。
//声明属性或者变量时，在前面加上weak关键字表明这是一个弱引用。因为弱引用可以没有值，因此必须将每一个弱引用声明为可选类型。

//Person和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { println("\(name) is being deinitialized") }
}
class Apartment {
    let number: Int
    init(number: Int) { self.number = number }
    weak var tenant: Person?
    deinit { println("Apartment #\(number) is being deinitialized") }
}
var john: Person?
var number73: Apartment?

john = Person(name: "John Appleseed")
number73 = Apartment(number: 73)

john!.apartment = number73
number73!.tenant = john

john = nil
// prints "John Appleseed is being deinitialized"
number73 = nil
// prints "Apartment #73 is being deinitialized"

//self用作后缀表达式：
形式1 表示会返回 expression 的值。例如： x.self 返回 x
形式2：返回对应的type。我们可以用它来动态的获取某个instance的type。


//键字unowned表示这是一个无主引用。无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用是永远有值的。ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil
//如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。使用无主引用，你必须确保引用始终指向一个未销毁的实例。还需要注意的是如果你试图访问实例已经被销毁的无主引用，程序会直接崩溃，而不会发生无法预期的行为。所以你应当避免这样的事情发生。

//Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，并会潜在的产生循环强引用。这种场景最适合通过无主引用来解决。
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { println("\(name) is being deinitialized") }
}
class CreditCard {
    let number: Int
    unowned let customer: Customer
    init(number: Int, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { println("Card #\(number) is being deinitialized") }
}

var john: Customer?
john = Customer(name: "John Appleseed")
john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)

john = nil
// prints "John Appleseed is being deinitialized"
// prints "Card #1234567890123456 is being deinitialized"


// 有第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后不能为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性。
//Country和City，每个类将另外一个类的实例保存为属性。在这个模型中，每个国家必须有首都，而每一个城市必须属于一个国家。为了实现这种关系，Country类拥有一个capitalCity属性，而City类有一个country属性：
class Country {
    let name: String
    let capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

//在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。
//捕获列表中的每个元素都是由weak或者unowned关键字和实例的引用（如self或someInstance）成对组成。每一对都在方括号中，通过逗号分开。
@lazy var someClosure: (Int, String) -> String = {
    [unowned self] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
}
//如果闭包没有指定参数列表或者返回类型，则可以通过上下文推断，那么可以捕获列表放在闭包开始的地方，跟着是关键字in：
@lazy var someClosure: () -> String = {
    [unowned self] in
    // closure body goes here
}

//类的析构函数deinit()：在对象回收之前的一些清理工作，每个类最多只能有一个。析构函数不带任何参数，deinit { // 执行析构过程 }
//Swift 会自动释放不再需要的实例以释放资源。如自动引用计数那一章描述，Swift 通过自动引用计数（ARC）处理实例的内存管理。通常当你的实例被释放时不需要手动地去清理。但是，当使用自己的资源时，你可能需要进行一些额外的清理。例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前关闭该文件。
//子类继承了父类的析构函数，则在子类析构函数实现的最后，父类的析构函数被自动调用。即使子类没有提供自己的析构函数，父类的析构函数也总是被调用。
//因为直到实例的析构函数被调用时，实例才会被释放，所以析构函数可以访问所有请求实例的属性，并且根据那些属性可以修改它的行为

//类继承及方法重写与C#语法一致，初始化使用init，使用self代表当前类
//Swift 为所有已提供属性默认值且没有定义任何构造器的结构体或基类提供一个默认的构造器。这个默认构造器将创建一个所有属性值都为默认值的实例。如果定义了其他的构造器，则不可以再访问默认的构造器
//类和结构体在实例创建时，必须为所有存储型属性设置合适的初始值（通过构造函数或者直接赋值），属性值不能处于一个未知的状态。如果是可空类型则默认赋值为nil，如果是常量，也仍然可以在构造函数中设置值
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
//由于ShoppingListItem类中的所有属性都有默认值，且它是没有父类的基类，所以有一个可以为所有属性设置默认值的默认构造器

//构造函数主要会自动为参数生成同名的外部名称，便于调用，所以param参数实际相当于#param
//如果不想构造函数自动创建参数名，可以使用_表示参数名，以此覆盖默认的行为。
//如果不写self，则Swift会认为在方法中使用的属性或方法均在当前类中，当方法中的参数名和类中的变量重名时，则必须写self加以区分
class Square: Shape {
	var sideLength: Double;
	init(sideLength: Double, name: String){
		self.sideLength = sideLength;
		super.init(name: name);
		numberOfSides = 4;
	}

	override simpleDescription() -> String {
		return "Square simpleDescription"
	}

	var perimeter: Double {
		get {
			return 4.0 * sideLength
		}
		set {
			sideLength = newValue / 4.0
		}
	}
}

//跟 Objective-C 中的子类不同，Swift 中的子类不会默认继承父类的构造器。
//Swift的这种机制可以防止一个父类的简单构造器被一个专门的子类继承，并被错误的用来创建子类的实例。

//Designated initializers：
init(parameters) {
    statements
}

//类中最主要的构造器，将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。每一个类都必须拥有至少一个Designated initializer。
//Convenience initializers：可以定义Convenience initializer调用同一个类中的Designated initializer，并为其参数提供默认值。也可以定义Convenience initializer创建一个特殊用途或特定输入的实例。应当只在必要的时候为类提供便利构造器。
convenience init(parameters) {
    statements
}

//Designated initializer必须调用其直接父类的的Designated initializer，即向上代理。
//Convenience initializer必须调用同一类中定义的其它构造器，且以调用一个指定的Designated initializer结束，即横向代理。

//如果子类没有定义任何Designated initializer，它将自动继承所有父类的Designated initializer。
//如果子类提供了所有父类Designated initializer的实现，它将自动继承所有父类的Convenience initializer。

class SomeClass {
    let someProperty: SomeType = {
        // 在这个闭包中给 someProperty 创建一个默认值
        // someValue 必须和 SomeType 类型相同
        return someValue
    }()
}
//包结尾的大括号后面接了一对空的小括号。这是用来告诉 Swift 需要立刻执行此闭包。如果你忽略了这对括号，相当于是将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
//如果你使用闭包来初始化属性的值，在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能够在闭包里访问其它的属性，就算这个属性有默认值也不允许。同样，你也不能使用隐式的self属性，或者调用其它的实例方法。
//只要在闭包内使用self的成员，就要用self.someProperty或者self.someMethod（而不只是someProperty或someMethod）。这提醒你可能会不小心就捕获了self。

//属性包括：
//1、Stored Property：保存实例的变量或常量值（定义在class和struct中）
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6
//当定义的结构体实例是常量，则不可以修改其变量属性，因为struct是值类型，当定义为constant时，其所有属性也为constant
//对于类来说，此规则不适用，因为类是引用类型
let rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6 //error
//有一种特殊的Stored Property叫做Lazy Property，即不在定义时赋值，而是在第一次使用时计算值，标注为@lazy，并且只能定义为var
//全局的变量和常量均为延迟计算的，但与Lazy Property的区别在于不用@lazy声明
//Lazy Property适用情况：初始值依赖于外部一个的未知变量值；值的计算比较消耗资源，仅仅在使用时才进行计算
class DataImporter {
	var fileName = "data.txt"
}
class DataManager {
	@lazy var importer = DataImporter()
	var data = String[]()
}
let manager = DataManager()
manager.data += "Some data"
manager.data += "Some more data"
//DataImporter实例未创建
println(manager.importer.fileName)
//DataImporter实例已创建

//2、Computed Property：有计算逻辑的
（定义在class、struct和enum中），只能定义为var
struct Point {
	var x = 0. 0,  y = 0. 0
}
struct Rect {
	var origin = Point()
	var size = Size()
	var center: Point {
		get {
			let centerX = origin.x + (size.width / 2)
			let centerY  = origin.y + (size. height / 2)
			return Point(x: centerX,  y: centerY )
		}
		set(newCenter) {
			origin.x = newCenter.x -  (size.width / 2)
			origin.y = newCenter.y -  (size.height / 2)
		}
		//newCenter可以省略不写，用newValue代替
		/*set(newValue) {
			origin.x = newValue.x -  (size.width / 2)
			origin.y = newValue.y -  (size.height / 2)
		}*/
	}
	var width = 0.0, height = 0.0
	//定义只读属性，可以省略get
	var size: Double {
		return width * height
	}
}
//3、Type Property：属性和自己的类型相关联
//不管有多少个实例，Type Property只会有一份，Type Property用于为某个类型的所有实例创建一个全局值
//必须为Type Property赋初始值
//在值类型（struct和enum）中定义Type Property使用static关键字，在类中使用class定义Type Property
class SomeStructure {
    static var storedTypeProperty = "Some val ue. "
    static var computedTypeProperty: Int {
    }
}
class SomeClass {
	class var computedTypeProperty: Int {
}

class EquilateralTriangle : Shape {
	var sideLength: Double;
	init(sideLength: Double, name: String){
		self.sideLength = sideLength;
		super.init(name: name);
		numberOfSides = 3;
	}

	var perimeter: Double{
		get {
			return 3.0 * sideLength
		}
		set {
			sideLength = newValue / 3.0
		}
	}
}

//Property observers：检测并响应属性值的变化，每次设置属性值时都会调用，即使值没有改变。还可以在子类中重写
//willSet：传递的是一个新的constant属性值，可以指定自定义的参数名字，如果省略的话可以在实现中使用newValue代替
//didSet：在值更新后调用，在使用值将传递一个旧的constant属性值，不可以指定自定义的参数名字，实现中使用oldValue代替原始值
//如果你不想计算属性值，但仍然想在设置新值前后使用，则使用willSet和didSet
//willSet和didSet在属性第一次初始化时并不会调用，只有在属性值在外部进行设置时才会调用
class TriangleAndSquare {
	init(size: Double, name: String){
		square = Square(sideLength: size, name: name);
		triangle = EquilateralTriangle(sideLength: size, name:name);
	}

	//保证等边三角形的边长和正方形的边长相等
	var triangle : EquilateralTriangle {
		willSet {
			square.sideLength = newValue.sideLength;
		}
	}
	var square : Square {
		willSet {
			square.sideLength = newValue.sideLength;
		}
	}
}
var small = TriangleAndSquare(size: 10, name: "small");
println(small.square.sideLength);
println(small.triangle.sideLength);
var large = TriangleAndSquare(size: 50, name: "small");
println(small.triangle.sideLength);
println(small.square.sideLength);

//子类在重写父类的属性时，父类中的属性对子类是不可见的，因此重写时必须同时声明属性的名字和类型，这样编译器才会去检查在父类中是否有同名同类型的属性可以重写
//重写属性时可以把一个可读写的属性重写为只读的，但是不可以把只读的重写为可读写的
class SpeedLimitedCar: Car {
	override var speed: Double  {
		get {
		    return super. speed
		}
		set {
		    super.speed = min(new Value, 40.0)
		}
	}
}

//可以在重写属性增加Observers，这样可以在继承的属性值在修改时使父类得到通知（针对只读的属性不可用）
//不可以同时在重写时使用setter和Observers
class Vehicle {
	var numberOfWheels: Int
	var maxPassengers: Int
	func description() -> String {
	    return "\(numberOfWheel s) wheels; up to \(maxPassengers) passengers"
	}
	init() {
	    numberOfWheels = 0
	    maxPassengers = 1
	}
}

class Car: Vehicle {
	var speed: Doubl e = 0. 0
	init() {
	    super.init()
	    maxPassengers = 5
	    numberOfWheels = 4
	}
	override func description() -> String {
	    return super.description() + "; " + "traveling at \(speed) mph"
}

class AutomaticCar: Car {
	var gear = 1
	override var speed: Doubl e {
		didSet {
		    gear = Int(speed / 10. 0) + 1
		}
	}
	override func description() -> String {
	    return super.description() + " in gear \(gear)"
	}
}

let automatic = AutomaticCar()
automatic.speed = 35.0
printl("AutomaticCar: \(automatic.description())")
// AutomaticCar: 4 wheels; up to 5 passengers; traveling at 35.0 mph in gear 4

//如果不想让一个方法、属性或者索引被重写，可以在声明时使用@final标识
//如@final class, @final var, @final func, @final class func, @final subscript

class StepCounter {
var totalSteps: Int = 0 {
	willSet(newTotalSteps) {
    	println("About to set totalSteps to \(newTotalSteps)")
	}
	didSet {
    	if totalSteps > oldValue {
        	println("Added \(totalSteps - oldValue) steps")
    	}
	}
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps

//类中的方法可以在方法定义内部指定参数的名字（第一个参数除外）
class Counter {
	var count: Int = 0;
	func incrementBy(amount: Int, numberofTimes times : Int){
		count += amount * times;
	}
}
var counter = Counter()
counter.incrementBy(2, numberofTimes: 7)

//使用enum定义枚举，枚举中可以定义方法，case关键字表示后面紧跟一行新的枚举值，一行可以定义多个枚举值
//枚举类型并不提供隐式的初始构造器，所有构造器必须显式的声明。
enum Card: Int {
	//Swift中的枚举值不会默认为0,1,2...，而是需要手动设置
	//Ace = 1表示枚举的初始值（Raw Value），当初始值为Int时，后面的枚举值会递增赋值
	//.Ace等称为隐式的属性值访问
	//可以使用Card.Ace.toRaw()访问初始值
	//通过Card.fromRaw(7)找到枚举中对应值的项，返回值为Optional Value
	case Ace = 1
	case Two,  Three,  Four,  Five,  Six,  Seven,  Eight,  Nine,  Ten
	case Jack,  Queen,  King
	func simpleDescription() -> String {
    	switch self {
    	case .Ace:
           return "ace"
		case .Jack:
			return "jack"
    	case .Queen:
			return "queen"
    	case .King:
			return "king"
		default:
			//toRaw和fromRaw函数可以在初始值类型和枚举值类型之间转换
			return String(self.toRaw())
		}
	}
}

//枚举赋值
var myCard = Rank.Ace
//再次赋值时可以省略枚举名
myCard = .Jack

//可以为枚举类型指定任何类型的值，且每个类型的值类型也可以不同
enum Barcode {
	case UPCA(Int, Int, Int)
    case QRCode(String)
}
var productBarcode = Barcode.UPCA(8, 85909_51226, 3)

//提取枚举元组值
switch productBarcode {
	case .UPCA(let numberSystem, let identifier, let check):
		println("UPCA with value of \(numberSystem),, \(identifier), \(check)")
	case .QRCode(let productCode):
		println("QR code with value of \(productCode)")
}
//如果要提取的值都是常量或者变量，则可以提到枚举值前面
switch productBarcode {
	case let .UPCA(numberSystem, identifier, check):
		println("UPCA with value of \(numberSystem),, \(identifier), \(check)")
	case let .QRCode(productCode):
		println("QR code with value of \(productCode)")
}

//使用struct定义结构体，struct是值类型，class是引用类型
//结构体可以包含任意数量的协议，但是不能继承自类，枚举或者其他结构体。


有两种方法来创建已声明的类的实例：

调用类的一个构造器，参见构造器(initializers)。
如果没有声明构造器，而且类的所有属性都被赋予了初始值，调用类的默认构造器

//在Swift中，class和struct非常类似：
//1、都可以定义属性
//2、都可以定义函数
//3、都可以定义索引访问值
//4、都可以在默认实现上进行功能扩展
//5、都可以实现protocol
//6、构建实例对象都使用"名字()"的形式，访问属性方法都使用.语法

//class中独有的特性：
//1、类可以继承
//2、类可以在运行时进行类型转换
//3、可以使用deinit方法释放类的示例以及关联的相关资源
//4、类是引用类型，可以指定多个类的实例

//struct中独有的特性：
//1、struct默认拥有由成员组成的构造器
struct Resolution {
    var width = 0
    var height = 0
}
var vga = Resolution(width: 640, height: 480)

//默认情况下，值类型中的属性不能被方法修改，但是可以在方法前使用mutating关键字表示方法可以对值类型进行修改，并且把修改返回原始类型
以self修饰的枚举或结构体方法必须以mutating关键字作为函数声明头。
protocol ExampleProtocol {
	var simpleDescription: String {get;}
	mutating func adjust()
}
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    //类中的方法一定能修改变量值，所以不用mutating标识
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct Point {
    var x = 0. 0,  y = 0. 0
    mutating func moveByX(deltaX: Double,  y deltaY : Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint = Point(x: 1. 0,  y: 1. 0)
somePoint.moveByX(2. 0,  y: 3. 0)
println("The point is now at  (\(somePoint.x),  \(somePoint.y))")
//"The point is now at (3.0, 4.0)"
let fixedPoint = Point(x: 3.0,  y: 3.0)
2 fixedPoint.moveByX(2.0,  y: 3.0) //error：不可以在常量上使用mutating方法

//mutating方法可以将类的实例赋值为self
struct Point {
	var x = 0.0, y = 0.0
	mutating func moveByX(deltaX: Double, y deltaY: Double) {
		self = Point(x: x + deltaX, y: y + deltaY)
	}
}
//对于枚举的mutating方法，可以将self赋值为同一枚举中的不同成员
enum TriStateSwitch {
	case Off, Low, High
	mutating func next() {
	    switch self {
	    case Off:
	        self = Low
	    case Low :
	        self = High
	    case High:
			self = Off
	}
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight is now equal to .High
ovenLight.next()
// ovenLight is now equal to .Off

//创建类型方法（Type Methods）：在类中使用class关键字，在值类型中使用static关键字
//Objective-C中只可以为类定义Type Methods

//可以在类中定义索引，从而通过[index]语法访问相应元素
subscipt(index: Int) -> Int {
	get {

	}
	//newValue可以省略不写
	set(newValue) {

	}
}
//索引访问也可以定义为只读的：
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTabl e = TimesTable(multiplier: 3)
println("six times three is \(threeTimesTable[6])")
//subscript可以使用变量或者可变参数，但是不能使用inout参数或者有默认值的参数
//subscript可以重载，可以定义多个参数
struct Matrix {
    let rows: Int,  columns: Int
    var grid: Double[]
    init(rows: Int, columns: Int) {
        self. rows = rows
        self. columns = columns
        grid = Array(count: rows * columns,  repeatedValue: 0.0)
    }
    func indexIsValidForRow (row: Int, column: Int) -> Bool  {
		return row >= 0 && row < rows && column >= 0 && column < columns
	}
	subscript(row: Int, column: Int) -> Doubl e {
		get {
			assert(indexIsValidForRow(row, column: column), "Index out of range")
			return grid[(row * columns) + column]
		}
		set {
			assert(indexIsValidForRow(row , column: column), "Index out of range")
			grid[(row * columns) + column] = newValue
		}
	}
}
Matrix matrix = Matrix(2, 2)
//grid = [0.0, 0.0, 0.0 ,0.0]
matrix(0, 1) = 1.5
matrix(1, 0) = 3.2
/*matrix = [ 0.0, 1.5
             3.2, 0.0 ] */

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

let protocolValue: ExampleProtocol = a
protocolValue.simpleDescription

//类型的扩展方法：extension
extension Int: ExampleProtocol {
	var simpleDescription: String {
		return "The number \(self)"
	}
	mutating func adjust() {
		self += 42
	}
}

//泛型
func repeat<ItemType>(item: ItemType, times: Int) -> ItemType[] {
	var result = ItemType[]();
	for i in 0..times {
		result += item
	}
	return result;
}

//使用where指明泛型类的约束条件
//除了where，还可以在泛型参数后面写冒号类名或protocol名，如使用<T: Equatable>
Equatabl e>.
func anyCommonElements <T, U where T: Sequence, U: Sequence, T.GeneratorType.Element: Equatable,
                                   T.GeneratorType.Element == U.GeneratorType.Element> (lhs: T, rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}
anyCommonElements([1, 2, 3], [3, 4, 5])


//用类型检查操作符(is)来检查一个实例是否属于特定子类型。若实例属于那个子类型，类型检查操作符返回 true ，否则返回 false 。
//向下类型转换使用as，如果不确定是否转换成功，可以使用as?

//Swift为不确定类型提供了两种特殊类型别名：
//AnyObject可以代表任何class类型的实例。
//Any可以表示任何类型，除了方法类型（function types）。
//当需要在工作中使用 Cocoa APIs，它一般接收一个AnyObject[]类型的数组，或者说“一个任何对象类型的数组”。这是因为 Objective-C 没有明确的类型化数组。但是，你常常可以确定包含在仅从你知道的 API 信息提供的这样一个数组中的对象的类型。

var things = Any[]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))

for thing in things {
    switch thing {
    case 0 as Int:
        println("zero as an Int")
    case 0 as Double:
        println("zero as a Double")
    case let someInt as Int:
        println("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        println("a positive double value of \(someDouble)")
    case is Double:
        println("some other double value that I don't want to print")
    case let someString as String:
        println("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        println("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        println("a movie called '\(movie.name)', dir. \(movie.director)")
    default:
        println("something else")
    }
}

//在一个switch语句的case中使用强制形式的类型转换操作符（as, 而不是 as?）来检查和转换到一个明确的类型。在 switch case 语句的内容中这种检查总是安全的。


//Swift允许你定义嵌套类型，可以在枚举类型、类和结构体中定义支持嵌套的类型。

//扩展就是向一个已有的类、结构体或枚举类型添加新功能（functionality）。这包括在没有权限获取原始源代码的情况下扩展类型的能力（即逆向建模）。扩展和 Objective-C 中的分类（categories）类似。（不过与Objective-C不同的是，Swift 的扩展没有名字。）

//Swift 中的扩展可以：添加计算型属性和计算静态属性；定义实例方法和类型方法；提供新的构造器；定义下标；定义和使用新的嵌套类型；使一个已有类型符合某个协议

//对于类进行扩展时，要完全按照类或结构体的定义方式写：
extension SomeType: SomeProtocol, AnotherProctocol {
    // 协议实现写到这里
}

扩展可以添加新的计算属性，但是不可以添加存储属性，也不可以向已有属性添加属性观测器(property observers)。

扩展能向类中添加新的便利构造器，但是它们不能向类中添加新的指定构造器或析构函数。指定构造器和析构函数必须总是由原始的类实现来提供。

如果你使用扩展向一个值类型添加一个构造器，在该值类型已经向所有的存储属性提供默认值，而且没有定义任何定制构造器（custom initializers）时，你可以在值类型的扩展构造器中调用默认构造器(default initializers)和逐一成员构造器(memberwise initializers)。  
正如在值类型的构造器委托中描述的，如果你已经把构造器写成值类型原始实现的一部分，上述规则不再适用。


struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// centerRect的原点是 (2.5, 2.5)，大小是 (3.0, 3.0)

扩展可以向已有类型添加新的实例方法和类型方法。下面的例子向Int类型添加一个名为repetitions的新实例方法：

extension Int {
    func repetitions(task: () -> ()) {
        for i in 0..self {
            task()
        }
    }
}

3.repetitions({println("Hello!")})
//或者3.repetitions{println("Hello!")}
// Hello!
// Hello!
// Hello!

结构体和枚举类型中修改self或其属性的方法必须将该实例方法标注为mutating 
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
// someInt 现在值是 9

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
            for _ in 1...digitIndex {
                decimalBase *= 10
            }
        return (self / decimalBase) % 10
    }
}
746381295[0]
// returns 5
746381295[1]
// returns 9

//Int值没有足够的位数，即下标越界，那么上述实现的下标会返回0，因为它会在数字左边自动补0：
746381295[9]
//returns 0


extension Character {
    enum Kind {
        case Vowel, Consonant, Other
    }
    var kind: Kind {
        switch String(self).lowercaseString {
        case "a", "e", "i", "o", "u":
            return .Vowel
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            return .Consonant
        default:
            return .Other
        }
    }
}
func printLetterKinds(word: String) {
    println("'\\(word)' is made up of the following kinds of letters:")
    for character in word {
        switch character.kind {
        case .Vowel:
            print("vowel ")
        case .Consonant:
            print("consonant ")
        case .Other:
            print("other ")
        }
    }
    print("\n")
}
printLetterKinds("Hello")
// 'Hello' is made up of the following kinds of letters:
// consonant vowel consonant consonant vowel

在类型名称后加上协议名称，中间以冒号:分隔即可实现协议；实现多个协议时，各协议之间用逗号,分隔，如下所示:
struct SomeStructure: FirstProtocol, AnotherProtocol {
    // 结构体内容
}

如果一个类在含有父类的同时也采用了协议，应当把父类放在所有的协议之前，如下所示:
class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
    // 类的内容
}
如果协议要求属性是可读写的，那么这个属性不能是常量存储型属性或只读计算型属性；如果协议要求属性是只读的(gettable)，那么任意的属性都能满足协议的规定，在你的代码中，即使为只读属性实现了写方法(settable)也依然有效。

通常在协议的定义中使用class前缀表示该属性为类成员；在枚举和结构体实现协议时中，需要使用static关键字作为前缀。
protocol AnotherProtocol {
    class var someTypeProperty: Int { get set }
}

协议中的方法支持变长参数(variadic parameter)，不支持参数默认值(default value)。

用类实现协议中的mutating方法时，不用写mutating关键字;用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字。

protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()
//lightSwitch 现在的值为 .On


通过扩展为已存在的类型遵循协议时，该类型的所有实例也会随之添加协议中的方法
protocol TextRepresentable {
    func asText() -> String
}
extension Dice: TextRepresentable {
    func asText() -> String {
        return "A \(sides)-sided dice"
    }
}

当一个类型已经实现了协议中的所有要求，却没有声明时，可以通过扩展来补充协议声明:
struct Hamster {
    var name: String
    func asText() -> String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

协议类型可以被集合使用，表示集合中的元素均为协议类型:
let things: TextRepresentable[] = [game,d12,simoTheHamster]
for thing in things {
    println(thing.asText())
}

一个协议可由多个协议采用protocol<SomeProtocol， AnotherProtocol>这样的格式进行组合，称为协议合成(protocol composition)。协议合成并不会生成一个新协议类型，而是将多个协议合成为一个临时的协议，超出范围后立即失效。
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    println("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)
// 输出 "Happy birthday Malcolm - you're 21!


@objc protocol HasArea {
    var area: Double { get }
}
@objc用来表示协议是可选的，也可以用来表示暴露给Objective-C的代码，此外，@objc型协议只对类有效，因此只能在类中检查协议的一致性。
is操作符用来检查实例是否遵循了某个协议。

optional属性仅仅可以用于使用@objc属性标记过的协议。这样的结果就是仅仅类类型可以采用并符合包含可选成员要求的协议。

为了限制协议的采用仅仅针对类类型，需要使用class_protocol属性标记整个协议声明。任意继承自标记有class_protocol属性协议的协议都可以智能地仅能被类类型采用。如果协议已经用object属性标记了，class_protocol属性就隐性地应用于该协议；没有必要再明确地使用class_protocol属性来标记该协议了。

as?返回一个可选值，当实例遵循协议时，返回该协议类型;否则返回nil
as用以强制向下转型。
在协议中使用@optional关键字作为前缀来定义可选成员。
@objc protocol CounterDataSource {
    @optional func incrementForCount(count: Int) -> Int
    @optional var fixedIncrement: Int { get }
}

内置函数swap

func swapTwoValues<T>(inout a: T, inout b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
始终使用大写字母开头的驼峰式命名法（例如T和KeyType）来给类型参数命名，以表明它们是类型的占位符，而非类型值。

你可以写一个在一个类型参数名后面的类型约束，通过冒号分割，来作为类型参数链的一部分。这种作用于泛型函数的类型约束的基础语法如下所示（和泛型类型的语法相同）：
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
}

Swift 的Dictionary类型对作用于其键的类型做了些限制。在字典的描述中，字典的键类型必须是可哈希，也就是说，必须有一种方法可以使其被唯一的表示。Dictionary之所以需要其键是可哈希是为了以便于其检查其是否已经包含某个特定键的值。这个需求强制加上一个类型约束作用于Dictionary的键上，当然其键类型必须遵循Hashable协议（Swift 标准库中定义的一个特定协议）。所有的 Swift 基本类型（如String，Int， Double和 Bool）默认都是可哈希。

不是所有的 Swift 中的类型都可以用等式符（==）进行比较。例如，如果你创建一个你自己的类或结构体来表示一个复杂的数据模型，那么 Swift 没法猜到对于这个类或结构体而言“等于”的意思。正因如此，这部分代码不能可能保证工作于每个可能的类型T，当你试图编译这部分代码时估计会出现相应的错误。
不过，Swift 标准库中定义了一个Equatable协议，该协议要求任何遵循的类型实现等式符（==）和不等符（!=）对任何两个该类型进行比较。所有的 Swift基本类型自动支持Equatable协议。代码修改为如下形式即可编译通过。
func findIndex<T: Equatable>(array: T[], valueToFind: T) -> Int? {
    for (index, value) in enumerate(array) {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
当定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分是非常有用的。一个关联类型作为协议的一部分，给定了类型的一个占位名（或别名）。作用于关联类型上实际类型在协议被实现前是不需要指定的。关联类型被指定为`typealias`关键字。

protocol Container {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}
struct IntStack: Container {
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
    return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

可以在参数列表中通过*where*语句定义参数的约束。一个`where`语句能够使一个关联类型遵循一个特定的协议，以及（或）那个特定的类型参数和关联类型可以是相同的。你可以写一个`where`语句，紧跟在在类型参数列表后面，where语句后跟一个或者多个针对关联类型的约束，以及（或）一个或多个类型和关联类型间的等价(equality)关系。

func allItemsMatch<C1: Container, C2: Container
                 where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, anotherContainer: C2) -> Bool {

        // 检查两个Container的元素个数是否相同
        if someContainer.count != anotherContainer.count {
            return false
        }

        // 检查两个Container相应位置的元素彼此是否相等
        for i in 0..someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }

        // 如果所有元素检查都相同则返回true
        return true
}

不同于C语言中的数值计算，Swift的数值计算默认是不可溢出的。溢出行为会被捕获并报告为错误。但Swift还有一套默认允许溢出的数值运算符，如可溢出的加号为`&+`。所有允许溢出的运算符都是以`&`开始的。

var willOverflow = UInt8.max
// willOverflow 等于UInt8的最大整数 255
willOverflow = willOverflow &+ 1
// 此时 willOverflow 等于 0

var willUnderflow = UInt8.min
// willUnderflow 等于UInt8的最小值0
willUnderflow = willUnderflow &- 1
// 此时 willUnderflow 等于 255

有符整型所有的减法也都是对包括在符号位在内的二进制数进行二进制减法的
var signedUnderflow = Int8.min
// signedUnderflow 等于最小的有符整数 -128，即10000000
signedUnderflow = signedUnderflow &- 1
// 此时 signedUnderflow 等于 127，即01111111

let x = 1
let y = x &/ 0
// y 等于 0

可以使用移位操作进行其他数据类型的编码和解码。
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent 是 0xCC, 即 204
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent 是 0x66, 即 102
let blueComponent = pink & 0x0000FF           // blueComponent 是 0x99, 即 153

这个例子使用了一个`UInt32`的命名为`pink`的常量来存储层叠样式表`CSS`中粉色的颜色值，`CSS`颜色`#CC6699`在Swift用十六进制`0xCC6699`来表示。然后使用按位与(&)和按位右移就可以从这个颜色值中解析出红(CC)，绿(66)，蓝(99)三个部分。

对`0xCC6699`和`0xFF0000`进行按位与`&`操作就可以得到红色部分。`0xFF0000`中的`0`了遮盖了`OxCC6699`的第二和第三个字节，这样`6699`被忽略了，只留下`0xCC0000`。

然后，按向右移动16位，即 `>> 16`。十六进制中每两个字符是8比特位，所以移动16位的结果是把`0xCC0000`变成`0x0000CC`。这和`0xCC`是相等的，就是十进制的`204`。

同样的，绿色部分来自于`0xCC6699`和`0x00FF00`的按位操作得到`0x006600`。然后向右移动8位，得到`0x66`，即十进制的`102`。

最后，蓝色部分对`0xCC6699`和`0x0000FF`进行按位与运算，得到`0x000099`，无需向右移位了，所以结果就是`0x99`，即十进制的`153`。

按位左移和按位右移的效果相当把一个整数乘于或除于一个因子为`2`的整数。向左移动一个整型的比特位相当于把这个数乘于`2`，向右移一位就是除于`2`。

有符整型的移位操作

正数符号位为`0`，代表正数，如4为00000100。
负数跟正数不同。负数存储的是2的n次方减去它的绝对值，n为数值位的位数。一个8比特的数有7个数值位，所以是2的7次方，即128，所以-4为11111100，即124。

负数的编码方式称为二进制补码表示。这种表示方式看起来很奇怪，但它有几个优点。

首先，只需要对全部8个比特位(包括符号)做标准的二进制加法就可以完成 `-1 + -4` 的操作，忽略加法过程产生的超过8个比特位表达的任何信息。

第二，由于使用二进制补码表示，我们可以和正数一样对负数进行按位左移右移的，同样也是左移1位时乘于`2`，右移1位时除于`2`。要达到此目的，对有符整型的右移有一个特别的要求：对有符整型按位右移时，使用符号位(正数为`0`，负数为`1`)填充空白位。

运算符重载：
struct Vector2D {
    var x = 0.0, y = 0.0
}
@infix func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

@infix表明是中置运算符，即出现在运算的中间，以下是前置运算符重载的定义，后置使用@postfix

@prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
// negative 为 (-3.0, -4.0)

组合赋值符号需要使用`@assignment`属性，还需要把运算符的左参数设置成`inout`，因为这个参数会在运算符函数内直接修改它的值。

@assignment func += (inout left: Vector2D, right: Vector2D) {
    left = left + right
}

var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
// original 现在为 (4.0, 6.0)

可以将 `@assignment` 属性和 `@prefix` 或 `@postfix` 属性起来组合，实现一个`Vector2D`的前置运算符。

@prefix @assignment func ++ (inout vector: Vector2D) -> Vector2D {
    vector += Vector2D(x: 1.0, y: 1.0)
    return vector
}

var toIncrement = Vector2D(x: 3.0, y: 4.0)
let afterIncrement = ++toIncrement
// toIncrement 现在是 (4.0, 5.0)
// afterIncrement 现在也是 (4.0, 5.0)

=, ->、//、/*、*/、. 以及一元前缀运算符 & 属于保留字，这些标记不能被重写或用于自定义运算符。三目条件运算符 `a？b：c` 也是不可重载。

新的运算符声明需在全局域使用`operator`关键字声明，可以声明为前置，中置或后置的。

@prefix @assignment func +++ (inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled 现在是 (2.0, 8.0)
// afterDoubling 现在也是 (2.0, 8.0)


可以为自定义的中置运算符指定优先级和结合性。结合性(associativity)的值可取的值有`left`，`right`和`none`。左结合运算符跟其他优先级相同的左结合运算符写在一起时，会跟左边的操作数结合。同理，右结合运算符会跟右边的操作数结合。而非结合运算符不能跟其他相同优先级的运算符写在一起。结合性(associativity)的值默认为`none`，优先级(precedence)默认为`100`。

以下例子定义了一个新的中置符`+-`，是左结合的`left`，优先级为`140`。

operator infix +- { associativity left precedence 140 }
func +- (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
// plusMinusVector 此时的值为 (4.0, -2.0)

运算符两侧的空白被用来区分该运算符是否为前缀运算符（prefix operator）、后缀运算符（postfix operator）或二元运算符（binary operator）。规则总结如下：

·如果运算符两侧都有空白或两侧都无空白，将被看作二元运算符。例如：a+b 和 a + b 中的运算符 + 被看作二元运算符。
·如果运算符只有左侧空白，将被看作前缀一元运算符。例如 a ++b 中的 ++ 被看作前缀一元运算符。
·如果运算符只有右侧空白，将被看作后缀一元运算符。例如 a++ b 中的 ++ 被看作后缀一元运算符。
·如果运算符左侧没有空白并紧跟 .，将被看作后缀一元运算符。例如 a++.b 中的 ++ 被看作后缀一元运算符（同理， a++ . b 中的 ++ 是后缀一元运算符而 a ++ .b 中的 ++ 不是）.

如果运算符 ! 或 ? 左侧没有空白，则不管右侧是否有空白都将被看作后缀运算符。如果将 ? 用作可选类型（optional type）修饰，左侧必须无空白。如果用于条件运算符 ? :，必须两侧都有空白。

用作声明的关键字： class、deinit、enum、extension、func、import、init、let、protocol、static、struct、subscript、typealias、var
用作语句的关键字： break、case、continue、default、do、else、fallthrough、if、in、for、return、switch、where、while


__FILE__	String	所在的文件名
__LINE__	Int	所在的行数
__COLUMN__	Int	所在的列数
__FUNCTION__	String	所在的function 的名字


在某个函数（function）中，__FUNCTION__ 会返回当前函数的名字。 在某个方法（method）中，它会返回当前方法的名字。 在某个property 的getter/setter中会返回这个属性的名字。 在init/subscript中 只有的特殊成员（member）中会返回这个keyword的名字，在某个文件的顶端（the top level of a file），它返回的是当前module的名字。


类、结构体或枚举类型的元类型是相应的类型名紧跟.Type。协议类型的元类型——并不是运行时适配该协议的具体类型——是该协议名字紧跟.Protocol。比如，类SomeClass的元类型就是SomeClass.Type，协议SomeProtocol的元类型就是SomeProtocal.Protocol。

你可以使用后缀self表达式来获取类型。比如，SomeClass.self返回SomeClass本身，而不是SomeClass的一个实例。同样，SomeProtocol.self返回SomeProtocol本身，而不是运行时适配SomeProtocol的某个类型的实例。还可以对类型的实例使用dynamicType表达式来获取该实例在运行阶段的类型

class SomeBaseClass {
    class func printClassName（） {
        println（"SomeBaseClass"）
    }
}
class SomeSubClass: SomeBaseClass {
    override class func printClassName（） {
        println（"SomeSubClass"）
    }
}
let someInstance: SomeBaseClass = SomeSubClass（）

// someInstance is of type SomeBaseClass at compile time, but
// someInstance is of type SomeSubClass at runtime
someInstance.dynamicType.printClassName（）
// prints "SomeSubClass"


柯里化函数或方法有着如下的形式：

func function name(parameters)(parameters) -> return type {
statements
}
以这种形式定义的函数的返回值是另一个函数。
柯里化函数的函数类型从右向左组成一组。例如，函数类型Int -> Int -> Int可以被理解为Int -> (Int -> Int)——也就是说，一个函数传入一个Int然后输出作为另一个函数的输入，然后又返回一个Int。举例来说，下面的两个声明时等价的:

func addTwoNumbers(a: Int)(b: Int) -> Int {
    return a + b
}
func addTwoNumbers(a: Int) -> (Int -> Int) {
    func addTheSecondNumber(b: Int) -> Int {
        return a + b
    }
    return addTheSecondNumber
}


类的指定构造器将类的所有属性直接初始化。如果类有超类，它不能调用该类的其他构造器,它只能调用超类的一个
指定构造器。如果该类从它的超类处继承了任何属性，这些属性在当前类内被赋值或修饰时，必须调用一个超类的
指定构造器。

指定构造器可以在类声明的上下文中声明，因此它不能用扩展声明的方法加入一个类中。

结构体和枚举的构造器可以调用其他的已声明的构造器，委托其中一个或所有的构造器进行初始化过程。

便利构造器可以将初始化过程委托给另一个便利构造器或类的一个指定构造器。这意味着，类的初始化过程必须 以一个将所有类属性完全初始化的指定构造器的调用作为结束。便利构造器不能调用超类的构造器。

你可以使用required关键字，将便利构造器和指定构造器标记为每个子类的构造器都必须拥有的。因为指定构造器 不被子类继承，它们必须被立即执行。当子类直接执行所有超类的指定构造器(或使用便利构造器重写指定构造器)时， 必需的便利构造器可以被隐式的执行，亦可以被继承。你不需要为这些重写的构造器标注 overrride关键字。

deinit不能出现在扩展中

属性，方法，现存类型的构造器不能被它们类型的扩展所重写。

相同优先级的非结合运算符，不可以互相邻接。例如，表达式1 < 2 < 3非法的。

重载了复合赋值运算符的函数必需将它们的初始输入参数标记为inout
@assignment func += (inout left: Vector2D, right: Vector2D) {
	left = left + right
}

class_protocol
该特性用于修饰一个协议表明该协议只能被类类型采用，如果你用objc特性修饰一个协议，class_protocol特性就会隐式地应用到该协议，因此无需显式地用class_protocol特性标记该协议。

exported

该特性用于修饰导入声明，以此来导出已导入的模块，子模块，或当前模块的声明。如果另一个模块导入了当前模块，那么那个模块可以访问当前模块的导出项。

final

该特性用于修饰一个类或类中的属性，方法，以及下标成员。如果用它修饰一个类，那么这个类则不能被继承。如果用它修饰类中的属性，方法或下标，则表示在子类中，它们不能被重写。

noreturn

该特性用于修饰函数或方法声明，表明该函数或方法的对应类型，T，是@noreturn T。你可以用这个特性修饰函数或方法的类型，这样一来，函数或方法就不会返回到它的调用者中去。

对于一个没有用noreturn特性标记的函数或方法，你可以将它重写(override)为用该特性标记的。相反，对于一个已经用noreturn特性标记的函数或方法，你则不可以将它重写为没使用该特性标记的。相同的规则试用于当你在一个comforming类型中实现一个协议方法时。

objc

该特性用于修饰任意可以在Objective-C中表示的声明，比如，非嵌套类，协议，类和协议中的属性和方法（包含getter和setter），初始化器，析构器，以下下标。objc特性告诉编译器该声明可以在Objective-C代码中使用。
如果你将objc特性应用于一个类或协议，它也会隐式地应用于那个类或协议的成员。对于标记了objc特性的类，编译器会隐式地为它的子类添加objc特性。标记了objc特性的协议不能继承自没有标记objc的协议。
objc特性有一个可选的参数，由标记符组成。当你想把objc所修饰的实体以一个不同的名字暴露给Objective-C，你就可以使用这个特性参数。你可以使用这个参数来命名类，协议，方法，getters，setters，以及初始化器。下面的例子把ExampleClass中enabled属性的getter暴露给Objective-C，名字是isEnabled，而不是它原来的属性名。

@objc
class ExampleClass {
    var enabled: Bool {
    @objc(isEnabled) get {
        // Return the appropriate value
    }
    }
}

auto_closure

这个特性通过自动地将表达式封闭到一个无参数闭包中来延迟表达式的求值。使用该特性修饰无参的函数或方法类型，返回表达式的类型。一个如何使用auto_closure特性的例子。

//你可以对函数类型应用带有参数类型()并返回表达式类型的auto_closure属性（见类型属性章节）。一个自动闭包函数捕获特定表达式上的隐式闭包而非表达式本身。下面的例子使用auto_closure属性来定义一个很简单的assert函数：
func simpleAssert(condition: @auto_closure () -> Bool, message: String){
    if !condition(){
        println(message)
    }
}
let testNumber = 5
simpleAssert(testNumber % 2 == 0, "testNumber isn't an even number.")
// prints "testNumber isn't an even number."

noreturn

该特性用于修饰函数或方法的类型，表明该函数或方法不会返回到它的调用者中去。你也可以用它标记函数或方法的声明，表示函数或方法的相应类型，T，是@noreturn T。