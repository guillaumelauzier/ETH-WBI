
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract GenerativeArt is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("GenerativeArt", "GENART") {}

    function createArt(string memory metadataURI) external returns (uint256) {
        _tokenIds.increment();
        uint256 newArtId = _tokenIds.current();
        
        _mint(msg.sender, newArtId);
        _setTokenURI(newArtId, metadataURI);

        return newArtId;
    }
}
