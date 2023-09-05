# ETH-WBI

Integrating a generative art token based on Ethereum in a web browser requires a combination of smart contracts on the Ethereum blockchain and frontend code that interacts with these contracts. Below is a general overview of how you could go about implementing this:

### Smart Contract
First, you'll need to deploy a smart contract to the Ethereum blockchain that will handle the generative art token. This contract will typically be based on ERC-721 or ERC-1155 standard for non-fungible tokens (NFTs).

Here is a simplified example using Solidity and the ERC-721 standard:

```solidity
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
```

The `createArt` function mints a new token and associates it with a given metadata URI, which can link to a JSON file that contains information about the generative art.

### Frontend Code
You'll also need frontend code to interact with this contract. The Web3.js or Ethers.js library can be used to interact with Ethereum smart contracts. You'll also need a way to initiate Ethereum transactions, usually via MetaMask.

Here's some sample code using Web3.js:

```javascript
// Initialize web3
if (window.ethereum) {
  window.web3 = new Web3(window.ethereum);
  window.ethereum.enable();
} else if (window.web3) {
  window.web3 = new Web3(window.web3.currentProvider);
} else {
  alert('MetaMask or another Ethereum wallet is required.');
}

const contractAddress = "<YOUR_CONTRACT_ADDRESS>";
const abi = [<YOUR_CONTRACT_ABI>]; // ABI from your contract
const contract = new web3.eth.Contract(abi, contractAddress);

// Function to create art
async function createArt(metadataURI) {
  const accounts = await web3.eth.getAccounts();
  await contract.methods.createArt(metadataURI).send({from: accounts[0]});
}
```

### Generating the Art
The actual art can be generated client-side or server-side, and the metadata URI can point to a dynamically generated image or JSON that contains the art's attributes. You could use JavaScript libraries like p5.js for generating art in the browser.

```javascript
function generateArt() {
  // Use p5.js or another library to generate art
  // ...

  // The metadata URI would then be set when calling the smart contract
  const metadataURI = "ipfs://..."; // replace with actual URI
  createArt(metadataURI);
}
```

### Gluing it All Together
Finally, you'd put everything together in your web interface. Users would click a button to generate art, and this would:

1. Generate the art programmatically using client-side JavaScript.
2. Upload the metadata and/or image to IPFS or another decentralized storage solution.
3. Call the `createArt` function to mint a new NFT that points to this metadata.

This is a broad overview, and the actual implementation would involve more details, including error handling, user feedback, etc.
