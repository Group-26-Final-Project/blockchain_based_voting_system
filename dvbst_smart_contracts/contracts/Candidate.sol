// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./User.sol";
import "./Voter.sol";

contract Candidate is User {
    struct CandidateStruct {
        UserStruct candidateInfo;
        uint256 vindex;
        string candidateEmail;
        string candidatePassword;
        string candidateBio;
        string candidateProfilePicture;
    }

    address private owner;

    mapping(address => CandidateStruct) private candidateStructsMapping;
    address[] private candidateIndex;
    CandidateStruct[] private candidateValue;

    address private userContractAddress;
    address private voterContractAddress;

    event LogNewCandidate(
        UserStruct candidateInfo,
        string candidateEmail,
        string candidatePassword,
        string candidateBio,
        string candidateProfilePicture
    );
    event LogUpdateCandidate(
        UserStruct candidateInfo,
        string candidateEmail,
        string candidatePassword,
        string candidateBio,
        string candidateProfilePicture
    );
    event LogDeleteCandidate(address indexed userAddress, uint256 index);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function setAddresses(
        address _userContractAddress,
        address _voterContractAddress
    ) public onlyOwner {
        userContractAddress = _userContractAddress;
        voterContractAddress = _voterContractAddress;
    }

    //   event (address indexed userAddress, uint index, bytes32 userEmail, uint userAge);

    // function append(
    //     string memory a,
    //     string memory b,
    //     string memory c
    // ) internal pure returns (string memory) {
    //     return string(abi.encodePacked(a, " ", b, " ", c));
    // }

    function findCandidateByStudentId(string memory newStudentId)
        internal
        view
        returns (bool isIndeed)
    {
        CandidateStruct[] memory temp = candidateValue;
        for (uint256 i = 0; i < temp.length; i++) {
            if (
                keccak256(abi.encodePacked(temp[i].candidateInfo.studentId)) ==
                keccak256(abi.encodePacked(newStudentId))
            ) {
                return true;
            }
        }
        return false;
        // return isIndeed;
    }

    function findCandidateByEmail(string memory newEmail)
        internal
        view
        returns (bool isIndeed)
    {
        CandidateStruct[] memory temp = candidateValue;
        for (uint256 i = 0; i < temp.length; i++) {
            if (
                keccak256(abi.encodePacked(temp[i].candidateEmail)) ==
                keccak256(abi.encodePacked(newEmail))
            ) {
                return true;
            }
        }
        return false;
        // return isIndeed;
    }

    function findCandidateByFullName(
        string memory newfName,
        string memory newlName,
        string memory newgName
    ) internal view returns (bool isIndeed) {
        CandidateStruct[] memory temp = candidateValue;
        for (uint256 i = 0; i < temp.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(
                        temp[i].candidateInfo.fName,
                        " ",
                        temp[i].candidateInfo.lName,
                        " ",
                        temp[i].candidateInfo.gName
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

    function isCandidate(address userAddress)
        public
        view
        returns (bool isIndeed)
    {
        User deployedUser = User(userContractAddress);
        // UserStruct[] memory tempUsers = deployedUser.getAllUsers();
        require(deployedUser.isUser(userAddress), "User Does not Exist");

        if (candidateIndex.length == 0) return false;
        // require(candidateIndex[candidateStructsMapping[userAddress].vindex] ==
        //     userAddress,"index out of bounds error over here");
        return (candidateIndex[candidateStructsMapping[userAddress].vindex] ==
            userAddress);
    }

    function insertCandidate(
        UserStruct memory candidateInfo,
        string memory email,
        string memory password,
        string memory bio,
        string memory profilePicture
    ) public returns (uint256 index) {
        // if (isUser(userAddress)) throw;
        require(candidateInfo.userAddress != owner, "Permission Denied");
        Voter deployedVoter = Voter(voterContractAddress);

        require(
            !deployedVoter.isVoter(candidateInfo.userAddress),
            "User Already a Voter"
        );
        require(
            !isCandidate(candidateInfo.userAddress),
            "Candidate Already Exists"
        );
        require(
            !findCandidateByStudentId(candidateInfo.studentId),
            "Candidate Already Exists"
        );
        require(!findCandidateByEmail(email), "Candidate Already Exists");
        require(
            !findUserByFullName(
                candidateInfo.fName,
                candidateInfo.lName,
                candidateInfo.gName
            ),
            "Candidate Already Exists"
        );

        candidateStructsMapping[candidateInfo.userAddress]
            .candidateInfo = candidateInfo;
        candidateStructsMapping[candidateInfo.userAddress]
            .candidateEmail = email;
        candidateStructsMapping[candidateInfo.userAddress]
            .candidatePassword = password;
        candidateStructsMapping[candidateInfo.userAddress].candidateBio = bio;
        candidateStructsMapping[candidateInfo.userAddress]
            .candidateProfilePicture = profilePicture;
        // userStructsMapping[userAddress].gName = gName;
        // userStructsMapping[userAddress].userAddress = userAddress;
        candidateIndex.push(candidateInfo.userAddress);
        candidateStructsMapping[candidateInfo.userAddress].vindex =
            candidateIndex.length -
            1;
        candidateValue.push(
            CandidateStruct(
                candidateInfo,
                candidateStructsMapping[candidateInfo.userAddress].vindex,
                email,
                password,
                bio,
                profilePicture
            )
        );
        emit LogNewCandidate(
            candidateInfo,
            email,
            password,
            bio,
            profilePicture
        );
        return candidateIndex.length - 1;
    }

    function getCandidate(address userAddress)
        public
        view
        returns (CandidateStruct memory)
    {
        // if (!isUser(userAddress)) throw;
        require(isCandidate(userAddress), "Candidate Does not exist");

        return (candidateStructsMapping[userAddress]);
    }

    function removeCandidate(address userAddress)
        public
        returns (bool success)
    {
        require(isCandidate(userAddress), "Candidate Does not exist");
        uint256 rowToDelete = candidateStructsMapping[userAddress].vindex;
        address keyToMove = candidateIndex[candidateIndex.length - 1];
        candidateIndex[rowToDelete] = keyToMove;
        candidateStructsMapping[keyToMove].vindex = rowToDelete;

        candidateValue[rowToDelete] = candidateValue[candidateValue.length - 1];
        candidateValue[rowToDelete].vindex = rowToDelete;
        candidateValue.pop();
        candidateIndex.pop();
        delete candidateStructsMapping[userAddress];
        emit LogDeleteCandidate(userAddress, rowToDelete);

        return true;
    }

    function getCandidateCount() public view returns (uint256 count) {
        return candidateIndex.length;
    }

    function getCandidateAtIndex(uint256 index)
        public
        view
        returns (address userAddress)
    {
        return candidateIndex[index];
    }

    function getAllCandidates() public view returns (CandidateStruct[] memory) {
        return candidateValue;
    }
}
