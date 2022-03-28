// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract YourCollectible is
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage,
    Ownable
{
    using Counters for Counters.Counter;

    mapping(uint256 => Art) public artCollection;

    Counters.Counter private _tokenIdCounter;
    uint256 public LastMintedIndex = 0;

    struct Art{
        uint id;
        string uri;
        address collector;
    }

    constructor() ERC721("Poap4PeaceArtSubmission", "P04PAS") {
         _currateArt();
        
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    //add the artist ids to the art collection and initialize uri = not minted (valid uri if minted) and collector.
    function _currateArt() internal {
        //ideallly this would be created when a requestor uploads the artist submissions
        //this is also kind of hackish ?
        artCollection[0] = Art(4020101,"not minted", address(this));
        artCollection[1] = Art(4035601,"not minted", address(this));
        artCollection[2] = Art(4130701,"not minted", address(this));
        artCollection[3] = Art(4132501,"not minted", address(this));
        artCollection[4] = Art(4173401,"not minted", address(this));
        artCollection[5] = Art(4173402,"not minted", address(this));
        artCollection[6] = Art(4191101,"not minted", address(this));
        artCollection[7] = Art(4195401,"not minted", address(this));
        artCollection[8] = Art(4232701,"not minted", address(this));                                                        
        artCollection[9] = Art(4232702,"not minted", address(this));
        artCollection[10] = Art(4271001,"not minted", address(this));
        artCollection[11] = Art(4318501,"not minted", address(this));
        artCollection[12] = Art(4451301,"not minted", address(this));
        artCollection[13] = Art(4503501,"not minted", address(this));
        artCollection[14] = Art(4536501,"not minted", address(this));
        artCollection[15] = Art(4605801,"not minted", address(this));
        artCollection[16] = Art(4605802,"not minted", address(this));
        artCollection[17] = Art(4605803,"not minted", address(this));
        artCollection[18] = Art(4684601,"not minted", address(this));
        artCollection[19] = Art(4740801,"not minted", address(this));
        artCollection[20] = Art(4752401,"not minted", address(this));
        artCollection[21] = Art(4771901,"not minted", address(this));
        artCollection[22] = Art(4800201,"not minted", address(this));
        artCollection[23] = Art(4890901,"not minted", address(this));
        artCollection[24] = Art(4890902,"not minted", address(this));
        artCollection[25] = Art(4949901,"not minted", address(this));
        artCollection[26] = Art(4956701,"not minted", address(this));
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

        Art memory token = artCollection[current];

        //update artist submission token with uri and collector (who minted)
        //maybe in the future this would actually be the artist address as they submit
        //their own work???
        token.uri = uri;
        token.collector = to;
        artCollection[current] = token; 

        //mint and set uri of minted token
        uint256 tokenId = token.id; 
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, token.uri);

        //increment token id counter
        _tokenIdCounter.increment();
        LastMintedIndex =_tokenIdCounter.current();
        return tokenId;
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
