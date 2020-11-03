# Solidity笔记-快速入门
## 前言
Solidity 的代码都包裹在合约里面. 一份合约就是以太币应用的基本模块， 所有的变量和函数都属于一份合约, 它是你所有应用的起点

## 示例代码
> 先简单写一份存储用户信息的合约, 然后里面基本覆盖了solidity的基础语法

> owner.sol
```solidity
pragma solidity ^0.4.19;

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev The Ownable constructor sets the original `owner` of the contract to the sender
     * account.
     */
    function Ownable() public {
        owner = msg.sender;
    }


    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }


    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param newOwner The address to transfer ownership to.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0));
        OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

}

```

> hello.sol

```solidity
pragma solidity ^0.4.19;
import "./owner.sol";


// @dev HelloWord 继承 OwnerAble合约, 可以调用内部的函数
contract HelloWord is Ownable {
    // 使用SafeMath库, 防止uint溢出
    using SafeMath for uint;

    // 最大年龄限制
    uint maxAge = 180;
    // 自增id
    uint incrId = 0;
    // 添加用户事件, 前端可以监听此事件
    event NewUser(uint _id, string _name);

    // 用户结构体
    struct User {
        string name;
        uint8 age;
        string[] tags;
        uint id;
        uint createTime;
    }

    // 用户字典
    mapping(address => User) userMap;
    mapping(uint => address) addressMap;

    // @dev setMaxAge 修改最大年龄限制-仅合约创建人
    function setMaxAge(uint _age) private onlyOwner {
        maxAge = _age;
    }

    // @dev createUser 创建用户信息
    function createUser(string _name, uint8 _age, string[] tags) public {
        // 判断年龄不能超过限制
        require(_age <= maxAge);
        // 默认添加china标签
        tags.push("china");
        incrId=incrId.add(1);
        userMap[msg.sender] = User(_name, _age, tags, incrId, now);
        addressMap[incrId] = msg.sender;
        NewUser(incrId, _name);
    }

    // @dev getUserInfo 获取用户信息
    function getUserInfo() public view returns (User) {
        return userMap[msg.sender];
    }

    // @dev getUserInfoById 通过id获取指定用户信息
    function getUserInfoById(uint _id) public view returns (User) {
        address userAddr = addressMap[_id];
        return userMap[userAddr];
    }

    // @dev isUserByTag 用户是否具有标签
    function isUserByTag(string _tag) public view returns (bool) {
        // 声明临时数组
        string[] memory tagList = new string[](userMap[msg.sender].tags);
        bool b = false;
        for (uint i = 0; i < tagList.length; i++) {
            // solidity中没有字符串直接比较的方法, 所以需要先用keccak256计算哈希再比对
            if (keccak256(_tag) == keccak256(tagList[i])) {
                b = true;
                break;
            }
        }
        return b;
    }
}


/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}
```

这里简单实现了一份存储用户信息数据的合约, 旨在熟悉一下solidity的语法;

## 名词解释

### 函数可见性修饰词
> 可以看到函数后面会跟 public/private 等关键词, 旨在描述函数的可见性, 即调用权限;
```
private  私有的, 意味着它只能被合约内部调用；
internal 内部的, 只能被合约和继承的子合约调用； 
external 外部的, 只能从合约外部调用；
public   公共的, 可以在任何地方被调用;
```

### 函数状态修饰词
> 描述函数的对区块链的操作状态
```
view 告诉我们运行这个函数不会更改和保存任何数据,只读； 
pure 告诉我们这个函数不但不会往区块链写数据，它甚至不从区块链读取数据;
constant 函数指定constant与view意义相同, 状态变量指定则代表编译时必须赋值;
payable 交易函数, 可以使用 msg.value接受以太币(msg.address是调用者地址);
```

### 继承
> 合约可以继承多个合约, 继承后可以调用父级的内部公用函数, 语法如下
```
contract 子 is 父, 父 {
}
```

### 时间函数
> 内置的时间函数, 可以直接对变量赋值
```
now  返回当前最新时间戳
seconds 秒
minutes 分钟
hours 小时
days 天
weeks 周
年 years
```
> 例
```
uint nowTime = now;
uint tomorrow = now + 1 days;
```

### 参数存储
> 参数存储类型
```
memory  储存在内存里, 函数结束即销毁, 不消耗gas;
storage 永久储存在区块链上, 消耗gas;
```
函数之外声明的变量默认为storage, 函数内的默认为memory;
处理函数内的 结构体 和 数组 时需要手动声明;

### 事件
> 事件 是合约和区块链通讯的一种机制, 利用event关键词声明
```
event NewUser(uint _id, string _name);
```

### 构造函数
> 构造函数用于初始化合约的状态变量, 一个合约只能有一个构造函数, 可以用于合约同名的函数/constructor关键词声明
```
constructor() public {
    owner = msg.sender;
}
```

### 自定义修饰符
> 主要是用来校验参数, 跟函数格式一样, 用modifier关键词声明
```
modifier onlyOwner() {
    require(msg.sender = owner);
    _;
}
```
执行到_;语句时, 程序会返回执行函数的代码;

### 库
> 封装公用方法, 使用using关键词调用, 使用library关键词声明

### 注释
> 大多数时候只需要写dev注释就好了
```
@title  标题; 
@author 作者;
@notice 须知, 向用户解释这个方法或者合约是做什么的;
@dev    是向开发者解释更多的细节;
@param  参数; 
@return 返回值;
```

### 错误处理
> 主要用于判断错误
```
require()  主要验证用户输入和状态条件, 会返还剩余gas, 一般在开头使用;
assert()   主要验证结果和不应该发生的条件, 不会返还gas, 一般在结尾使用;
```

### indexed 
> 事件参数关键词, 可以过滤日志查找关键词数据, 而不是获取所有日志

在事件函数中，最多三个参数可以接收索引的属性，该参数将使各自的参数视为日志主题而不是数据。事件签名的哈希值始终是主题之一。所有未索引的参数将存储在日志的数据部分中。

### super
> 使用super关键字, 调用的方式属于当前父合约中的函数

## 推荐学习网站
编游戏的同时学习以太坊 DApp 开发, 实现以太坊 erc721(强推👍)
> https://cryptozombies.io/zh/ 

相关教程文档地址
> https://solidity-cn.readthedocs.io/zh/develop/index.html

> https://www.qikegu.com/docs/4813