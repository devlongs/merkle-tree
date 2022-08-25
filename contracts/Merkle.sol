// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.9;


import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";


interface IGorrilaHead {
    function safeMint(address to) external returns(uint256);
}



contract Merkle{
    IGorrilaHead nftAdd;
    bytes32 public merkleRoot = 0x185622dc03039bc70cbb9ac9a4a086aec201f986b154ec4c55dad48c0a474e23;

    mapping(address => bool) whitelisted;

    constructor(IGorrilaHead _nftAdd){
        nftAdd = _nftAdd;
    }


    function WhitelistMint(bytes32[] calldata proof) public {
        require(!whitelisted[msg.sender], "You have minted");

        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(proof, merkleRoot, leaf), "Invalid proof");
        nftAdd.safeMint(msg.sender);


        whitelisted[msg.sender] = true;
    }
}