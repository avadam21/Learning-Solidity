// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Lottery{
    address owner;
    address payable[] public participants;
    uint256 public totalParticipants;

//assign owner to contract deployer

constructor(){
    owner = msg.sender;
    totalParticipants = 0;
}

//owner can pick winner - owner modifier

modifier onlyOwner(){
    require(msg.sender == owner, "Only Owner can pick the winner!");
    _;
}

//owner cannot participate - not a owner modifier

modifier notOwner(){
    require(msg.sender != owner, "Owner cannot Participate");
    _;
}

//To participate min invest 10

function participate() public payable notOwner{
    if(msg.value != 10){
        revert("Amount should be equal to 10 wei");
    }
    else{
        totalParticipants++;
        participants.push(payable(msg.sender));
    }
}

//get contract balance

function getContractBalance() public view returns(uint256){
    return address(this).balance; //account balance
}

//get winnner balance

function getAddressBalance(uint256 _index) public view returns(uint256){
    return participants[_index].balance;
}

//view participants

function getParticipants() public view returns(address payable[] memory){
    return participants;
}

//random generator 
//parameters from keccak can be different
function random() private view returns(uint256){
    return 
        uint256(
            keccak256(abi.encode(block.difficulty, block.timestamp, participants)) //special variables
        );
}

//pick winner

function winner() public onlyOwner returns (uint256 winnerIndex){
    uint256 index = random() % participants.length; //to find winner index
    participants[index].transfer(address(this).balance); //transfer contract balacne to winner index
    return index;
}

//start again 
function reset() public{
    participants = new address payable[](0); // start arrat from blank once the winnner is declared
    totalParticipants = 0;
    }
}
