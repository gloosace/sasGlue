sasGlue
=========
A Sas Macro Utility Library

· 什么是sasGlue？
-------------

  sasGlue是一个sas宏代码库，提供各种基础性、通用性的sas宏来辅助用户进行sas编程，是一个sas宏层面的utility库
  
  sasGlue的功能主要包括字符串处理、宏与宏变量管理、各种数据结构、数据集管理、IO控制、日志等
  
· 建议的阅读顺序
----------------

  首次使用者建议按如下顺序阅读：本说明 -> 源代码中的Coding Details -> 源代码中您感兴趣的宏与示例
  
  Coding Details中包括了对sasGlue常用编码习惯、内建数据结构（vars、assigns、obj、array等）的具体说明
  
  源代码包括sasGlue.sas与test文件夹中的测试用例两部分，测试用例按宏类型分类
  
· 如何使用sasGlue？
------------------

  sasGlue.sas文件包括所有说明与源代码，只要直接按F3编译后即可使用，也可以使用%include调用
  
  所有的宏使用两级分类，具体内容请查看代码文件中的目录，使用文本搜索功能搜索相应的类名，即可跳转到相应章节
  
  每个章节开头为总体性的介绍，每个宏的源代码前为该宏的具体介绍

  每个宏都包含对应的测试用例，说明中的 @test_xxxx 表示对应的测试用例文件名，可以在test文件下查找
  
  测试用例同时也是功能示例，对于较复杂的宏可先查看测试用例了解使用方法
  

· sasGlue对OS与SAS环境有哪些要求？
-----------------------------

  sasGlue在windows环境开发，如用于其他操作系统请注意重新测试，已知的差异包括：SAS options参数格式差异，路径格式等
  
  sasGlue绝大部分功能适应所有sas9.2以上版本，个别非核心功能可能有更高版本要求（如：sha256要求sas9.4）
  
  sasGlue所有代码文件基于UTF-8编码


· 使用Glue的注意事项
-----------------
  ！请注意不要与您自己编写的宏发生宏名称冲突
  
  ！请注意不要误操作sasGlue所使用的全局宏变量（以GLUE_开头）
  
  ！请注意运行环境（如：options设置）可能与您的使用习惯不同
  
  ！sasGlue中的一些宏会使用sas临时工作区（WORK）与当前文件夹（执行代码所在的文件夹）
  
  ！在使用sasGlue中的日志功能前，请注意先完成相关SAS Logging Facility的配置，配置方法可参加测试用例
 
· 宏目录
------

### Format Macros 格式宏
#### Format Definition
    各种format/informat定义，所有format将被保存在WORK中并自动引用
#### Format Basic
    format管理宏（不包括format的使用），如：format的检查、载入、复制、卸载、删除等
#### Format Ds
    使用format进行数据操作的宏，如：对ds进行批量格式转换、改变ds附加的显示format等
### FCMP Macros 自定义数据集函数宏
#### Fcmp Definition
    各类数据步函数定义，所有fcmp func将被保存在WORK中并自动引用
#### Fcmp Macros
    fcmp的管理宏，主要包括fcmp lib的导入、注销等
    
### DEV Macros 开发工具宏
#### Log Macros
    日志宏，基于SAS Logging Facility封装的日志
#### Timer Macros
    计时器类宏
#### Debug Macros
    测试宏，如：断言、临时变量的检查等
#### Options Macros
    sas option管理宏，包括option的增加、删除等
    
### Basic 基础宏
#### Math Macros
    各类基本算术处理宏
#### Time Macros
    日期与时间宏;
#### Random Macros
    随机数、随机字符串生成宏;

### String Macros 字符串宏
#### String Format
    字符串格式识别，判定字符串是否具有某种格式，例如：数字、引号内、括号内等
#### String Conversion
    字符串转换，对原字符串进行简单的加工修饰，例如：引用、去除空格、加引号等
#### String Operation
    字符串一般操作宏，例如：搜索、拆入、替换等
#### String Hash
    hash相关操作，例如md5，sha256等
#### String Binary
    二进制字符串操作宏，例如：二进制AND、OR、XOR、转换为base32格式等

### VARS Macros VARS宏
#### Vars Conversion
    将vars转换为SAS中的不同场景适用的格式，例如：a b c转换为sql中的(a,b,c)
#### Vars Position
    基于位置的操作，例如：var计数、提取指定位置var等
#### Vars Matching
    基于内容的操作，例如：查询某个var是否存在、正则表达式识别等
#### Vars Set
    将vars视为集合的操作，例如：集合add、sub、or等
#### Vars Batch Operation
    重复对vars所有元素进行相同处理，例如：添加前后缀、padding等
#### Assigns macros
    assigns类字符串处理宏，提供基于VARS实现的类似map的数据结构

### I/O Macros I/O宏
#### File IO macros
   文件操作宏，例如：包括路径检查、文件夹创建、文件检查、拷贝，xlsx/csv/ds格式相互转换等
#### Ods Macros
    ODS控制与输出宏，提供分级分页的HTML/PDF输出，以及ODS输出参数的管理

### MACRO 自定义宏与宏变量
#### Macro App Macros
    自定义宏管理与编写辅助，例如：获取caller名称、参数检查工具等
#### Macro Variable Macros
    宏变量管理宏，例如：宏变量存在性检查、获取指定scope的宏变量值、批量删除全局宏变量等
#### Plan Macros
    macro批处理宏，根据数据集中记录的参数，批量调用宏进行计算，并将结果回写数据集

### DATASET 数据集宏
#### Ds Basic Macros
    ds基础操作宏，例如：获取lib名称、检查ds是否相同等、获取观测数量等
#### Ds Lib Macros
    ds lib操作宏，例如：lib的载入、拷贝、注销等
#### Ds Operation Macros
    以ds整体为操作对象的宏，例如：拷贝、移动、删除等
#### Ds Index Macros
    ds索引操作宏，例如：索引创建、删除等
#### Ds Var Operation Macros
    以ds中的变量为操作对象的宏，例如：获取变量名、获取变量类型、变量改名、设置变量长度等
#### Ds Obs Macros
    以ds中多个观测为操作对象的宏，例如：obs去重、key计数等
#### Ds Cell Macros
    以ds中的单元（即一个观测的一个变量值）为操作对象的宏，例如：cell写入与读取
#### Multi Ds Macros
    以多个ds为操作对象的宏，例如：合并/merge、过滤/filter、连接/join等

### OBJECT 对象宏
#### Obj Basic Macros
    obj基本操作宏，包括obj的创建、复制、删除、成员增减等
#### Obj Member Macros
    obj成员批量处理宏，对obj所有成员批量进行某一种操作，例如：清空、大写等
#### Obj Ds Macros
    obj与数据集观测间互操作宏，例如：写入、读出
#### Obj Array Macros
    以obj形式为基础实现的数组，例如：数组的创建、pop、push等
