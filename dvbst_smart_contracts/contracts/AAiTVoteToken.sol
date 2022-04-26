// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "dvbst_smart_contracts/node_modules/@opengsn/contracts/src/BaseRelayRecipient.sol";
import "dvbst_smart_contracts/node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AAiTVoteToken is ERC20, BaseRelayRecipient {
    address public owner;

    modifier onlyOwner() {
        require(
            owner == msg.sender,
            "This function is restricted to the contract's owner"
        );
        _;
    }

    function mint(uint256 supply) external onlyOwner {
        _mint(_msgSender(), supply);
    }

    constructor() ERC20("AAiT Vote", "VOT") {
        _mint(msg.sender, 1000);
        owner = msg.sender;
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

    function setTrustForwarder(address _trustedForwarder) public onlyOwner {
        _setTrustedForwarder(_trustedForwarder);
    }

    function versionRecipient() external pure override returns (string memory) {
        return "1";
    }
}
