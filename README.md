# 🏗 scaffold-eth | 🏰 BuidlGuidl

## 🚩 Extension of Challenge 0 & 2: 🎟 Vote for YourCollectible with Your Token 🤓

🎫 This NFT voting applicaiton was created from a fork of the first three Speed Run Ethereum challenges on scaffold-eth. 

🌟 The final deliverable is an app that lets users vote on NFTs. 
---

The initial challenges are at [SpeedRunEthereum.com](https://speedrunethereum.com)!

💬 If you have not you can join the telegram [Challenge 0 telegram](https://t.me/+Y2vqXZZ_pEFhMGMx)!!!


## Source

Original Source: https://github.com/scaffold-eth/scaffold-eth-challenges

Forked Source: https://github.com/OwlWilderness/scaffold-eth-challenges/tree/forest


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

### Known Issues (KNnn)
* KI01: when testing it waits for an event in the browser after minting to continue the test (on localhost anyway)
* > ~~KI02: if webpage is refreshed the counter resets and minting a new item will revert to 0.~~
* KI03: when voting: token does not transfer to collectible (code commented)
* KI04: heart counts do not update after Heart Art action 
* * KI04a Voter Address HEART count
* * KI04b Heart Count below Artist Submission next to P04PAS ID 

### Contracts (From Challenge)
* > YourCollectible - (Challenge 0) : POAP for PEACE Artist Submissions (P04PAS)
* > YourToken - (Challege 2) : HEART token used to vote
* > Vendor - (Challenge 2) : Hold and Issue HEART tokens (currently no cost)
* > Moderator (this) : manange Registration and Voting



### 🖨 Minting 

> ✏️ Mint the POAP For PEACE Artist Submission NFTs if not already minted. Click the `MINT NFT` button in the YourCollectables tab.  The current collection is 27 items and it should throw an error if addition items are minted.  

### Register
> Click Register to add address to Votes mapping. This will also issue 2 HEART tokens to registering address - this is displayed next to the Register button

### Heart ART
> Click the Heart Art below the Artist Submission up to the number of issued HEART tokens.  The same or multiple submissions can be Hearted.

---
