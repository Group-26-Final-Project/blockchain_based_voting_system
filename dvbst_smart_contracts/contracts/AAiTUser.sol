// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./AAiTElection.sol";
import "./AAiTElectionTimer.sol";

contract AAiTUser {
    enum DEPTARTMENT_TYPE {
        SITE,
        ELEC
    }
    enum USER_TYPE {
        VOTER,
        CANDIDATE,
        ADMIN
    }
    struct UserStruct {
        uint256 index;
        string studentId;
        string fullName;
        // string lName;
        // string gName;
        uint256 currentYear;
        uint256 currentSection;
        DEPTARTMENT_TYPE currentDepartment;
        string email;
        string phone;
    }
    struct VoterStruct {
        UserStruct voterInfo;
        uint256 vindex;
        // string voterEmail;
        // string voterPassword;
        // address voterAddress;
    }

    struct CandidateStruct {
        UserStruct candidateInfo;
        uint256 vindex;
        // string candidateEmail;
        // string candidatePassword;
        string candidateBio;
        string candidateProfilePicture;
        // address candidateAddress;
    }
    struct AdminStruct {
        UserStruct adminInfo;
    }

    mapping(string => UserStruct) private userStructsMapping;
    string[] private userIndex;
    UserStruct[] private userValue;
    VoterStruct[] private votersList;
    CandidateStruct[] private candidatesList;
    AdminStruct[] private adminList;
    address private owner;

    AAiTElectionTimer private electionTimer;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor(address _AAiTElectionTimerContractAddress) {
        owner = msg.sender;
        electionTimer = AAiTElectionTimer(_AAiTElectionTimerContractAddress);
    }

    function findUserByStudentId(string memory newStudentId)
        internal
        view
        returns (bool)
    {
        for (uint256 i = 0; i < userValue.length; i++) {
            if (
                keccak256(abi.encodePacked(userValue[i].studentId)) ==
                keccak256(abi.encodePacked(newStudentId))
            ) {
                return true;
            }
        }
        return false;
    }

    function findUserByPhoneNumber(string memory phoneNumber)
        internal
        view
        returns (
            // string memory newlName,
            // string memory newgName
            bool
        )
    {
        for (uint256 i = 0; i < userValue.length; i++) {
            if (
                keccak256(abi.encodePacked(phoneNumber)) ==
                keccak256(abi.encodePacked(userValue[i].phone))
            ) {
                return true;
            }
        }
        return false;
    }

    function findUserByEmail(string memory newEmail)
        internal
        view
        returns (bool)
    {
        for (uint256 i = 0; i < userValue.length; i++) {
            if (
                keccak256(abi.encodePacked(userValue[i].email)) ==
                keccak256(abi.encodePacked(newEmail))
            ) {
                return true;
            }
        }
        return false;
        // return isIndeed;
    }

    function isUser(
        // string memory newfName,
        // string memory newlName,
        string memory fullName
    ) public view returns (bool) {
        if (userIndex.length == 0) return false;
        return (keccak256(
            abi.encodePacked(userIndex[userStructsMapping[fullName].index])
        ) ==
            keccak256(
                abi.encodePacked(fullName)
            ));
    }

    function insertUser(
        string memory studentId,
        // string memory fName,
        // string memory lName,
        string memory fullName,
        // uint256 DOB,
        uint256 currentYear,
        uint256 currentSection,
        DEPTARTMENT_TYPE currentDepartment,
        string memory email,
        string memory phone,
        string memory profilePicture,
        string memory bio,
        USER_TYPE role
    ) external returns (uint256 index) {
        // require(msg.sender != owner, "Permission Denied");
        require(electionTimer.getCurrentPhase().phaseName != AAiTElectionTimer.PHASE_NAME.COMPLETED, "Invalid Operation");
        require(!isUser(fullName), "User Already Exists");
        require(!findUserByStudentId(studentId), "User Already Exists");
        require(
            !findUserByPhoneNumber(phone),
            "User Already Exists"
        );
        require(!findUserByEmail(email), "User Already Exists");

        // string memory fullName = AAiTElectionLibrary.bytes32ToString(
        //     keccak256(abi.encodePacked(fName, " ", lName, " ", gName))
        // );

        userStructsMapping[fullName].studentId = studentId;
        userStructsMapping[fullName].fullName = fullName;
        // userStructsMapping[fullName].lName = lName;
        // userStructsMapping[fullName].gName = gName;
        userStructsMapping[fullName].phone = phone;
        userStructsMapping[fullName].currentYear = currentYear;
        userStructsMapping[fullName].currentSection = currentSection;
        userStructsMapping[fullName].currentDepartment = currentDepartment;
        userStructsMapping[fullName].email = email;
        userIndex.push(fullName);
        userStructsMapping[fullName].index = userIndex.length - 1;
        userValue.push(
            UserStruct(
                userStructsMapping[fullName].index,
                studentId,
                fullName,
                // lName,
                // gName,
                currentYear,
                currentSection,
                currentDepartment,
                email,
                phone
            )
        );
        if (role == USER_TYPE.VOTER) {
            votersList.push(
                VoterStruct(
                    userStructsMapping[fullName],
                    userStructsMapping[fullName].index
                )
            );
        } else if (role == USER_TYPE.CANDIDATE) {
            candidatesList.push(
                CandidateStruct(
                    userStructsMapping[fullName],
                    userStructsMapping[fullName].index,
                    bio,
                    profilePicture
                )
            );
        } else if (role == USER_TYPE.ADMIN) {
            adminList.push(AdminStruct(userStructsMapping[fullName]));
            return userIndex.length - 1;
        }
        // emit LogNewUser(
        //     userStructsMapping[fullName].index,
        //     studentId,
        //     fName,
        //     lName,
        //     gName,
        //     DOB,
        //     currentYear,
        //     currentSection,
        //     currentDepartment
        // );
        return userIndex.length - 1;
    }

    function getUser(
        // string memory fName,
        // string memory lName,
        string memory fullName
    ) external view returns (UserStruct memory) {
        // if (!isUser(userAddress)) throw;
        require(isUser(fullName), "User Does not exist");
        // string memory fullName = AAiTElectionLibrary.bytes32ToString(
        //     keccak256(abi.encodePacked(fName, " ", lName, " ", gName))
        // );

        return (userStructsMapping[fullName]);
    }

    function getAllUsers() external view returns (UserStruct[] memory) {
        return userValue;
    }

    function removeUser(
        // string memory fName,
        // string memory lName,
        string memory fullName
    ) external returns (bool success) {
        require(isUser(fullName), "User Does not exist");
        // string memory fullName = AAiTElectionLibrary.bytes32ToString(
        //     keccak256(abi.encodePacked(fName, " ", lName, " ", gName))
        // );
        // Candidate deployedCandidate = Candidate(candidateContractAddress);
        // Voter deployedVoter = Voter(voterContractAddress);

        // if (isVoter(userAddress)) {
        //     removeVoter(userAddress);
        // }
        // if (isCandidate(userAddress)) {
        //     removeCandidate(userAddress);
        // }

        userIndex[userStructsMapping[fullName].index] = userIndex[
            userIndex.length - 1
        ];
        userStructsMapping[userIndex[userIndex.length - 1]]
            .index = userStructsMapping[fullName].index;

        userValue[userStructsMapping[fullName].index] = userValue[
            userValue.length - 1
        ];
        userValue[userStructsMapping[fullName].index]
            .index = userStructsMapping[fullName].index;
        userValue.pop();
        userIndex.pop();
        delete userStructsMapping[fullName];

        return true;
    }

    function getAllVoters() external view returns (VoterStruct[] memory) {
        return votersList;
    }

    function getAllCandidates()
        external
        view
        returns (CandidateStruct[] memory)
    {
        return candidatesList;
    }

    function getUserByEmail(string memory email)
        external
        view
        returns (VoterStruct memory zvoter, CandidateStruct memory zcandidate)
    {
        require(findUserByEmail(email), "User Does not exist");
        for (uint256 i = 0; i < votersList.length; i++) {
            if (
                keccak256(abi.encodePacked(votersList[i].voterInfo.email)) ==
                keccak256(abi.encodePacked(email))
            ) {
                CandidateStruct memory emptyCandidate;
                return (votersList[i], emptyCandidate);
            }
        }
        for (uint256 i = 0; i < candidatesList.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(candidatesList[i].candidateInfo.email)
                ) == keccak256(abi.encodePacked(email))
            ) {
                VoterStruct memory emptyVoter;
                return (emptyVoter, candidatesList[i]);
            }
        }
        revert("Not found");
    }
}
