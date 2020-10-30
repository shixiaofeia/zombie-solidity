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