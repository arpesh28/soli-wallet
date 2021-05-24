pragma solidity ^0.8.4;

import "./Allowance.sol";

contract SimpleWallet is Allowance {
    
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllower(_amount) {
        require(_amount<= address(this).balance, "There are not enough funds in the smart contract.");
        if(!isOwner())  {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }
    
    fallback () external payable {
        
    }
    receive () external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
    
}