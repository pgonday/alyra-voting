pragma solidity ^0.5.12;

// #### --> manque import safemath

contract Crowdsale {
   using SafeMath for uint256;
 
   address public owner; // the owner of the contract
   address public escrow; // wallet to collect raised ETH // #### --> manque payable
   uint256 public savedBalance = 0; // Total amount raised in ETH
   mapping (address => uint256) public balances; // Balances in incoming Ether
 
   // Initialization
   function Crowdsale(address _escrow) public{  // #### -> plutôt un construteur
       owner = tx.origin; // #### --> msg.sender à la place de tx.origin
       // add address of the specific contract
       escrow = _escrow;
   }
  
   // function to receive ETH
   function() public { // #### --> remplacer functtion par receive, + payable
       balances[msg.sender] = balances[msg.sender].add(msg.value);
       savedBalance = savedBalance.add(msg.value);
       escrow.send(msg.value);
   }
  
   // refund investisor
   function withdrawPayments() public{
       address payee = msg.sender; // #### --> manque payable
       uint256 payment = balances[payee];
 
       payee.send(payment);
 
        // #### --> cette partie devrait être avant le send (réentrance)
       savedBalance = savedBalance.sub(payment);
       balances[payee] = 0;
   }
}
