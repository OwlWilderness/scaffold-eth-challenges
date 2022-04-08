# 🏗 scaffold-eth | 🏰 BuidlGuidl

## 🚩 Extension of Challenge 0 & 1: 🎟 Vote for YourCollectible with Your Token 🤓

🎫 Using what you learned in the first three challenges Create a simple NFT voting application to renforce the basics of 🏗 scaffold-eth. You'll use [👷‍♀️ HardHat](https://hardhat.org/getting-started/) to compile and deploy smart contracts. Then, you'll use a template React app full of important Ethereum components and hooks. Finally, you'll deploy an NFT to a public network to share with friends! 🚀

It is recommended you Complete the first three Challenges of Speed Run Ethereum.

🌟 The final deliverable is an app that lets users vote on NFTs. Deploy your contracts to Rinkeby and then build and upload your app to a public web server. 

---

The initial challenges are at [SpeedRunEthereum.com](https://speedrunethereum.com)!

💬 If you have not you can join the telegram [Challenge 0 telegram](https://t.me/+Y2vqXZZ_pEFhMGMx)!!!

---

# Source

Original Source: https://github.com/scaffold-eth/scaffold-eth-challenges

Forked Source: https://github.com/OwlWilderness/scaffold-eth-challenges/tree/forest

---
# Overview

Intention: Allow users to vote on Artist Submissions to a Collection with HEART tokens.  

---

# TODO
* add time limits to vote
* add WL upload and register.  WL is currently hardcoded to deployer and contracts - WL could/should? be hodlrs of a token.
* allows one Register(address) at a time - would be nice to extend the registration 
* automate the minting

---

# Known Issues
* when testing it waits for an event in the browser after minting to continue the test (on localhost anyway)
* if webpage is refreshed the counter resets and minting a new item will revert to 0.
* when voting: token does not transfer to collectible (code commented)

---

# Contracts (From Challenge)
> YourCollectible - (Challenge 0) : POAP for PEACE Artist Submissions (P04PAS)
> YourToken - (Challege 2) : HEART token used to vote
> Vendor - (Challenge 2) : Hold and Issue HEART tokens (currently no cost)
> Moderator (this) : manange Registration and Voting

---

# 🖨 Minting 

> ✏️ Mint the POAP For PEACE Artist Submission NFTs if not already minted. Click the `MINT NFT` button in the YourCollectables tab.  The current collection is 27 items and it should throw an error if addition items are minted.  

---

> 👉 Problems, questions, comments on the stack? Post them to the [🏗 scaffold-eth developers chat](https://t.me/joinchat/F7nCRK3kI93PoCOk)
