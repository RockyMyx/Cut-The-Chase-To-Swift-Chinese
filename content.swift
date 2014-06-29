

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


    extension Int: ExampleProtocol {
        var simpleDescription: String {
            return "The number \(self)"
        }
        mutating func adjust() {
            self += 42
        }
    }




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


协议类型可以被集合使用，表示集合中的元素均为协议类型:
let things: TextRepresentable[] = [game,d12,simoTheHamster]
for thing in things {
    println(thing.asText())
}


as?返回一个可选值，当实例遵循协议时，返回该协议类型;否则返回nil
as用以强制向下转型。

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