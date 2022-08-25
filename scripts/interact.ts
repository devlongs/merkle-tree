import { ethers } from "hardhat";

const { MerkleTree } = require("merkletreejs");
const keccak256 = require("keccak256");

async function main() {
  // We are using a particular hardhat generated addresses for the whitelist addresses

  const [
    address1,
    address2,
    address3,
    address4,
    address5,
    address6,
    address7,
    address8,
  ] = await ethers.getSigners();

  let whitelistAddresses = [
    address1.address,
    address2.address,
    address3.address,
    address4.address,
    address5.address,
    address6.address,
    address7.address,
    address8.address,
  ];

  const encodeLeaf = whitelistAddresses.map((addr) => keccak256(addr));

  const merkleTree = new MerkleTree(encodeLeaf, keccak256, { sortPairs: true });

  const rootHash = merkleTree.getHexRoot();
  // Test to check if an address is in the merkle tree
  const claimingAddress = encodeLeaf[0];
  const hexProof = merkleTree.getHexProof(claimingAddress);

  console.log(`The proof of the inputed address is: ${hexProof}`);

  console.log(`The Whitelist merkleTree are: ${merkleTree.toString()}`);
  console.log(`The Root hash of the merkle tree is: ${rootHash}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
