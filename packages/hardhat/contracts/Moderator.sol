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
        address artContract;   //contract with submissions to vote on
        uint issued;        //possibly limited by related contract 
        uint current;       //balance of votes to cast
        uint voted;         //count of cast votes 
    }

 //mappings
    mapping(address => votes) public Votes;

    //declare contracts
    Vendor public vendor;
    YourToken public yourToken;
    Staker public staker;
    ExampleExternalContract public exampleExternalContract;
    YourCollectible public yourCollectible;

    constructor(address _adrToken, address _adrCollectible, address _adrVendor, address payable _adrStaker, address _adrExternalContract) public payable {
        yourCollectible = YourCollectible(_adrCollectible);
        exampleExternalContract = ExampleExternalContract(_adrExternalContract);
        staker = Staker(_adrStaker);
        yourToken = YourToken(_adrToken);
        vendor = Vendor(_adrVendor);
    }

    //mint collection - *(currently this is manual)

    //issue voting tokens (hearts) to WL 
    function _issueInitialTokens () internal {

    }
    //moderate voting per address
    //- require votes <= max votes
    //- track issued votes

    //hackeysack of WL addresses:
    function _initVotes () internal {

    }

    function _addAddressToVotes (address _address) internal {
        uint issued = vendor.issueTokens(_address);

        votes memory _votes = Votes[_address];
        if(_votes.issued == 0){
            Votes[_address] = votes(_address, issued, issued, 0);
        } else {
            _votes.issued = _votes.issued + issued;
            _votes.current = _votes.current + issued;
            Votes[_address] = _votes;
        }
        
    }
}