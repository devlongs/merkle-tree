// SPDX-License-Identifier: GPL-3.0


pragma solidity 0.8.9;


import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// AN NFT where only Admin can mint to users
// The NFT has a max supply of 50
contract GorrilaHead is ERC721URIStorage {
    constructor() ERC721("GorrilaHead", "GH"){}

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 MAX_SUPPLY = 49;
    string nfturi = "https://ipfs.io/ipfs/QmT5cGgUZeMgNS6poZSPf7ebcnswaf5vjuP4F8DAAKp3gw?filename=metadata.json";


    function safeMint(address to) external returns(uint256) {
        uint256 newItemId = _tokenIds.current();
        require( newItemId <= MAX_SUPPLY, "All nft have been minted");
        _mint(to, newItemId);
        _setTokenURI(newItemId, nfturi);

        _tokenIds.increment();
        return (newItemId);
    }

}