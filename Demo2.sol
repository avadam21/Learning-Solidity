// SPDX_license_Identifier: MIT 
pragma solidity ^0.8.0;

contract Demo1{
    address owner;
    
    constructor(){
        owner = msg.sender;
    }
    
    function getOwnerBalance() public view returns(uint){
        return owner.balance;
    }
    
    function getOwnerAddr() public view returns(address){
        return owner;
    }
    
    function getContractBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function getContractAddress() public view returns(address){
        return address(this);
    }
    
    function fund() public payable returns(bool success) {}
}