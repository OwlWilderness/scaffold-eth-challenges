pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

//Staker contract
//Eth Speed Run 
//Challenge 2 - Token Vendor
//Submitted: 2022Mar23 - first submmission 
//Student:quantumtekh.eth 
//Studen Repo:  https://github.com/OwlWilderness
//Original Source: https://github.com/scaffold-eth/scaffold-eth-challenges/tree/challenge-2-token-vendor
//Clone from Fork: git clone https://github.com/OwlWilderness/scaffold-eth-challenges challenge-2-token-vendor

contract Vendor is Ownable {
  uint256 public constant tokensPerEth = 100;
  
  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfETH);

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    uint256 amountOfTokens = msg.value * tokensPerEth;
    (bool success, ) = address(this).call{value: msg.value}("");
    yourToken.transfer(msg.sender, amountOfTokens);
    emit BuyTokens(msg.sender, msg.value, amountOfTokens);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw() public payable onlyOwner {
    (bool success, ) = (msg.sender).call{value: msg.value}("");
  }

  // ToDo: create a sellTokens() function:
  function sellTokens(uint256 _amountOfTokens) public payable {
    //I dont understand why I would want to use the full address balance
    // --> address(this).balance <-- or is that magic in the front end
    // with the aproval / send stuff
    uint256 amountOfETH = address(this).balance; //;(_amountOfTokens / tokensPerEth) * 10 ** 18;
    yourToken.transferFrom(msg.sender, address(this), _amountOfTokens);
    (bool success, ) = (msg.sender).call{value: amountOfETH }("");
    emit SellTokens(msg.sender, _amountOfTokens, amountOfETH);
  }
}
