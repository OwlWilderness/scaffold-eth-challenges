pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

contract ExampleExternalContract {

  bool public completed;

  function complete() public payable {
    //the payable allows the calling function to add {value: uint256} before the ()
    completed = true;
  }

}