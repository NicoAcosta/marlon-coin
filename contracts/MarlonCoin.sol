//SPDX-License-Identifier: Unlicense
// pragma solidity ^0.8.0;
pragma solidity 0.8.3;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MarlonCoin is ERC20, Ownable {
    uint256 public icoPrice = 0.0001 ether;
    uint256 public maxSupply = _decimals(20);

    constructor() ERC20("Marlon Coin", "MC") {}

    function mint() external payable {
        require(msg.value == icoPrice, "manda 0.0001 ether rata");
        require(totalSupply() < maxSupply, "ya no se puede mintear pa");
        _mint(msg.sender, _decimals(1));
    }

    function mint(uint256 _amount) external payable {
        require(msg.value == icoPrice * _amount, "value invalido");
        uint256 _amountWithDecimals = _decimals(_amount);
        require(
            totalSupply() + _amountWithDecimals <= maxSupply,
            "no podes mintear esa cantidad"
        );
        _mint(msg.sender, _amountWithDecimals);
    }

    function leftToMint() external view returns (uint256) {
        return maxSupply - totalSupply();
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    function _decimals(uint256 _amount) private pure returns (uint256) {
        return _amount * (10**18);
    }
}
