pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

//con-troll-er:   greedy imports
import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./YourCollectible.sol";
import "./ExampleExternalContract.sol";
import "./Staker.sol"; 
import "./YourToken.sol";
import "./Vendor.sol";


contract Moderator  {
    //delcare variables
 
    struct votes{
        address contract;   //contract with submissions to vote on
        uint issued;        //possibly limited by related contract 
        uint current;       //balance of votes to cast
        uint voted;         //count of cast votes 
    }

 //mappings
    mapping (address => votes) public Votes;

    //declare contracts
    Vendor public vendor;
    YourToken public yourToken;
    Staker public staker;
    ExampleExternalContract public exampleExternalContract;
    YourCollectible public yourCollectible;

    constructor(address _adrToken, address _adrCollectible, address _adrVendor, address payable _adrStaker, address _adrExternalContract) public {
        yourCollectible = YourCollectible(_adrCollectible);
        exampleExternalContract = ExampleExternalContract(_adrExternalContract);
        staker = Staker(_adrStaker);
        yourToken = YourToken(_adrToken);
        vendor = Vendor(_adrVendor);
    }

    //mint collection - *(currently this is manual)

    //issue voting tokens (hearts) to WL 
    function 
    //moderate voting per address
    //- require votes <= max votes
    //- track issued votes
}