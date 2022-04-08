// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Moderator.sol";

contract YourCollectible is
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage,
    Ownable
{
    //usings
    using Counters for Counters.Counter;

    struct Art{
        uint256 id;
        string uri;
        address collector;
        uint256 hearts;
    }

    //mappings
    mapping(uint => Art) public ArtCollection;
    mapping (uint256 => uint) public ArtConnection;

    //parameters
    Counters.Counter private _tokenIdCounter;
    uint256 public LastMintedIndex = 0;
    uint256 public CollectionCount = 0;

    bool public IssueOnRegister = true;
    uint public IssueOnRegisterTokenCount = 2;
    uint public MaxHeartPerAddressCount = 2;

    function getHearts(uint256 _p04pasId) public view returns (uint256) {
        uint ac = ArtConnection[_p04pasId];
        return ArtCollection[ac].hearts;
    }

    function HeartArt(address _mod, address _address, uint256 _p04pasId, uint256 _voteCount) external {
        //is this safe? an this be called by anyone? not sure if onlyownder is what i want - the requires are in the calling function
        //can I pass in the Moderator address and verify back that way?
        Moderator mod = Moderator(_mod);
        mod.ValidateOkToVote(_address, address(this), _voteCount);

        uint artConnection = ArtConnection[_p04pasId];
        uint hearts = ArtCollection[artConnection].hearts;
        ArtCollection[artConnection].hearts = hearts + _voteCount;
    }
    //

    constructor() ERC721("Poap4PeaceArtSubmission", "P04PAS") {
       _currateArt();
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function getIssueOnRegisterTokenCount() public view returns (uint) {
        return IssueOnRegisterTokenCount;
    }     
    function getLastMintedIndex() public view returns (uint256) {
        return LastMintedIndex;
    }                              

    function mintItem(address to, string memory uri) public returns (uint256) {
        //get current token counter (similar counter in ui)
        uint current = _tokenIdCounter.current();
        
        //sync counter when of browser reset
        if (LastMintedIndex > current) {
            while (LastMintedIndex > current) {
                _tokenIdCounter.increment();
                current = _tokenIdCounter.current();
            }
        }

        //only mint as many submissions in the collection (need to fix/sync ui/sol counter)
        require(current < CollectionCount, "collection minted");

        Art memory token = ArtCollection[current];
        //update artist submission token with uri and collector (who minted)
        //maybe in the future this would actually be the artist address as they submit
        //their own work???
        token.uri = uri;
        token.collector = to;
        ArtCollection[current] = token; 

        //mint and set uri of minted token
        uint256 tokenId = token.id; 
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, token.uri);

        //increment token id counter
        _tokenIdCounter.increment();
        LastMintedIndex =_tokenIdCounter.current();
        return tokenId;
    }

     
    //add the artist ids to the art collection and initialize uri = not minted (valid uri if minted) and collector.
    function _currateArt() internal {
        //ideallly this would be created when a requestor uploads the artist submissions
        //this is also kind of hackish ?
        uint256 initHearts = 1 ;
        ArtCollection[0] = Art(4020101,"not minted", address(this),initHearts);
        ArtConnection[4020101] = 0;
        ArtCollection[1] = Art(4035601,"not minted", address(this),initHearts);
        ArtConnection[4035601] = 1;
        ArtCollection[2] = Art(4130701,"not minted", address(this),initHearts);
        ArtConnection[4130701] = 2;
        ArtCollection[3] = Art(4132501,"not minted", address(this),initHearts);
        ArtConnection[4132501] = 3;
        ArtCollection[4] = Art(4173401,"not minted", address(this),initHearts);
        ArtConnection[4173401] = 4;
        ArtCollection[5] = Art(4173402,"not minted", address(this),initHearts);
        ArtConnection[4173402] = 5;
        ArtCollection[6] = Art(4191101,"not minted", address(this),initHearts);
        ArtConnection[4191101] = 6;
        ArtCollection[7] = Art(4195401,"not minted", address(this),initHearts);
        ArtConnection[4195401] = 7;
        ArtCollection[8] = Art(4232701,"not minted", address(this),initHearts);                                                        
        ArtConnection[4232701] = 8;
        ArtCollection[9] = Art(4232702,"not minted", address(this),initHearts);
        ArtConnection[4232702] = 9;
        ArtCollection[10] = Art(4271001,"not minted", address(this),initHearts);
        ArtConnection[4271001] = 10;
        ArtCollection[11] = Art(4318501,"not minted", address(this),initHearts);
        ArtConnection[4318501] = 11;
        ArtCollection[12] = Art(4451301,"not minted", address(this),initHearts);
        ArtConnection[4451301] = 12;
        ArtCollection[13] = Art(4503501,"not minted", address(this),initHearts);
        ArtConnection[4503501] = 13;
        ArtCollection[14] = Art(4536501,"not minted", address(this),initHearts);
        ArtConnection[4536501] = 14;
        ArtCollection[15] = Art(4605801,"not minted", address(this),initHearts);
        ArtConnection[4605801] = 15;
        ArtCollection[16] = Art(4605802,"not minted", address(this),initHearts);
        ArtConnection[4605802] = 16;
        ArtCollection[17] = Art(4605803,"not minted", address(this),initHearts);
        ArtConnection[4605803] = 17;
        ArtCollection[18] = Art(4684601,"not minted", address(this),initHearts);
        ArtConnection[4684601] = 18;
        ArtCollection[19] = Art(4740801,"not minted", address(this),initHearts);
        ArtConnection[4740801] = 19;
        ArtCollection[20] = Art(4752401,"not minted", address(this),initHearts);
        ArtConnection[4752401] = 20;
        ArtCollection[21] = Art(4771901,"not minted", address(this),initHearts);
        ArtConnection[4771901] = 21;
        ArtCollection[22] = Art(4800201,"not minted", address(this),initHearts);
        ArtConnection[4800201] = 22;
        ArtCollection[23] = Art(4890901,"not minted", address(this),initHearts);
        ArtConnection[4890901] = 23;
        ArtCollection[24] = Art(4890902,"not minted", address(this),initHearts);
        ArtConnection[4890902] = 24;
        ArtCollection[25] = Art(4949901,"not minted", address(this),initHearts);
        ArtConnection[4949901] = 25;
        ArtCollection[26] = Art(4956701,"not minted", address(this),initHearts);
        ArtConnection[4956701] = 26;
        CollectionCount = 27;
    }         

    // The following functions are overrides required by Solidity.
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
