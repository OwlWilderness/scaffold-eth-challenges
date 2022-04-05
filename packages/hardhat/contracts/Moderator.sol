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

    uint public maxHeartsPerAddresss = 5;

    mapping(uint => Art) public ArtCollection;
    mapping (uint256 => uint) public ArtConnection;

    Vendor public vendor;
    YourToken public token;
    Staker public staker;
    ExampleExternalContract public exampleExternalContract;
    YourCollectible public collectible;

    struct Art{
        uint256 id;
        string uri;
        address collector;
        uint256 hearts;
    }

    constructor(address _adrToken, address _adrCollectible, address _adrVendor, address payable _adrStaker, address _adrExternalContract) public {
        collectible = YourCollectible(_adrCollectible);
        exampleExternalContract = ExampleExternalContract(_adrExternalContract);
        staker = Staker(_adrStaker);
        token = YourToken(_adrToken);
        vendor = Vendor(_adrVendor);

        _currateArt()
    }

     //add the artist ids to the art collection and initialize uri = not minted (valid uri if minted) and collector.
    function _currateArt() internal {
        //ideallly this would be created when a requestor uploads the artist submissions
        //this is also kind of hackish ?
        ArtCollection[0] = Art(4020101,"not minted", address(exampleExternalContract),1);
        ArtConnection[4020101] = 0;
        ArtCollection[1] = Art(4035601,"not minted", address(exampleExternalContract),1);
        ArtConnection[4035601] = 1;
        ArtCollection[2] = Art(4130701,"not minted", address(exampleExternalContract),1);
        ArtConnection[4130701] = 2;
        ArtCollection[3] = Art(4132501,"not minted", address(exampleExternalContract),1);
        ArtConnection[4132501] = 3;
        ArtCollection[4] = Art(4173401,"not minted", address(exampleExternalContract),1);
        ArtConnection[4173401] = 4;
        ArtCollection[5] = Art(4173402,"not minted", address(exampleExternalContract),1);
        ArtConnection[4173402] = 5;
        ArtCollection[6] = Art(4191101,"not minted", address(exampleExternalContract),1);
        ArtConnection[4191101] = 6;
        ArtCollection[7] = Art(4195401,"not minted", address(exampleExternalContract),1);
        ArtConnection[4195401] = 7;
        ArtCollection[8] = Art(4232701,"not minted", address(exampleExternalContract),1);                                                        
        ArtConnection[4232701] = 8;
        ArtCollection[9] = Art(4232702,"not minted", address(exampleExternalContract),1);
        ArtConnection[4232702] = 9;
        ArtCollection[10] = Art(4271001,"not minted", address(exampleExternalContract),1);
        ArtConnection[4271001] = 10;
        ArtCollection[11] = Art(4318501,"not minted", address(exampleExternalContract),1);
        ArtConnection[4318501] = 11;
        ArtCollection[12] = Art(4451301,"not minted", address(exampleExternalContract),1);
        ArtConnection[4451301] = 12;
        ArtCollection[13] = Art(4503501,"not minted", address(exampleExternalContract),1);
        ArtConnection[4503501] = 13;
        ArtCollection[14] = Art(4536501,"not minted", address(exampleExternalContract),1);
        ArtConnection[4536501] = 14;
        ArtCollection[15] = Art(4605801,"not minted", address(exampleExternalContract),1);
        ArtConnection[4605801] = 15;
        ArtCollection[16] = Art(4605802,"not minted", address(exampleExternalContract),1);
        ArtConnection[4605802] = 16;
        ArtCollection[17] = Art(4605803,"not minted", address(exampleExternalContract),1);
        ArtConnection[4605803] = 17;
        ArtCollection[18] = Art(4684601,"not minted", address(exampleExternalContract),1);
        ArtConnection[4684601] = 18;
        ArtCollection[19] = Art(4740801,"not minted", address(exampleExternalContract),1);
        ArtConnection[4740801] = 19;
        ArtCollection[20] = Art(4752401,"not minted", address(exampleExternalContract),1);
        ArtConnection[4752401] = 20;
        ArtCollection[21] = Art(4771901,"not minted", address(exampleExternalContract),1);
        ArtConnection[4771901] = 21;
        ArtCollection[22] = Art(4800201,"not minted", address(exampleExternalContract),1);
        ArtConnection[4800201] = 22;
        ArtCollection[23] = Art(4890901,"not minted", address(exampleExternalContract),1);
        ArtConnection[4890901] = 23;
        ArtCollection[24] = Art(4890902,"not minted", address(exampleExternalContract),1);
        ArtConnection[4890902] = 24;
        ArtCollection[25] = Art(4949901,"not minted", address(exampleExternalContract),1);
        ArtConnection[4949901] = 25;
        ArtCollection[26] = Art(4956701,"not minted", address(exampleExternalContract),1);
        ArtConnection[4956701] = 26;
        CollectionCount = 27;
    }                

}