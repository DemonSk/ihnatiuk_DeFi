pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DSStorage {

    address public immutable _token;

    address private _owner;

    mapping (address => uint256) private _ethBalances;
    mapping (address => uint256) private _tokenBalances;

    constructor(address token, address owner) {
        _token = token;
        _owner = owner;
    }

    function depositToken(uint256 amount) public returns (bool) {
        IERC20(_token).transferFrom(msg.sender, address(this), amount);
        _tokenBalances[msg.sender] += amount;
        return true;
    }

    function withdrawToken(uint256 amount) public returns (bool) {
        _tokenBalances[msg.sender] -= amount;
        IERC20(_token).transfer(msg.sender, amount);
        return true;
    }

    function getTokenBalance() public view returns (uint256) {
        return _tokenBalances[msg.sender];
    }

    function updateTokenBalance(address target, uint256 balance) public returns (bool) {
        require(msg.sender == _owner, "Method allowed only for owner");
        _tokenBalances[target] = balance;
        return true;
    }

    function depositETH() public payable returns (bool) {
        _ethBalances[msg.sender] += msg.value;
        return true;
    }

    function withdrawETH(uint256 amount) public returns (bool) {
        _ethBalances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        return true;
    }

    function getETHBalance() public view returns (uint256) {
        return _ethBalances[msg.sender];
    }
}