// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

//Staker contract
//Eth Speed Run Challenge 1
//Student: quantumtekh.eth
//Submitted: 2022Mar23 - second submmission 
//Source: https://github.com/scaffold-eth/scaffold-eth-challenges/tree/challenge-1-decentralized-staking

contract Staker {
  event Stake(address indexed _address, uint256 _value);

  mapping ( address => uint256 ) public balances;

  uint256 public constant threshold = 1 ether;
  uint256 public deadline = block.timestamp + 72 hours;
  bool internal openForWithdraw; 

  ExampleExternalContract public exampleExternalContract;

  constructor(address exampleExternalContractAddress) public {
      exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }

  //allow deadline to be reset
  function resetDeadline(uint256 _deadLine) public {
      require(_deadLine >= block.time)
      deadline = _deadLine;
  }

  // Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
  //  ( make sure to add a `Stake(address,uint256)` event and emit it for the frontend <List/> display )
  function stake() public payable {
     balances[msg.sender] = msg.value;
     (bool success, ) = address(exampleExternalContract).call{value: msg.value}("");
     emit Stake(msg.sender, msg.value);
  }

  // After some `deadline` allow anyone to call an `execute()` function
  //  It should either call `exampleExternalContract.complete{value: address(this).balance}()` to send all the value
  function execute() external notCompleted payable {
    require(block.timestamp > deadline, "Staker deadline not met.");
    if (address(this).balance >= threshold) {
      exampleExternalContract.complete{value: address(this).balance}();
    } else {
       // if the `threshold` was not met, allow everyone to call a `withdraw()` function
      openForWithdraw = true;
    }

  }

  
  // Add a `withdraw(address payable)` function lets users withdraw their balance
  function withdraw(address payable _address) external notCompleted {
    require (openForWithdraw, "Not yet open for withdraw.");
    (bool success, ) = _address.call{value: balances[msg.sender]}("");
    balances[msg.sender] = 0;
  }

  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend
  function timeLeft() public view returns (uint256) {
    if (block.timestamp >= deadline) {
      return 0;
    }
    return (deadline - block.timestamp);
  }

  // Add the `receive()` special function that receives eth and calls stake()
  receive() external payable {
    stake();
  }

  //verify the contract is not already complete when executing and withdrawing
  modifier notCompleted() {
    require(!exampleExternalContract.completed(), "Contract already complete.");
    _;
  }

}
