// SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

contract ERC20{
    uint256 public totalSupply;
    string public name;
    string public symbol;

    mapping(address=>uint256) public balanceOf;
    mapping(address=>mapping(address=>uint256)) public allowance;

    constructor(string memory name_,string memory symbol_){
        name=name_;
        symbol=symbol_;
    }

    function  transfer(address recipient,uint256 amount) external returns (bool){
        return _transfer(msg.sender,recipient,amount);
    }

    function transferFrom(address sender,address recipient,uint256 amount) external returns (bool){
        uint256 currentAllowance=allowance[sender][msg.sender];

        require(currentAllowance>=amount, "ERC20: transfer exceeds balance");
        allowance[sender][msg.sender]=currentAllowance-amount;
        return _transfer(sender,recipient,amount);
    }

    function approve(address spender,uint256 amount) external returns(bool){
        require(spender!=address(0),"transfer goes to zero address");
        allowance[msg.sender][spender]=amount;
        return true;
    }

    function _transfer(address sender,address recipient,uint256 amount) private returns(bool){
        require(recipient !=address(0),"ERC20: transfer goes to zero address");

        uint256 currentBalance=balanceOf[sender];
        require(currentBalance>=amount,"ERC20: transfer exceeds balance");

        balanceOf[sender]=currentBalance-amount;
        balanceOf[recipient]+=amount;

        return true;
    }

}