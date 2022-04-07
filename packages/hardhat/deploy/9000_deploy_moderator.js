// deploy/00_deploy_your_contract.js

const { ethers } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments, getChainId }) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = await getChainId();

  // You might need the previously deployed contracts:
  const yourCollection = await ethers.getContract("YourCollectible", deployer);
 // const exampleExternalContract = await ethers.getContract("ExampleExternalContract", deployer);
 // const staker = await ethers.getContract("Staker", deployer);
  const yourToken = await ethers.getContract("YourToken", deployer);
  const vendor = await ethers.getContract("Vendor", deployer);

  // Todo: deploy the contract
   await deploy("Moderator", {
     from: deployer,
     args: [vendor.address, yourCollection.address, yourToken.address], // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
     log: true,
     value: ethers.utils.parseEther("0.00023"),
   });
};

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

module.exports.tags = ["Moderator"];