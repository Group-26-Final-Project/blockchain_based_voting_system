// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "User.sol";

contract Voter is User {
    struct VoterStruct {
        UserStruct voterInfo;
        uint32 vindex;
        string voterEmail;
        string voterPassword;
    }

    address private owner;

    mapping(address => VoterStruct) private voterStructsMapping;
    address[] private voterIndex;
    VoterStruct[] private voterValue;

    event LogNewVoter(
        UserStruct voterInfo,
        string voterEmail,
        string voterPassword
    );
    event LogUpdateVoter(
        UserStruct voterInfo,
        string voterEmail,
        string voterPassword
    );
    event LogDeleteVoter(address indexed userAddress, uint256 index);

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

    function findVoterByStudentId(string memory newStudentId)
        internal
        view
        returns (bool isIndeed)
    {
        VoterStruct[] memory temp = voterValue;
        for (uint256 i = 0; i < temp.length; i++) {
            if (
                keccak256(abi.encodePacked(temp[i].voterInfo.studentId)) ==
                keccak256(abi.encodePacked(newStudentId))
            ) {
                return true;
            }
        }
        return false;
        // return isIndeed;
    }

    function findVoterByEmail(string memory newEmail)
        internal
        view
        returns (bool isIndeed)
    {
        VoterStruct[] memory temp = voterValue;
        for (uint256 i = 0; i < temp.length; i++) {
            if (
                keccak256(abi.encodePacked(temp[i].voterEmail)) ==
                keccak256(abi.encodePacked(newEmail))
            ) {
                return true;
            }
        }
        return false;
        // return isIndeed;
    }

    function findVoterByFullName(
        string memory newfName,
        string memory newlName,
        string memory newgName
    ) internal view returns (bool isIndeed) {
        VoterStruct[] memory temp = voterValue;
        for (uint256 i = 0; i < temp.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(
                        temp[i].voterInfo.fName,
                        " ",
                        temp[i].voterInfo.lName,
                        " ",
                        temp[i].voterInfo.gName
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

    function isVoter(address userAddress) public view returns (bool isIndeed) {
        require(isUser(userAddress), "User Does not Exist");
        if (voterIndex.length == 0) return false;
        return (voterIndex[voterStructsMapping[userAddress].vindex] ==
            userAddress);
    }

    function insertUser(
        UserStruct memory voterInfo,
        string memory email,
        string memory password
    ) public returns (uint256 index) {
        // if (isUser(userAddress)) throw;
        require(userAddress != owner, "Permission Denied");
        require(!isVoter(userAddress), "Voter Already Exists");
        require(
            !findVoterByStudentId(voterInfo.studentId),
            "Voter Already Exists"
        );
        require(
            !findVoterByEmail(voterInfo.voterEmail),
            "Voter Already Exists"
        );
        require(
            !findUserByFullName(
                voterInfo.fName,
                voterInfo.lName,
                voterInfo.gName
            ),
            "Voter Already Exists"
        );

        voterStructsMapping[voterInfo.userAddress].voterInfo = voterInfo;
        voterStructsMapping[voterInfo.userAddress].voterEmail = email;
        voterStructsMapping[voterInfo.userAddress].voterPassword = password;
        // userStructsMapping[userAddress].gName = gName;
        // userStructsMapping[userAddress].userAddress = userAddress;
        voterIndex.push(voterInfo.userAddress);
        userStructsMapping[voterInfo.userAddress].vindex =
            voterIndex.length -
            1;
        voterValue.push(
            VoterStruct(
                voterInfo,
                userStructsMapping[voterInfo.userAddress].vindex,
                email,
                password
            )
        );
        emit LogNewVoter(voterInfo, email, password);
        return voterIndex.length - 1;
    }

    function getVoter(address userAddress)
        public
        view
        returns (UserStruct memory)
    {
        // if (!isUser(userAddress)) throw;
        require(isVoter(userAddress), "Voter Does not exist");

        return (voterStructsMapping[userAddress]);
    }

    function removeVoter(address userAddress) public returns (bool success) {
        require(isVoter(userAddress), "Voter Does not exist");
        uint256 rowToDelete = voterStructsMapping[userAddress].vindex;
        address keyToMove = voterIndex[voterIndex.length - 1];
        voterIndex[rowToDelete] = keyToMove;
        voterStructsMapping[keyToMove].vindex = rowToDelete;

        voterValue[rowToDelete] = voterValue[userValue.length - 1];
        voterValue[rowToDelete].vindex = rowToDelete;
        voterValue.pop();
        voterIndex.pop();
        emit LogDeleteVoter(userAddress, rowToDelete);

        return true;
    }

    function getVoterCount() public view returns (uint256 count) {
        return voterIndex.length;
    }

    function getVoterAtIndex(uint256 index)
        public
        view
        returns (address userAddress)
    {
        return voterIndex[index];
    }

    function getAllVoters() public view returns (VoterStruct[] memory) {
        return voterValue;
    }
}
