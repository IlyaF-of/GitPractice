// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

 abstract contract MyERC20 is IERC20 {
    uint totalTokens;
    address owner;
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowances;
    string _name;
    string _symbol;
   

    function name() external view returns(string memory) {
        return _name;
    }

    function symbol() external view returns(string memory) {
        return _symbol;
    }

    function decimals() external pure returns(uint) {
        return 18; // 1 token = 1 wei
    }

    function totalSupply() external view returns(uint) {
        return totalTokens;
    }

    modifier enoughTokens(address _from, uint _value) {
        require(balanceOf(_from) >= _value, "not enough tokens!");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not an owner!");
        _;
    }

    constructor(string memory name_, string memory symbol_, uint totalTokens_) {
        _name = name_;
        _symbol = symbol_;
        totalTokens = totalTokens_;
        
    }

    function balanceOf(address account) public view returns(uint) {
        return balances[account];
    }

    function transfer(address to, uint256 value) external returns (bool){
        require(to != address(0), "Zero address!!!");
        require(balances[msg.sender] > value, "Not anouth value!!!");
        balances[msg.sender] -= value;
        balances[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function allowance(address _owner, address spender) public view returns(uint) {
        return allowances[_owner][spender];
    }

    function approve(address spender, uint256 value) external returns (bool){
       require(spender != address(0), "Zero address!!!");
        allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address _from, address to, uint256 value) external returns (bool) {
        require(to != address(0), "Zero address!!!");
        require(balances[_from] > value, "Not anough value");
        require(allowances[_from][to] >= value, "check allowance!");
        allowances[_from][to] -= value; // error!
        balances[_from] -= value;
        balances[to] += value;
        emit Transfer(_from, to, value);
        return true;
    }

    function mint(address account, uint value) internal onlyOwner {
       require(account != address(0), "Zero address");
        balances[account] += value;
        totalTokens += value;
        emit Transfer(address(0), account, value);
    }

    function burn(address account, uint value) internal onlyOwner {
        require(account != address(0), "Zero address");
        balances[account] -= value;
        totalTokens -= value;
        emit Transfer(account, address(0), value);
    }
}
