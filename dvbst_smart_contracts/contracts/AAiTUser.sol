// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract AAiTUser {
    enum DEPTARTMENT_TYPE {
        SITE,
        ELEC
    }
    struct UserStruct {
        uint256 index;
        string studentId;
        string fName;
        string lName;
        string gName;
        uint256 DOB;
        uint256 currentYear;
        uint256 currentSection;
        DEPTARTMENT_TYPE currentDepartment;
        string email;
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

    mapping(string => UserStruct) private userStructsMapping;
    string[] private userIndex;
    UserStruct[] private userValue;
    VoterStruct[] private votersList;
    CandidateStruct[] private candidatesList;
    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function bytes32ToString(bytes32 _bytes32)
        internal
        pure
        returns (string memory)
    {
        uint8 i = 0;
        while (i < 32 && _bytes32[i] != 0) {
            i++;
        }
        bytes memory bytesArray = new bytes(i);
        for (i = 0; i < 32 && _bytes32[i] != 0; i++) {
            bytesArray[i] = _bytes32[i];
        }
        return string(bytesArray);
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

    function findUserByFullName(
        string memory newfName,
        string memory newlName,
        string memory newgName
    ) internal view returns (bool) {
        for (uint256 i = 0; i < userValue.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(
                        userValue[i].fName,
                        " ",
                        userValue[i].lName,
                        " ",
                        userValue[i].gName
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
        string memory newfName,
        string memory newlName,
        string memory newgName
    ) public view returns (bool) {
        if (userIndex.length == 0) return false;
        return (keccak256(
            abi.encodePacked(
                userIndex[
                    userStructsMapping[
                        bytes32ToString(
                            keccak256(
                                abi.encodePacked(
                                    newfName,
                                    " ",
                                    newlName,
                                    " ",
                                    newgName
                                )
                            )
                        )
                    ].index
                ]
            )
        ) ==
            keccak256(
                abi.encodePacked(newfName, " ", newlName, " ", newgName)
            ));
    }

    function insertUser(
        string memory studentId,
        string memory fName,
        string memory lName,
        string memory gName,
        uint256 DOB,
        uint256 currentYear,
        uint256 currentSection,
        DEPTARTMENT_TYPE currentDepartment,
        string memory email,
        string memory profilePicture,
        string memory bio
    ) external onlyOwner returns (uint256 index) {
        // require(msg.sender != owner, "Permission Denied");
        require(!isUser(fName, lName, gName), "User Already Exists");
        require(!findUserByStudentId(studentId), "User Already Exists");
        require(
            !findUserByFullName(fName, lName, gName),
            "User Already Exists"
        );
        require(!findUserByEmail(email), "User Already Exists");

        string memory fullName = bytes32ToString(
            keccak256(abi.encodePacked(fName, " ", lName, " ", gName))
        );

        userStructsMapping[fullName].studentId = studentId;
        userStructsMapping[fullName].fName = fName;
        userStructsMapping[fullName].lName = lName;
        userStructsMapping[fullName].gName = gName;
        userStructsMapping[fullName].DOB = DOB;
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
                fName,
                lName,
                gName,
                DOB,
                currentYear,
                currentSection,
                currentDepartment,
                email
            )
        );
        if (
            keccak256(abi.encodePacked(profilePicture)) == keccak256(abi.encodePacked("")) &&
            keccak256(abi.encodePacked(bio)) == keccak256(abi.encodePacked(""))
        ) {
            votersList.push(
                VoterStruct(
                    userStructsMapping[fullName],
                    userStructsMapping[fullName].index
                )
            );
        } else if (
            keccak256(abi.encodePacked(bio)) != keccak256(abi.encodePacked("")) &&
            keccak256(abi.encodePacked(profilePicture)) != keccak256(abi.encodePacked(""))
        ) {
            candidatesList.push(
                CandidateStruct(
                    userStructsMapping[fullName],
                    userStructsMapping[fullName].index,
                    profilePicture,
                    bio
                )
            );
        } else {
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
        string memory fName,
        string memory lName,
        string memory gName
    ) external view returns (UserStruct memory) {
        // if (!isUser(userAddress)) throw;
        require(isUser(fName, lName, gName), "User Does not exist");
        string memory fullName = bytes32ToString(
            keccak256(abi.encodePacked(fName, " ", lName, " ", gName))
        );

        return (userStructsMapping[fullName]);
    }

    function getAllUsers() external view returns (UserStruct[] memory) {
        return userValue;
    }

    function removeUser(
        string memory fName,
        string memory lName,
        string memory gName
    ) external returns (bool success) {
        require(isUser(fName, lName, gName), "User Does not exist");
        string memory fullName = bytes32ToString(
            keccak256(abi.encodePacked(fName, " ", lName, " ", gName))
        );
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
