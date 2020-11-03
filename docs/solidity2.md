# Solidity笔记-合约间的互相调用
## 前言
合约间偶尔也有需要互相调用的场景, 跟Go的接口声明挺像的

## 示例代码

> 调用加密猫和usdt的合约, 分别获取加密猫信息和usdt余额

```
pragma solidity ^0.4.19;

contract KittyInterface {
    /// @notice Returns all the relevant information about a specific kitty.
    /// @param _id The ID of the kitty of interest.
    function getKitty(uint256 _id)
    external
    view
    returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract TetherInterface {
    function balanceOf(address who) public constant returns (uint);
}

contract HelloWord {
    KittyInterface kittyContract;
    TetherInterface tetherContract;

    function HelloWord(address _kittyAddress, address _tetherAddress) {
        kittyContract = KittyInterface(_kittyAddress);
        tetherContract = TetherInterface(_tetherAddress);
    }

    // @dev getKittyInfo 获取加密猫的信息
    function getKittyInfo(uint256 _id) public returns (bool) {
        bool isReady;
        (,isReady,,,,,,,,) = kittyContract.getKitty(_id);
        return isReady;
    }
    // @dev getTetherBalance 获取usdt余额
    function getTetherBalance(address who) public returns (uint) {
        return tetherContract.balanceOf(who);
    }
}

```

声明对应的interface合约接口, 然后通过合约地址初始化调用就可以了

## 资料

### 加密猫合约代码
> https://cn.etherscan.com/address/0x06012c8cf97bead5deae237070f9587f8e7a266d#code

### usdt合约代码
> https://cn.etherscan.com/address/0xdac17f958d2ee523a2206206994597c13d831ec7#code