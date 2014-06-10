//不用在输入输出时引入library
//不用写main方法
//不用在每句话后写; 如果要在一行代码中写多个语句则必须写;
//不用编写头文件(.h)和代码文件(.m)

println("Hello")

//定义变量使用var或者let，使用var表示变量，使用let表示定义常量
let maximumNumberOfLoginAttempts = 10 //定义常量并赋值为10
var currentLoginAttempt = 0 //定义变量，初始值为0

//可以使用，间隔，在一行语句中定义多个变量
var first = 1, second = 2, third = 3

//显示声明使用 ：类型 的语法，Swift可以推断变量类型，所以一般不在定义变量时显示指明类型
var explicitDouble : Double = 70;

//变量无法隐式转换，需在前面加需要转换的类型
let label = "The width is"
let width = 94
let widthLabel  = label  + String(width)

//另一种方式（String Interpolation），使用\(variable)
//在括号中不可以再出现转义的单引号或反斜杠等，并且不能包含回车和换行
let appleCount = 3
let applePhrase = "I have \(appleCount) apples"

//类型以大写字母开头，分为有符号和无符号两种，如Int32, UInt64, Int8（-128-127）, UInt8（0-255）
//如果使用Int，则类型由CPU决定，如果是32位系统则为Int32，否则为Int64
//一般情况下使用Int，除非是确定需要只针对某平台的编程

//获取类型的最大和最小值
let minValue = UInt8.min;
let maxValue = UInt8.max;

//定义十进制数，不带前缀 
//定义二进制数，以0b前缀
//定义八进制数，以0o前缀 
//定义十六进制数，以0x前缀
let decimalInteger = 17
let binaryInteger = 0b10001       
let octalInteger = 0o21           
let hexadecimalInteger = 0x11     

//十进制使用e表示10的次方
1.25e2 //125.0

//十六进制使用p表示2的此方
0xFp2  //60.0

//Float精确到小数点后6位，Decimal则可以精确到小数点后15位
//定义浮点数时如果不显示指定类型，Swift总是会使用Double
//当把浮点数转换为整形时，会直接截断小数位值

//可以使用定义变量为元组，元组中可以包含多个且不同的类型，如：
let http404Error = (404, "Not Found");

//如果只需要元组的部分信息，则不需要的部分使用_即可，如：
let (justCode, _) = http404Error //justCode的值为404

//可以使用.数字索引取得元组中的信息，如：
println(http404Error.0)

//定义元组时可以指定名字
let http200Error = (statusCode: 200, description: "OK")

//可以使用元组.名字的方法取得元组信息
println(http200Error.statusCode)

//使用元组定义时，元组的值会分解为对应变量的值
let (x,y) = (1,2)  // 等价于 let x = 1; let y = 2;

let dollarSign = "\x24"        // $,   Unicode scalar U+0024
let blackHeart = "\u2665"      // ♥,   Unicode scalar U+2665
let sparklingHeart = "\U0001F496"  //  ,  Unicode scalar U+1F496

//String是值类型，如果你创建一个新的String，当传递到函数方法中，或设定为变量或常量的值时会被复制一份
//在Objective-C中，NSString是引用类型
//创建空String
var emptyString = "";
var emptyString2 = String();
//判断String是否为空
emptyString.isEmpty();
//计算String长度使用countElements
//countElements以Unicode字符统计长度，在Objective-C中NSString的length方法则是以UTF-16方式，所以两者的结果会不同
//在Swift中对应NSString中的length方法，需要使用uft16count方法
xx.countElements()
//使用==判断字符串是否相等，当两个字符串包含同样的字符并且字符出现的顺序一直则视为相等
//String的hasPrefix和hasPrefix方法可以进行字符串的逐字匹配，判断其是否以某些字符开始或结束（相当于C#中的StartWith和Endwith）
//String的大小写转换使用uppercaseString和lowercaseString属性
let normal = "hello,world";
let upperNormal = normal.uppercaseString
let lowerNormal = normal.lowercaseString

//Swift中的String有三种形式：UTF8，UTF-16和以21位unicode字符组成
//访问String的UTF8形式的字符可以使用utf8属性，utf8属性是UTF8View类型，是UInt8值的集合
let dogString = "Dog!"
for codeUnit in dogStrng.utf8 {
	println("\(codeUnit)")  //68 111 103 33
}
//访问String的UTF16形式的字符可以使用utf16属性，utf16属性是UTF16View类型，是UInt16值的集合
//访问String的以21位unicode字符组成形式的字符可以使用unicodeScalars属性，unicodeScalars属性是UnicodeScalars类型

