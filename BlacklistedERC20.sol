// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BlacklistedERC20 is ERC20 {
    // Publicly viewable blacklist
    mapping(address => bool) public isBlacklisted;

    constructor(string memory name, string memory symbol)
        ERC20(name, symbol)
        payable
    {
        _mint(msg.sender, 1000 * 10 ** 18);
    }

    // Function to add an address to the blacklist
    function addToBlacklist(address _address) public {
        isBlacklisted[_address] = true;
    }

    // Function to remove an address from the blacklist
    function removeFromBlacklist(address _address) public {
        isBlacklisted[_address] = false;
    }

    // Function to check if an address is blacklisted
    function checkBlacklisted(address account) public view returns (bool) {
        return isBlacklisted[account];
    }

    function _update(address from, address to, uint256 amount) internal virtual override {
        super._update(from, to, amount);

        // Check if the sender or receiver is blacklisted
        require(!isBlacklisted[from], "BlacklistedERC20: sender is blacklisted");
        require(!isBlacklisted[to], "BlacklistedERC20: receiver is blacklisted");
    }
}
