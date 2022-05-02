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

    //events
    event HeartArtEvent(address, votes);
    event RegisterEvent(address, votes);

    //declare contracts
    Vendor public vendor;
    YourToken public yourToken;
    YourCollectible public yourCollectible;


    constructor(address _adrToken, address _adrCollectible, address _adrVendor) public payable {
        yourCollectible = YourCollectible(_adrCollectible);
        yourToken = YourToken(_adrToken);
        vendor = Vendor(_adrVendor);

        //set wl of eligible voters
        _initVotesWL();        
    }

    function getVotes(address _address) public view returns (uint, uint, uint){
        votes memory thisVote = Votes[_address];
        return(thisVote.issued, thisVote.current, thisVote.voted);
    }

    function myHearts() public view returns (uint) {
        return Votes[msg.sender].current;
    }

    //mint collection - *(currently this is manual)

    //moderate voting per address
    function Vote(uint256 _p04pasId, uint _voteCount) public onlyWl {
        uint current =  myHearts();
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
        emit HeartArtEvent(msg.sender, Votes[msg.sender]);
    }
    //- require votes <= max votes - 
    //- track issued votes

    //hackeysack of WL addresses:
    function _initVotesWL() internal {     
        _addWl(address(this));
        _addWl(address(yourCollectible));
        _addWl(address(yourToken));
        _addWl(address(vendor));
        _addWl(address(msg.sender));
        _addWl(0x7F68704858CB70dF2cdDF8cF1bAb8Ec5708B023d);
        _addWl(0x0a5D50420626F4AC60939A04bC4f3e3781dCF1a8);
        _addWl(0xa2a858f76e4e53e5cf64d8BB38d164F128062e5d);
        _addWl(0xc90Ecdf38215b20f4CE7A8A1346E32F78cC3B909);
    }

    function _addWl (address _address) internal {
        wl[_address] = 1;
    }

    function AddWL (address _address) public onlyOwner {
        _addWl(_address);
    }
    
    modifier onlyWl() {
        require(wl[msg.sender] > 0, "hmm... unsure of that address");
        _;
    }

    function ValidateOkToVote(address _address, address _adrCollectible, uint _voteCount) public view onlyWl {
        //require(wl[_address] > 0, "un able to find address");
        votes memory _votes = Votes[_address];
        require(_votes.artContract == _adrCollectible, "un known collection");
        require(_votes.current >= _voteCount, "un know current");
    }

    function Register() public  {
        votes memory _votes = Votes[msg.sender];
        require(Votes[msg.sender].registered == false, 'already registered');
        require(vendor.issueTokens(msg.sender) > 0, '"total issued exceed max tokens for this address');
        if(wl[msg.sender] == 0) {
            _addWl(msg.sender);
        }

        uint256 issued = vendor.getIssued(msg.sender);
        _votes = votes(address(yourCollectible), issued, issued, 0, true);
        Votes[msg.sender] = _votes;
        emit RegisterEvent(msg.sender, _votes);
    }
}