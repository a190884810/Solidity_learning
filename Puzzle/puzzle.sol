pragma solidity >=0.4.22 <0.6.0;

contract Puzzle{
    
    address payable public owner; 
    bool public locked; 
    uint public reward; 
    bytes32 public diff; 
    bytes public solution;

    constructor() public payable { //constructor
        owner = msg.sender;
        reward = msg.value;
        locked = false;
        
        diff = bytes32(0x1111111111111111111111111111111111111111111111111111111111111111); //intermediate conversions
    } 
    

    
    function  init() public payable  { //main code, runs at every invocation 
        if (msg.sender == owner){ //update reward
            if (locked) 
                revert();
            owner.transfer(reward);
            reward = msg.value; 
        }
        else
            if (msg.data.length > 0)
            { 
                //submit a solution
                if (locked) 
                    revert();
                if (sha256(msg.data) < diff)
                {
                    msg.sender.transfer(reward); //send reward 
                    solution = msg.data;
                    locked = true;
                }
                else
                    revert();
            
            }
    
    }
}