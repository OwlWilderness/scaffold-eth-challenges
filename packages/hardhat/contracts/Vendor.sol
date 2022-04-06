pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT


import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./YourToken.sol";
import "./YourCollectible.sol";

//Eth Speed Run 
//Challenge 2 - Token Vendor
//Submitted: 2022Mar28 - first submmission 
//Student:quantumtekh.eth 
//Studen Repo:  https://github.com/OwlWilderness
//Original Source: https://github.com/scaffold-eth/scaffold-eth-challenges/tree/challenge-2-token-vendor
//Clone from Fork: git clone https://github.com/OwlWilderness/scaffold-eth-challenges challenge-2-token-vendor

contract Vendor is Ownable {
  using SafeMath for uint;

  uint256 public constant tokensPerEth = 10000;
  mapping ( address => uint256 ) public issued;

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfETH);

  YourToken public yourToken;
  YourCollectible public yourCollectible;

  constructor(address _address) {
    yourToken = YourToken(_address);
    yourCollectible = YourCollectible(_address);
  }

  function issueTokens(address _address) public returns (uint) {
    //verify tokens can be issued and only issue up to max per address
    uint maxCanIssue = yourCollectible.IssueOnRegisterTokenCount();
    uint issued = issued[_address];
    uint toIssue = (issued <= maxCanIssue) ? (maxCanIssue - issued) : 0 ;    
    require(toIssue > 0, "total issued exceed max tokens for this address");

    //issue tokens to address
    yourToken.transfer(_address, toIssue);

    //return number of issued tokens
    return toIssue;
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    uint256 amountOfTokens = msg.value * tokensPerEth;
    uint256 issued = issued[msg.sender];
    require(issued <= yourCollectible.MaxHeartPerAddressCount(), "total issued exceed max");

    (bool success, ) = address(this).call{value: msg.value}("");
    yourToken.transfer(msg.sender, amountOfTokens);
    emit BuyTokens(msg.sender, msg.value, amountOfTokens);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  //function withdraw() public payable onlyOwner {
  //  (bool success, ) = (msg.sender).call{value: msg.value}("");
  //}

  // ToDo: create a sellTokens() function:
  //function sellTokens(uint256 _amountOfTokens) public payable {
    //I dont understand why I would want to use the full address balance
    // --> address(this).balance <-- or is that magic in the front end
    // with the aproval / send stuff
    //uint256 amountOfETH = address(this).balance; //;(_amountOfTokens / tokensPerEth) * 10 ** 18;
    //yourToken.transferFrom(msg.sender, address(this), _amountOfTokens);
    //(bool success, ) = (msg.sender).call{value: amountOfETH }("");
    //emit SellTokens(msg.sender, _amountOfTokens, amountOfETH);
  //}
}
