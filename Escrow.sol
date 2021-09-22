// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


contract Escrow{
    
    enum State {NOT_INITIATED, AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE}
    
    State public currState;
    
    bool public isBuyerIn;
    bool public isSellerIn;
    
    address public buyer;
    address payable public seller;
    
    uint public price;
    
    //constructor
    constructor(address _buyer, address payable _seller, uint _price){
        buyer = _buyer;
        seller = _seller;
        price = _price;
    }
    
    modifier escrowNotStarted(){
        require(currState == State.NOT_INITIATED, "Finish the existing transaction!");
        _;
    }
    
    modifier onlyBuyer(){
        require(msg.sender == buyer, "You are not the buyer!");
        _;
    }
    
    //init. by both buyer and seller 
    // agree => buyer & seller
    function agreeement() public escrowNotStarted{
        if(msg.sender == buyer){
            isBuyerIn = true;
        }
        if(msg.sender == seller){
            isSellerIn = true;
        }
        
        if(isSellerIn && isBuyerIn){
            currState = State.AWAITING_PAYMENT;
        }
    }
    
    
    // deposit => buyer 
    
    function deposit() public payable onlyBuyer{
        
        require(currState == State.AWAITING_PAYMENT, "Already Paid!");
        require(msg.value == price, "Incorrect Value!");
        currState = State.AWAITING_DELIVERY; //at this state payment is done
    }

    // confirmation of delivery => buyer
    
    function confirmDelivery() onlyBuyer payable public{
        
        //state update => delivery
        require(currState == State.AWAITING_DELIVERY, "Cannot confirm delivery");
        
        //send money to seller
        seller.transfer(price);
        
        //sate update => completed
        currState = State.COMPLETE;
        
    }
    
    // withdraw => buyer
    
    function withdraw() onlyBuyer payable public{
        
        require(currState == State.AWAITING_DELIVERY, "Cannot withdraw at this state");
        payable(msg.sender).transfer(price); //send to a/c, who is calling this
        currState = State.COMPLETE;
        
    }
  
}
