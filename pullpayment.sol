// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.11;
 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/access/Ownable.sol";

contract PullPayment {
    
    mapping(address => uint256) private balances;
    
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    
    function withdraw() public payable {
        require(balances[msg.sender] > 0, "No fund to withdraw.");
        
        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Fund transfer failed.");
    }
    
}
