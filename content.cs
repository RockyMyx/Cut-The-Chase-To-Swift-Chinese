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

//函数可以使用元组返回多个值
func getGasPrices() -> (Double, Double, Double) {
	return (1.00, 2.00, 3.00);
}

//使用...表示可变参数
func sumOf(numbers: Int...) -> Int {
	var sum = 0;
	for num in numbers {
		sum += num
	}
	return sum;
}

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

//函数可以编写为匿名闭包，使用in分隔参数和返回类型
numbers.map({
	(number: Int) -> Int in
	let result = 3* number;
	return result;
})

//更加简洁的闭包：当已知闭包的类型时，比如委托回调，可以忽略参数类型和返回值类型
numbers.map({ number in 3 * number})

//如果闭包是函数的最后一个参数，则可以紧跟括号  ??
sort([1,5,3,12,2]) {$0 > $1}

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
//类继承及方法重写与C#语法一致
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
	
	//定义属性
	var perimeter: Double{
		get {
			return 4.0 * sideLength
		}
		set {
			sideLength = newValue / 4.0
		}
	}
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

//使用enum定义枚举，枚举中可以定义方法
enum Rank: Int {
	//初始值类型设置为1，则后面的枚举值会递增赋值
	//如果不设置或设置字符串会是什么值？
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

//使用struct定义结构体，struct是值类型，class是引用类型

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




