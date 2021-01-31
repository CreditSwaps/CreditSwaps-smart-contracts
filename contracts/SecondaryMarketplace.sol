// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/payment/PullPayment.sol";

contract SecondaryMarketPlace is ERC721, PullPayment {
    uint256 public _tokenIds;
    uint256 public _debtDerivateItemIds;
    mapping(uint256 => DebtDerivateItem) private _debtDerivateItems;

    struct DebtDerivateItem {
        address seller;
        uint256 price;
        string tokenURI;
        bool exists;
    }

    constructor() public ERC721("DigitalArt", "ART") {}

    modifier debtDerivateItemExist(uint256 id) {
        require(_debtDerivateItems[id].exists, "Not Found");
        _;
    }

    function adddebtDerivateItem(uint256 price, string memory tokenURI) public {
        require(price > 0, "Price cannot be 0");

        _debtDerivateItemIds++;
        _debtDerivateItems[_debtDerivateItemIds] = DebtDerivateItem(msg.sender, price, tokenURI, true);
    }

    function getDebtDerivateItem(uint256 id)
        public
        view
        debtDerivateItemExist(id)
        returns (
            uint256,
            uint256,
            string memory
        )
    {
        DebtDerivateItem memory DebtDerivateItem = _debtDerivateItems[id];
        return (id, DebtDerivateItem.price, DebtDerivateItem.tokenURI);
    }

    function purchaseArtItem(uint256 debtDerivateItemId)
        external
        payable
        debtDerivateItemExist(debtDerivateItemId)
    {
        DebtDerivateItem storage debtDerivateItem = _debtDerivateItems[debtDerivateItemId];

        require(msg.value >= debtDerivateItem.price, "Your bid is too low");

        _tokenIds++;

        _safeMint(msg.sender, _tokenIds);
        _setTokenURI(_tokenIds, debtDerivateItem.tokenURI);
        _asyncTransfer(debtDerivateItem.seller, msg.value);
    }

    function getPayments() external {
        withdrawPayments(msg.sender);
    }
}