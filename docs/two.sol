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