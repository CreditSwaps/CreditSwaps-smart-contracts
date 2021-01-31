require("@nomiclabs/hardhat-waffle");

var HDWalletProvider = require("truffle-hdwallet-provider");

module.exports = {
  solidity: "0.6.12",
  networks: {
    kovan: {
      url: "https://kovan.infura.io/v3/ad589a1dfe8c4ba0bed10d17597de77b",
      accounts: ["0xdd1e9b0cb9b5e6e73deb2f5a9016732b3635c1baf3f52b798f3dca1530c11330"]
    }
  }
};


//0xcAE763a9AA915319b2d6056afCfF1BA3860879fe
//0x906f63c3E70715E5d2e24E2F00FA9de00bDc6F8A