let anotherPoint = (2,  0)
switch anotherPoint {
	//表示匹配任何y值为0的点，并且定义x为常量，值为相应匹配的值2
	case (let x, 0):
		println("on the x-axi s w i th an x val ue of \(x)")
	case (0,  let y):
	    printl n("on the y-axi s w i th a y val ue of \(y)")
	case let (x, y):
	    println("somew here el se at (\(x),  \(y))")
}

//还可以在case后加where进行额外的判断
case let(x, y) where x == y : ...
//在switch中有continue，break，fallthrough和return四种控制循环的方式
//如果case语句没有穷举所有情况，则必须加default，否则可以省略
//fallthrough会在执行完当前case语句后自动跳到下一个case语句或default中

//可以在循环语句中加入占位符进行控制
gameLoop: while square ! = finalSquare {
    if ++diceRoll  == 7 { diceRoll  = 1 }
    switch square + diceRoll  {
	    case finalSquare:
	        break gameLoop
	    case let new Square where new Square > final Square:
	        continue gameLoop
		default:
			square += diceRoll
			square += board[square]
	}
}


//使用可空操作符?时，如果?前面的值不为nil，则继续执行?后面的操作，如果为nil，则跳过?后面的操作不执行，避免crash
let optionalSquare = Square?=Square(sideLength:2.5, name: "test")
let sideLength = optionalSquare?.sideLength;

//String转Int可以使用toInt()方法，但是由于转换可能不成功，如"hello".toInt()，所以转换的结果是Int?

//!表示确定这里的的strValue一定是非nil的
if strValue {
    let hashValue = strValue!.hashValue
}

//使用typealias定义类型别名，如：
typealias myInt = UInt16

//Array只能存储同一类型的值，而Objective-C中的NSArray和NSMutableArray可以存储任何类型的object
//创建Array
var list = ["a", "b", "c"];
//使用索引访问
list[0]
//创建空Array
let emptyArray = String[]();
let emptyArray = [];

//泛型数组
Array<SomeType> //等价于SomeType[]

//获得数组元素个数使用count方法
//判断数组是否为空使用isEmpty属性
//添加数组元素使用append方法，或者直接使用+=，+=后不仅可以跟数组对应类型的值，也可以直接跟一个同类型的数组
//可以使用...操作符批量替换数组中的元素，且替换的数量可以和边界表示的数量不一致
var list = [1,2,3,4,5,6,7,8,9]
list[2,5] = [10] //list = [1,2,10,7,8,9]
//在数组的某个位置插入元素
list.insert(10, atIndex: 0);
//在数组的某个位置移除元素，并返回该元素
list.removeAtIndex(0);
//移除数组的最后一个元素，并返回该元素，相对于removeAtIndex可以避免获取数组的长度，效率更高
list.removeAtLast(0);

//遍历数组时如果想同时获取元素的索引则可以使用enumerate方法
for(index, value) in enumerate(list) {
	println("Item \(index) : \(value)");
}

//Array提供构造函数初始化，可以在其中指定数组的个数及类型的默认值
var zeroDoubles = Double[](count: 3, repeatedValue: 0.0)  //[0.0, 0.0, 0.0]
//也可以让Swift自行推断类型
var anotherDoubles = Array(count: 3, repeatedValue: 2.5) //[2.5, 2.5, 2.5]
//同类型的数组之间可以通过+组合元素
var sixDoubles = zeroDoubles + anotherDoubles; ////[0.0, 0.0, 0.0, 2.5, 2.5, 2.5]

//如果设置数组为constant，则不可以改变其大小，但是可以为某个索引设置新值
//如果设置字典为constant，则表示不可以改变字典的任何内容

//创建Dictionary
var dict = [
	"a" : 1,
	"b" : 2
]
//创建空Dictionary
let emptyDict = Dictionary<String, Float>();
let emptyDict = [:]
//修改字典中特定键所对应的值：updateValue(forKey:)，当键存在时可以更新值，否则为字典创建一个键值
dict.updateValue(5, forKey:"a"); //返回类型为可空值类型，如键对应没有值则为nil，本例为1
//使用索引访问字典键的值返回类型也为optional value
//两种方法移除字典中的某个键值对
dict["a"] = nil;
dict.removeValueForKey("a")
//使用keys和values属性获取字典的键集合和值集合，并且可以通过Array构造函数构建数组
Array(dict.keys)
Array(dict.values)

