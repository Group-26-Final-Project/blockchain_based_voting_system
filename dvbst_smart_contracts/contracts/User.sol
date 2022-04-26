// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./Candidate.sol";
import "./Voter.sol";

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
    address private voterContractAddress;
    address private candidateContractAddress;

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

    //   event (address indexed userAddress, uint index, bytes32 userEmail, uint userAge);

    // function append(
    //     string memory a,
    //     string memory b,
    //     string memory c
    // ) internal pure returns (string memory) {
    //     return string(abi.encodePacked(a, " ", b, " ", c));
    // }

    function findUserByStudentId(string memory newStudentId)
        internal
        view
        returns (bool isIndeed)
    {
        UserStruct[] memory temp = userValue;
        for (uint256 i = 0; i < temp.length; i++) {
            if (
                keccak256(abi.encodePacked(temp[i].studentId)) ==
                keccak256(abi.encodePacked(newStudentId))
            ) {
                return true;
            }
        }
        return false;
    }

    function findUserByFullName(
        string memory newfName,
        string memory newlName,
        string memory newgName
    ) internal view returns (bool isIndeed) {
        UserStruct[] memory temp = userValue;
        for (uint256 i = 0; i < temp.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(
                        temp[i].fName,
                        " ",
                        temp[i].lName,
                        " ",
                        temp[i].gName
                    )
                ) ==
                keccak256(
                    abi.encodePacked(newfName, " ", newlName, " ", newgName)
                )
            ) {
                return true;
            }
        }
        return false;
    }

    function isUser(address userAddress) public view returns (bool isIndeed) {
        if (userIndex.length == 0) return false;
        return (userIndex[userStructsMapping[userAddress].index] ==
            userAddress);
    }

    function insertUser(
        address userAddress,
        string memory studentId,
        string memory fName,
        string memory lName,
        string memory gName
    ) public returns (uint256 index) {
        // if (isUser(userAddress)) throw;
        require(userAddress != owner, "Permission Denied");
        require(!isUser(userAddress), "User Already Exists");
        require(!findUserByStudentId(studentId), "User Already Exists");
        require(
            !findUserByFullName(fName, lName, gName),
            "User Already Exists"
        );

        userStructsMapping[userAddress].studentId = studentId;
        userStructsMapping[userAddress].fName = fName;
        userStructsMapping[userAddress].lName = lName;
        userStructsMapping[userAddress].gName = gName;
        userStructsMapping[userAddress].userAddress = userAddress;
        userIndex.push(userAddress);
        userStructsMapping[userAddress].index = userIndex.length - 1;
        userValue.push(
            UserStruct(
                userStructsMapping[userAddress].index,
                studentId,
                fName,
                lName,
                gName,
                userAddress
            )
        );
        emit LogNewUser(
            userAddress,
            userStructsMapping[userAddress].index,
            studentId,
            fName,
            lName,
            gName
        );
        return userIndex.length - 1;
    }

    function getUser(address userAddress)
        public
        view
        returns (UserStruct memory)
    {
        // if (!isUser(userAddress)) throw;
        require(isUser(userAddress), "User Does not exist");

        return (userStructsMapping[userAddress]);
    }

    // function updateUserStudentId(address userAddress, string memory newStudentId)
    //     public
    //     returns (bool success)
    // {
    //     require(isUser(userAddress), "User Does not exist");
    //     // if(!isUser(userAddress)) throw;
    //     userStructsMapping[userAddress].studentId = newStudentId;
    //     emit LogUpdateUser(
    //         userAddress,
    //         userStructsMapping[userAddress].index,
    //         userStructsMapping[userAddress].studentId,
    //         userStructsMapping[userAddress].fName,
    //         userStructsMapping[userAddress].lName,
    //         userStructsMapping[userAddress].gName
    //     );
    //     return true;
    // }

    //   function updateUserAge(address userAddress, uint userAge)
    //     public
    //     returns(bool success)
    //   {
    //     if(!isUser(userAddress)) throw;
    //     userStructsMapping[userAddress].userAge = userAge;
    //     emit LogUpdateUser(
    //       userAddress,
    //       userStructsMapping[userAddress].index,
    //       userStructsMapping[userAddress].userEmail,
    //       userAge);
    //     return true;
    //   }

    function removeUser(address userAddress) public returns (bool success) {
        require(isUser(userAddress), "User Does not exist");
        Candidate deployedCandidate = Candidate(candidateContractAddress);
        Voter deployedVoter = Voter(voterContractAddress);

        if (deployedVoter.isVoter(userAddress)) {
            deployedVoter.removeVoter(userAddress);
        }
        if (deployedCandidate.isCandidate(userAddress)) {
            deployedCandidate.removeCandidate(userAddress);
        }

        uint256 rowToDelete = userStructsMapping[userAddress].index;
        address keyToMove = userIndex[userIndex.length - 1];
        userIndex[rowToDelete] = keyToMove;
        userStructsMapping[keyToMove].index = rowToDelete;

        userValue[rowToDelete] = userValue[userValue.length - 1];
        userValue[rowToDelete].index = rowToDelete;
        userValue.pop();
        userIndex.pop();
        delete userStructsMapping[userAddress];
        emit LogDeleteUser(userAddress, rowToDelete);
        emit LogUpdateUser(
            keyToMove,
            rowToDelete,
            userStructsMapping[keyToMove].studentId,
            userStructsMapping[keyToMove].fName,
            userStructsMapping[keyToMove].lName,
            userStructsMapping[keyToMove].gName
        );
        return true;
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
