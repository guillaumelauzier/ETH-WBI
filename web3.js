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
