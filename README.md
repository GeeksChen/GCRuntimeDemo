# GCRuntimeDemo
本Demo主要是使用OC的Runtime特性来提高项目的性能和安全性

我们可以运用runtime机制做一些事情，动态的获取类的一些属性和方法，动态添加方法和方法交换。

1、获取类名
动态获取类名，使用class_getName(Class)就可以在运行时来获取类的名称。class_getName()函数返回的是一个char类型的指针，也就是C语言的字符串类型，所以我们要将其转换成NSString类型，然后在返回出去。

```
NSString *className = [GCRuntimeKit fetchClassName:[Test class]];
NSLog(@"获取类名:%@",className);
```

2、获取成员变量
获取类的成员变量，使用ivar_getTypeEncoding()来获取相应成员变量的类型。使用ivar_getName()来获取相应成员变量的名称。
```
NSArray *ivarList = [GCRuntimeKit fetchIvarList:[Test class]];
NSLog(@"获取类成员变量：%@",ivarList);
```
3、获取成员属性
获取有setter和getter方法的成员变量，主要使用class_copyPropertyList(Class,&count)来获取属性列表，然后通过for循环来获取每个属性的名字。注意，使用property_getName()获取到的名字依然是C语言的char类型。
```
NSArray *proList = [GCRuntimeKit fetchPropertyList:[Test class]];
NSLog(@"获取属性列表：%@",proList);
```
4、获取类的实例方法
通过class_copyMethodList()方法获取类的实例方法列表，然后通过for循环使用method_getName()来获取每个方法的名称，然后将方法的名称转换成NSString类型，存储在数组中，并返回。
```
NSArray *methodList = [GCRuntimeKit fetchMethodList:[Test class]];
NSLog(@"获取实例方法：%@",methodList);
```
5、获取协议列表
通过class_copyProtocolList()来获取列表，然后通过for循环使用protocol_getName()来获取协议的名称，最后将其转换成NSString类型放入数组中，并返回。
```
NSArray *protocolList = [GCRuntimeKit fetchProtocolList:[Test class]];
NSLog(@"获取协议列表：%@",protocolList);
```
6、动态添加属性
```
Test *test = [Test new];
test.dynamicAddPro = @"动态添加属性";
```

7、动态添加方法
```
[test performSelector:@selector(addMethod:) withObject:@"动态添加方法"];
```

8、交换方法
```
[test swwingMethod];
[test method1];
```

[简书地址](https://www.jianshu.com/p/30f0d7eb08e4)
