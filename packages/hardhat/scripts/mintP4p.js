import { p04pasjson } from "./data/p04pas";
const YOUR_FRONTEND_ADDRESS = process.env.YOUR_FRONTEND_ADDRESS;

/* eslint no-use-before-define: "warn" */
const fs = require("fs");
const chalk = require("chalk");
const { config, ethers } = require("hardhat");
const { utils } = require("ethers");
const R = require("ramda");
const ipfsAPI = require("ipfs-http-client");

const ipfs = ipfsAPI({
  host: "ipfs.infura.io",
  port: "5001",
  protocol: "https",
});

const delayMS = 1000; // sometimes xDAI needs a 6000ms break lol 😅

const main = async () => {
  // ADDRESS TO MINT TO:
  const toAddress = YOUR_FRONTEND_ADDRESS;

  console.log("\n\n 🎫 Minting to " + toAddress + "...\n");

  const { deployer } = await getNamedAccounts();
  const yourCollectible = await ethers.getContract("YourCollectible", deployer);

  const p04pasjson = {
    4020101: {
      description: "Artist Submission - 0201 01",
      external_url: "https://ipfs.io/ipfs/",
      image: "https://ipfs.io/ipfs/QmaeFHMz34Q2DSdaTydt831bGc8X1Evy76RHem8Yn2kbhd?filename=P04PAS_0201_01.png" ,
      name: "4020101",
      attributes: [
        {
          trait_type: "POAPAthon Bounty",
          value: "POAP 4 PEACE"
        },
      ],
    }};

  let art = yourCollectible.artCollection[0];



  //console.log("Uploading art...");
  //const uploaded = await ipfs.add(JSON.stringify(art,));
  //let uri = uploaded.path;
  let uri = art.uri;
  console.log("Minting art with IPFS hash (" + uri + ")");
  await yourCollectible.mintItem(toAddress, uri, {
    gasLimit: 400000,
  });

  await sleep(delayMS);

  // const zebra = {
  //   description: "What is it so worried about?",
  //   external_url: "https://austingriffith.com/portfolio/paintings/", // <-- this can link to a page for the specific file too
  //   image: "https://austingriffith.com/images/paintings/zebra.jpg",
  //   name: "Zebra",
  //   attributes: [
  //     {
  //       trait_type: "BackgroundColor",
  //       value: "blue",
  //     },
  //     {
  //       trait_type: "Eyes",
  //       value: "googly",
  //     },
  //     {
  //       trait_type: "Stamina",
  //       value: 38,
  //     },
  //   ],
  // };
  // console.log("Uploading zebra...");
  // const uploadedzebra = await ipfs.add(JSON.stringify(zebra));

  // console.log("Minting zebra with IPFS hash (" + uploadedzebra.path + ")");
  // await yourCollectible.mintItem(toAddress, uploadedzebra.path, {
  //   gasLimit: 400000,
  // });

  // await sleep(delayMS);

  // const rhino = {
  //   description: "What a horn!",
  //   external_url: "https://austingriffith.com/portfolio/paintings/", // <-- this can link to a page for the specific file too
  //   image: "https://austingriffith.com/images/paintings/rhino.jpg",
  //   name: "Rhino",
  //   attributes: [
  //     {
  //       trait_type: "BackgroundColor",
  //       value: "pink",
  //     },
  //     {
  //       trait_type: "Eyes",
  //       value: "googly",
  //     },
  //     {
  //       trait_type: "Stamina",
  //       value: 22,
  //     },
  //   ],
  // };
  // console.log("Uploading rhino...");
  // const uploadedrhino = await ipfs.add(JSON.stringify(rhino));

  // console.log("Minting rhino with IPFS hash (" + uploadedrhino.path + ")");
  // await yourCollectible.mintItem(toAddress, uploadedrhino.path, {
  //   gasLimit: 400000,
  // });

  // await sleep(delayMS);

  // const fish = {
  //   description: "Is that an underbyte?",
  //   external_url: "https://austingriffith.com/portfolio/paintings/", // <-- this can link to a page for the specific file too
  //   image: "https://austingriffith.com/images/paintings/fish.jpg",
  //   name: "Fish",
  //   attributes: [
  //     {
  //       trait_type: "BackgroundColor",
  //       value: "blue",
  //     },
  //     {
  //       trait_type: "Eyes",
  //       value: "googly",
  //     },
  //     {
  //       trait_type: "Stamina",
  //       value: 15,
  //     },
  //   ],
  // };
  // console.log("Uploading fish...");
  // const uploadedfish = await ipfs.add(JSON.stringify(fish));

  // console.log("Minting fish with IPFS hash (" + uploadedfish.path + ")");
  // await yourCollectible.mintItem(toAddress, uploadedfish.path, {
  //   gasLimit: 400000,
  // });

  await sleep(delayMS);

  console.log(
    "Transferring Ownership of YourCollectible to " + toAddress + "..."
  );

  await yourCollectible.transferOwnership(toAddress, { gasLimit: 400000 });

  await sleep(delayMS);

  /*


  console.log("Minting zebra...")
  await yourCollectible.mintItem("0xD75b0609ed51307E13bae0F9394b5f63A7f8b6A1","zebra.jpg")

  */

  // const secondContract = await deploy("SecondContract")

  // const exampleToken = await deploy("ExampleToken")
  // const examplePriceOracle = await deploy("ExamplePriceOracle")
  // const smartContractWallet = await deploy("SmartContractWallet",[exampleToken.address,examplePriceOracle.address])

  /*
  //If you want to send value to an address from the deployer
  const deployerWallet = ethers.provider.getSigner()
  await deployerWallet.sendTransaction({
    to: "0x34aA3F359A9D614239015126635CE7732c18fDF3",
    value: ethers.utils.parseEther("0.001")
  })
  */

  /*
  //If you want to send some ETH to a contract on deploy (make your constructor payable!)
  const yourContract = await deploy("YourContract", [], {
  value: ethers.utils.parseEther("0.05")
  });
  */

  /*
  //If you want to link a library into your contract:
  // reference: https://github.com/austintgriffith/scaffold-eth/blob/using-libraries-example/packages/hardhat/scripts/deploy.js#L19
  const yourContract = await deploy("YourContract", [], {}, {
   LibraryName: **LibraryAddress**
  });
  */
};

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