//在复制字典时，如果键/值是值类型，则会被创建相同的副本，如果是引用类型，则会复制引用
var ages = ["Peter": 23,  "Wei ": 35,  "Ani sh": 65,  "Katya": 19]
var copiedAges = ages
copiedAges["Peter"] = 24
println(ages["Peter"]) //23
//数组只有当出现长度被修改时，行为才会和字典一致，否则当做引用类型处理
var a = [1,  2,  3]
var b = a
var c = b
//1
println(a[0])
println(b[0])
println(c[0])
//改变值
a[0] = 10
println(a[0]) //10
println(b[0]) //10
println(c[0]) //10
//改变长度并改变值
a.append(4)
a[0] = 777
println(a[0]) //777
println(b[0]) //10
println(c[0]) //10
//如果一个数组多个变量引用，可以使用unshare方法复制数组，并确保数组唯一性（但不可用于constant数组）
//如果数组只有一个引用，则unshare不会产生复制操作
b.unshare()
b[0] = 100
println(a[0]) //777
println(b[0]) //100
println(c[0]) //10
//判断数组是否拥有相同的元素使用===和!==
//强制数组进行复制使用copy方法
var names = ["Mohsen",  "Hilary",  "Justyn",  "Amy",  "Rich",  "Graham",  "Vic"]
var copiedNames = names.copy()
copiedNames[0] = "Mo"
println(names[0]) //"Mohsen"
//如果要确保数组内容引用的唯一性，则使用unshare
//copy方法总是会复制数组，即使在数组已经使用unshare的情况下

//遍历字典时，结果的顺序不一定是字典的添加顺序
//循环遍历时括号可以不写
for xx in xxx {
	...
}
//如果不关心遍历的值，可以使用下划线代替
let base = 3
let power = 10
let answer = 1
for _ in 1...power{
	answer *= base
}

//类型后紧跟?表示可为nil，即空值
var optionalName: String?="John";
//可以使用动态绑定
if let constantName = someOptional {
	statements
}
//optionalName为nil，则条件为false
if let name = optionalName {
	println("Hello, \(name)");
}

//条件语句的条件必须为false或true，其他类型不会隐式转换
let i = 1
if i { ... } //error
if i == 1 { ... } //ok

//switch接受任何类型的参数，且分支语句不用break

//使用for..in遍历字典
let numDict = [
	"a" : [1,2,3],
	"b" : [4,5,6],
	"c" : [7,8,9]
]
for(key, value) in numDict {
	for num in value {
		println(num);
	}
}

//for循环
//..默认会忽略较大值边界（3），...则会包含两个边界的值
for i in 0..3 {
	println(i);
}
i
//循环的条件可以在最后出现，从而确保循环至少运行一次

for var i=0; i<3; i++ {
	println(i);
}
i

//使用fuc定义函数，使用: 定义参数及类型，使用->定义返回类型
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

//类中使用deinit()：在对象回收之前的一些清理工作
//类继承及方法重写与C#语法一致，初始化使用init，使用self代表当前类
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

//属性包括：
//1、Stored Property：保存实例的变量或常量值（定义在class和struct中）
struct Fi xedLengthRange {
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

//2、Computed Property：有计算逻辑的属性（定义在class、struct和enum中），只能定义为var
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
//willSet：在值设置前调用
//didSet：在值设置后调用
//如果你不想计算属性值，但仍然想在设置新值前后使用，则使用willSet和didSet
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
enum Card: Int {
	//Swift中的枚举值不会默认为0,1,2...，而是需要手动设置
	//Ace = 1表示枚举的初始值（Raw Value），当初始值为Int时，后面的枚举值会递增赋值
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

//接口定义
//mutating keyword in the declaration of Simpl eStructure to mark a
//method that modifies the structure. The declaration of SimpleClass doesn’t need
//any of its methods marked as mutating because methods on a class can always
//modify the class.
protocol ExampleProtocol {
	var simpleDescription: String {get;}
	mutating func adjust()
}
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

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




