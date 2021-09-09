pragma solidity ^0.8.0;

contract Demo{
    
    mapping( uint => User) users;
    
    struct User{
        uint id;
        uint balance;
    }
    
    //addUser
    function addUser(uint id, uint balance) public{
        users[id] = User(id, balance);
    }
    
    //update balance
    function updateBalance(uint id, uint balance) public {
        User storage user = users[id];
        user.balance = balance;
    }
    
    //check balance
    function getBalance(uint id) public view returns(uint){
        return users[id].balance;
    }
}