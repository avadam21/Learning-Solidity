//SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract demo2{
    uint[] public Array1 = [10, 20, 30];
    
    string[] public Array2 = ["val1", "val2", "val3"];
    
    uint[][] public Array3 = [[11, 22, 33],
                              [44, 55, 66]];
                              
    string[] public values;
    
    function addValue(string memory _value) public{
        values.push(_value);
    }
    
    function valueLen() public view returns(uint){
        return values.length;
    }
}