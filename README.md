# 🏗 scaffold-eth | 🏰 BuidlGuidl

## 🚩 Extension of Challenge 0 & 2: 🎟 Vote for YourCollectible with Your Token 🤓

🎫 This NFT voting applicaiton was created from a fork of the first three Speed Run Ethereum challenges on scaffold-eth. 

🌟 The final deliverable is an app that lets users vote on NFTs. 
---

The initial challenges are at [SpeedRunEthereum.com](https://speedrunethereum.com)!

💬 If you have not you can join the telegram [Challenge 0 telegram](https://t.me/+Y2vqXZZ_pEFhMGMx)!!!

## Note - long initial load time ***

##
Test on Rinkeby: https://poap4peace-heart-v01.surge.sh/
 
## Source
Original Source: https://github.com/scaffold-eth/scaffold-eth-challenges
> Forked Source: https://github.com/OwlWilderness/scaffold-eth-challenges/tree/forest

## Thanks
Thank you to POAPAthon Lowenphast#3449 for taking the time and providing feedback on the application.

### Contracts (From Challenge)
* > YourCollectible - (Challenge 0) : POAP for PEACE Artist Submissions (P04PAS) https://rinkeby.etherscan.io/address/0x216eec15617fB82E83f7eEf08Ea11Bd6F226AACF#code
* > YourToken - (Challege 2) : HEART token used to vote https://rinkeby.etherscan.io/address/0x846D7e0a8b54Cc818bE71d3D3a4fC5e71362d7f5#code
* > Vendor - (Challenge 2) : Hold and Issue HEART tokens (currently no cost) https://rinkeby.etherscan.io/address/0xA69693cbDF9038C1c5b1c453E83Fd59f3258CeA3#code
* > Moderator (this) : manange Registration and Voting https://rinkeby.etherscan.io/address/0x6286DB08B4e5C8A381AaA4a9C0A8e274Fa7C1376#code

## Overview
> P04PAS - POAP 4 PEACE Artist Submbission (yourCollectible)

> HEART - Help Empower Artist Repost Token (yourToken)

Intention: Allow users to vote on Artist Submissions to a Collection with HEART tokens.  

### Ideas
* enable vendor so hearts are purchased - (re-evalate KN03 )

### TODO
* automate (or something) the minting : ~~KN02~~
* add time limits to vote
* > add WL upload and register. WL is currently hardcoded to deployer and contracts - WL could/should? be hodlrs of a token.
* allows one Register(address) at a time - would be nice to extend the registration 
* transfer ownership of collectible to moderator and display collectibles from moderator : KI05

### Known Issues (KNnn) / BUGs 
* KI01: when testing it waits for an event in the browser after minting to continue the test (on localhost anyway)
* ~~KI02: if webpage is refreshed the counter resets and minting a new item will revert to 0.~~
* KI03: when voting: token does not transfer to collectible (code commented)
* KI04: heart counts do not update after Heart Art action 
* * KI04a Voter Address HEART count 
* ** KI04a1 - after register click
* ** KI04a2 - on page refresh
* ** KI04a3 - after voting
* * KI04b Heart Count below Artist Submission next to P04PAS ID 
* KI05: yourCollectible owner is the minter - should be transfered to moderator
* KI06: long load time
* > KI07: Transactions need signing - especially because they are spending eth on gas
* ** KI07a On Register
* ** KI07b On Heart Art
* > KI08: not all nfts display for everyone - some appear as broken links
* > KI09: add instructions for use
* maybe hide the burner wallet?



### 🖨 Minting 

> ✏️ Mint the POAP For PEACE Artist Submission NFTs if not already minted. Click the `MINT NFT` button in the YourCollectables tab.  The current collection is 27 items and it should throw an error if addition items are minted.  

Note: P04PAS Collectibles have already been minted.

### Register
> Click Register to add address to Votes mapping. This will also issue 2 HEART tokens to registering address - this is displayed next to the Register button

### Heart ART
> Click the Heart Art below the Artist Submission up to the number of issued HEART tokens.  The same or multiple submissions can be Hearted.

---
