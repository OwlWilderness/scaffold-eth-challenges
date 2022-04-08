pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

//con-troll-er:   greedy imports
import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./YourCollectible.sol";
import "./YourToken.sol";
import "./Vendor.sol";


contract Moderator is Ownable {
    using SafeMath for uint;
    using SafeMath for uint256;
    
    //delcare variables
 
    struct votes{
        address artContract;   //contract with submissions to vote on
        uint issued;        //possibly limited by related contract 
        uint current;       //balance of votes to cast
        uint voted;         //count of cast votes 
        bool registered;    //these votes are registered
    }

 //mappings
    mapping(address => votes) public Votes;
    mapping(address => uint) public wl;

    //declare contracts
    Vendor public vendor;
    YourToken public yourToken;
    YourCollectible public yourCollectible;

    constructor(address _adrToken, address _adrCollectible, address _adrVendor) public payable {
        yourCollectible = YourCollectible(_adrCollectible);
        //exampleExternalContract = ExampleExternalContract(_adrExternalContract);
        //staker = Staker(_adrStaker);
        yourToken = YourToken(_adrToken);
        vendor = Vendor(_adrVendor);

        //set wl of eligible voters
        _initVotesWL();        
    }

    function getVotes(address _address) public view returns (uint, uint, uint){
        votes memory thisVote = Votes[_address];
        return(thisVote.issued, thisVote.current, thisVote.voted);
    }
    //mint collection - *(currently this is manual)

    //issue voting tokens (hearts) to WL 
    function _issueInitialTokens () internal {

    }
    //moderate voting per address
    function Vote(address _address, uint256 _p04pasId, uint _voteCount) public {
        uint current = Votes[msg.sender].current;
        require(current > 0, "know votes to vote");
        require(Votes[msg.sender].artContract == address(yourCollectible),"know your collection");//is this needed?

        //transfer and update heart count
        //this doesnt work and not sure why xfer exceed allowance
        //yourToken.transferFrom(msg.sender, address(yourCollectible), _voteCount);
        yourCollectible.HeartArt(address(this), msg.sender, _p04pasId, _voteCount);

        ////update votes
        Votes[msg.sender].current = current.sub(_voteCount);
        uint voted = Votes[msg.sender].voted;
        Votes[msg.sender].voted = voted.add(_voteCount);
    }
    //- require votes <= max votes - 
    //- track issued votes

    //hackeysack of WL addresses:
    function _initVotesWL() internal {
        
        wl[address(this)] = 1;
        wl[address(yourCollectible)] = 1;
        wl[address(yourToken)] = 1;
        wl[address(vendor)] = 1;
        wl[address(msg.sender)] = 1;
        wl[0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266] = 1;
     }

    
    function ValidateOkToVote(address _address, address _adrCollectible, uint _voteCount) public view {
        require(wl[_address] > 0, "un able to find address");
        votes memory _votes = Votes[_address];
        require(_votes.artContract == _adrCollectible, "un known collection");
        require(_votes.current >= _voteCount, "un know current");
    }

    function Register(address _address) public onlyOwner {
        require(Votes[_address].registered == false, 'already registered');

        votes memory _votes = Votes[_address];
        
        if(_votes.registered == false) {
        //    //redundent iff  
            uint toissue = vendor.issueTokens(_address);
            uint256 issued = vendor.getIssued(_address);

            _votes = votes(address(yourCollectible), issued, issued, 0, true);
            Votes[_address] = _votes;
        }
    }
}