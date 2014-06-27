1、String
判断String是否为空
someString.isEmpty();

计算String长度使用countElements(countElements以Unicode字符统计长度，在Objective-C中NSString的length方法则是以UTF-16方式，所以两者的结果会不同,在Swift中对应NSString中的length方法，需要使用uft16count方法)
xx.countElements()

String的hasPrefix和hasSuffix方法可以进行字符串的逐字匹配，判断其是否以某些字符开始或结束（相当于C#中的StartWith和Endwith）
let hello = "hello"
hello.hasPrefix("h")
hello.hasSuffix("x")

String的大小写转换使用uppercaseString和lowercaseString属性
let normal = "hello,world";
let upperNormal = normal.uppercaseString
let lowerNormal = normal.lowercaseString

String转Int可以使用toInt()方法，但是由于转换可能不成功，如"hello".toInt()，所以转换的结果是Int?

2、Array
获得数组元素个数使用count方法

判断数组是否为空使用isEmpty属性

添加数组元素使用append方法，或者直接使用+=，+=后不仅可以跟数组对应类型的值，也可以直接跟一个同类型的数组
var zeroDoubles = [0.0, 0.0, 0.0]
var anotherDoubles = [2.5, 2.5, 2.5]
var sixDoubles = zeroDoubles + anotherDoubles; //[0.0, 0.0, 0.0, 2.5, 2.5, 2.5]

可以使用...操作符批量替换数组中的元素，且替换的数量可以和边界表示的数量不一致
var list = [1,2,3,4,5,6,7,8,9]
list[2...5] = [10] //list = [1,2,10,7,8,9]

获取数组最后一个位置索引使用endIndex属性

在数组的某个位置插入元素
list.insert(10, atIndex: 0);

在数组的某个位置移除元素，并返回该元素
list.removeAtIndex(0);

//移除数组的最后一个元素，并返回该元素，相对于removeAtIndex可以避免获取数组的长度，效率更高，相应地还有removeFirst
list.removeAtLast(0);

遍历数组时如果想同时获取元素的索引则可以使用enumerate方法
for(index, value) in enumerate(list) {
	println("Item \(index) : \(value)");
}

强制数组进行复制使用copy方法

	var names = ["Mohsen",  "Hilary",  "Justyn",  "Amy",  "Rich",  "Graham",  "Vic"]
	var copiedNames = names.copy()
	copiedNames[0] = "Mo"
	println(names[0]) //"Mohsen"

如果要确保数组内容引用的唯一性，则使用unshare

copy方法总是会复制数组，即使在数组已经使用unshare的情况下

3、Dictionary
修改字典中特定键所对应的值：updateValue(forKey:)，当键存在时可以更新值，否则为字典创建一个键值
dict.updateValue(5, forKey:"a"); //返回类型为可空值类型，如键对应没有值则为nil，本例为1

两种方法移除字典中的某个键值对
dict["a"] = nil;
dict.removeValueForKey("a")