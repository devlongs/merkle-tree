import { ethers } from "hardhat";

async function main() {
  const Todo = await ethers.getContractFactory("Todo");
  const todo = await Todo.deploy();

  await todo.deployed();

  console.log(`todo contract is deployed to this address: ${todo.address}`); // 
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});