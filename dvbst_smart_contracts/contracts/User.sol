// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract User {
    struct UserStruct {
        uint256 index;
        string studentId;
        string fName;
        string lName;
        string gName;
        // uint16 DOB;
        // uint16 currentYear;
        // uint8 currentSection;
        // string currentDepartment;
        address userAddress;
    }

    address private owner;

    mapping(address => UserStruct) private userStructsMapping;
    address[] private userIndex;
    UserStruct[] private userValue;

    event LogNewUser(
        address indexed userAddress,
        uint256 index,
        string studentId,
        string fName,
        string lName,
        string gName
    );
    event LogUpdateUser(
        address indexed userAddress,
        uint256 index,
        string studentId,
        string fName,
        string lName,
        string gName
    );
    event LogDeleteUser(address indexed userAddress, uint256 index);

    constructor() {
        owner = msg.sender;
    }

    function getUserCount() public view returns (uint256 count) {
        return userIndex.length;
    }

    function getUserAtIndex(uint256 index)
        public
        view
        returns (address userAddress)
    {
        return userIndex[index];
    }

    function getAllUsers() public view returns (UserStruct[] memory) {
        return userValue;
    }
}
