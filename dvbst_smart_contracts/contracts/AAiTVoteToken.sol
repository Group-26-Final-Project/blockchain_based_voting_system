// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@opengsn/contracts/src/BaseRelayRecipient.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AAiTVoteToken is ERC20, BaseRelayRecipient {
    address public owner;

    modifier onlyOwner() {
        require(
            owner == msg.sender,
            "This function is restricted to the contract's owner"
        );
        _;
    }

    function mint(uint256 supply) public onlyOwner {
        _mint(_msgSender(), supply);
    }

    function transferToken(address to)
        public
        onlyOwner
        returns (bool)
    {
        _transfer(owner, to, 1);
        return true;
    }

    function transferTokenFrom(
        address from,
        address to
    ) public onlyOwner returns (bool) {
        _transfer(from, to, 1);
        return true;
    }

    function burnRemainingTokens(address tokenOwner) public onlyOwner {
        _burn(owner, balanceOf(tokenOwner));
    }

    function getRemainingToken(address voter) public view returns (uint256) {
        return balanceOf(voter);
    }

    // constructor(address _trustedForwarder) ERC20("AAiT Vote", "VOT") {
    //     _mint(msg.sender, 1000);
    //     _setTrustedForwarder(_trustedForwarder);
    //     owner = msg.sender;
    // }

    constructor() ERC20("AAiT Vote", "VOT") {
        owner = msg.sender;
        mint(1000);
        // _setTrustedForwarder(_trustedForwarder);
    }

    /**
     * OPTIONAL
     * You should add one setTrustedForwarder(address _trustedForwarder)
     * method with onlyOwner modifier so you can change the trusted
     * forwarder address to switch to some other meta transaction protocol
     * if any better protocol comes tomorrow or current one is upgraded.
     */
    function setTrustForwarder(address _trustedForwarder) public onlyOwner {
        _setTrustedForwarder(_trustedForwarder);
    }

    /**
     * Override this function.
     * This version is to keep track of BaseRelayRecipient you are using
     * in your contract.
     */
    function versionRecipient() external pure override returns (string memory) {
        return "1";
    }

    function _msgSender()
        internal
        view
        override(Context, BaseRelayRecipient)
        returns (address sender)
    {
        sender = BaseRelayRecipient._msgSender();
    }

    function _msgData()
        internal
        view
        override(Context, BaseRelayRecipient)
        returns (bytes memory)
    {
        return BaseRelayRecipient._msgData();
    }
}
