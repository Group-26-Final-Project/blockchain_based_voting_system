// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract AAiTStudent {

    enum DEPTARTMENT_TYPE { SITE, ELEC }

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
        address userAddress;
    }

    struct VoterStruct {
        UserStruct voterInfo;
        uint256 vindex;
        string voterEmail;
        string voterPassword;
    }

    struct CandidateStruct {
        UserStruct candidateInfo;
        uint256 vindex;
        string candidateEmail;
        string candidatePassword;
        string candidateBio;
        string candidateProfilePicture;
    }

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

    // mapping(address => UserStruct) private userStructsMapping;
    // address[] private userIndex;
    // UserStruct[] private userValue;

    // event LogNewUser(
    //     address indexed userAddress,
    //     uint256 index,
    //     string studentId,
    //     string fName,
    //     string lName,
    //     string gName,
    //     uint256 DOB,
    //     uint256 currentYear,
    //     uint256 currentSection,
    //     string currentDepartment
    // );
    // event LogUpdateUser(
    //     address indexed userAddress,
    //     uint256 index,
    //     string studentId,
    //     string fName,
    //     string lName,
    //     string gName,
    //     uint256 DOB,
    //     uint256 currentYear,
    //     uint256 currentSection,
    //     string currentDepartment
    // );
    // event LogDeleteUser(address indexed userAddress, uint256 index);

    mapping(address => CandidateStruct) private candidateStructsMapping;
    address[] private candidateIndex;
    CandidateStruct[] private candidateValue;

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

    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
        // AAiTVoteTokenAddress = _AAiTVoteTokenAddress;
    }

    // function findUserByStudentId(string memory newStudentId)
    //     internal
    //     view
    //     returns (bool)
    // {
    //     for (uint256 i = 0; i < userValue.length; i++) {
    //         if (
    //             keccak256(abi.encodePacked(userValue[i].studentId)) ==
    //             keccak256(abi.encodePacked(newStudentId))
    //         ) {
    //             return true;
    //         }
    //     }
    //     return false;
    // }

    // function findUserByFullName(
    //     string memory newfName,
    //     string memory newlName,
    //     string memory newgName
    // ) internal view returns (bool) {
    //     for (uint256 i = 0; i < userValue.length; i++) {
    //         if (
    //             keccak256(
    //                 abi.encodePacked(
    //                     userValue[i].fName,
    //                     " ",
    //                     userValue[i].lName,
    //                     " ",
    //                     userValue[i].gName
    //                 )
    //             ) ==
    //             keccak256(
    //                 abi.encodePacked(newfName, " ", newlName, " ", newgName)
    //             )
    //         ) {
    //             return true;
    //         }
    //     }
    //     return false;
    // }

    // function isUser(address userAddress) internal view returns (bool) {
    //     if (userIndex.length == 0) return false;
    //     return (userIndex[userStructsMapping[userAddress].index] ==
    //         userAddress);
    // }

    // function insertUser(
    //     address userAddress,
    //     string memory studentId,
    //     string memory fName,
    //     string memory lName,
    //     string memory gName,
    //     uint256 DOB,
    //     uint256 currentYear,
    //     uint256 currentSection,
    //     string memory currentDepartment
    // ) external returns (uint256 index) {
    //     require(userAddress != owner, "Permission Denied");
    //     require(!isUser(userAddress), "User Already Exists");
    //     require(!findUserByStudentId(studentId), "User Already Exists");
    //     require(
    //         !findUserByFullName(fName, lName, gName),
    //         "User Already Exists"
    //     );

    //     userStructsMapping[userAddress].studentId = studentId;
    //     userStructsMapping[userAddress].fName = fName;
    //     userStructsMapping[userAddress].lName = lName;
    //     userStructsMapping[userAddress].gName = gName;
    //     userStructsMapping[userAddress].DOB = DOB;
    //     userStructsMapping[userAddress].currentYear = currentYear;
    //     userStructsMapping[userAddress].currentSection = currentSection;
    //     userStructsMapping[userAddress].currentDepartment = currentDepartment;
    //     userStructsMapping[userAddress].userAddress = userAddress;
    //     userIndex.push(userAddress);
    //     userStructsMapping[userAddress].index = userIndex.length - 1;
    //     userValue.push(
    //         UserStruct(
    //             userStructsMapping[userAddress].index,
    //             studentId,
    //             fName,
    //             lName,
    //             gName,
    //             DOB,
    //             currentYear,
    //             currentSection,
    //             currentDepartment,
    //             userAddress
    //         )
    //     );
    //     emit LogNewUser(
    //         userAddress,
    //         userStructsMapping[userAddress].index,
    //         studentId,
    //         fName,
    //         lName,
    //         gName,
    //         DOB,
    //         currentYear,
    //         currentSection,
    //         currentDepartment
    //     );
    //     return userIndex.length - 1;
    // }

    // function getUser(address userAddress)
    //     external
    //     view
    //     returns (UserStruct memory)
    // {
    //     // if (!isUser(userAddress)) throw;
    //     require(isUser(userAddress), "User Does not exist");

    //     return (userStructsMapping[userAddress]);
    // }

    // function removeUser(address userAddress) external returns (bool success) {
    //     require(isUser(userAddress), "User Does not exist");
    //     // Candidate deployedCandidate = Candidate(candidateContractAddress);
    //     // Voter deployedVoter = Voter(voterContractAddress);

    //     if (isVoter(userAddress)) {
    //         removeVoter(userAddress);
    //     }
    //     if (isCandidate(userAddress)) {
    //         removeCandidate(userAddress);
    //     }

    //     userIndex[userStructsMapping[userAddress].index] = userIndex[userIndex.length - 1];
    //     userStructsMapping[userIndex[userIndex.length - 1]].index = userStructsMapping[userAddress].index;

    //     userValue[userStructsMapping[userAddress].index] = userValue[userValue.length - 1];
    //     userValue[userStructsMapping[userAddress].index].index = userStructsMapping[userAddress].index;
    //     userValue.pop();
    //     userIndex.pop();
    //     delete userStructsMapping[userAddress];
    //     emit LogDeleteUser(userAddress, userStructsMapping[userAddress].index);

    //     return true;
    // }

    // VOTER FUNCTIONS

    function findVoterByStudentId(string memory newStudentId)
        internal
        view
        returns (bool)
    {
        for (uint256 i = 0; i < voterValue.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(voterValue[i].voterInfo.studentId)
                ) == keccak256(abi.encodePacked(newStudentId))
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
        returns (bool)
    {
        for (uint256 i = 0; i < voterValue.length; i++) {
            if (
                keccak256(abi.encodePacked(voterValue[i].voterEmail)) ==
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
    ) internal view returns (bool) {
        for (uint256 i = 0; i < voterValue.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(
                        voterValue[i].voterInfo.fName,
                        " ",
                        voterValue[i].voterInfo.lName,
                        " ",
                        voterValue[i].voterInfo.gName
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

    function isVoter(address userAddress) public view returns (bool) {
        // UserStruct[] memory tempUsers = deployedUser.getAllUsers();
        // require(isUser(userAddress), "User Does not Exist");

        if (voterIndex.length == 0) return false;
        if (candidateIndex.length == 0) return false;
        return (voterIndex[voterStructsMapping[userAddress].vindex] ==
            userAddress);
    }

    function insertVoter(
        UserStruct memory voterInfo,
        string memory email,
        string memory password
    ) public returns (uint256) {
        // if (isUser(userAddress)) throw;
        require(voterInfo.userAddress != owner, "Permission Denied");

        require(!isCandidate(voterInfo.userAddress), "User Already a Candidate");
        require(!isVoter(voterInfo.userAddress), "Voter Already Exists");
        require(
            !findVoterByStudentId(voterInfo.studentId),
            "Voter Already Exists"
        );
        require(!findVoterByEmail(email), "Voter Already Exists");
        require(
            !findVoterByFullName(
                voterInfo.fName,
                voterInfo.lName,
                voterInfo.gName
            ),
            "Voter Already Exists"
        );

        voterStructsMapping[voterInfo.userAddress].voterInfo = voterInfo;
        voterStructsMapping[voterInfo.userAddress].voterEmail = email;
        voterStructsMapping[voterInfo.userAddress].voterPassword = password;

        voterIndex.push(voterInfo.userAddress);
        voterStructsMapping[voterInfo.userAddress].vindex =
            voterIndex.length -
            1;
        voterValue.push(
            VoterStruct(
                voterInfo,
                voterStructsMapping[voterInfo.userAddress].vindex,
                email,
                password
            )
        );
        emit LogNewVoter(voterInfo, email, password);
        return voterIndex.length - 1;
    }

    function removeVoter(address userAddress) external returns (bool success) {
        require(isVoter(userAddress), "Voter Does not exist");
        // uint256 rowToDelete = voterStructsMapping[userAddress].vindex;
        // address keyToMove = voterIndex[voterIndex.length - 1];
        voterIndex[voterStructsMapping[userAddress].vindex] = voterIndex[
            voterIndex.length - 1
        ];
        voterStructsMapping[voterIndex[voterIndex.length - 1]]
            .vindex = voterStructsMapping[userAddress].vindex;

        voterValue[voterStructsMapping[userAddress].vindex] = voterValue[
            voterValue.length - 1
        ];
        voterValue[voterStructsMapping[userAddress].vindex]
            .vindex = voterStructsMapping[userAddress].vindex;
        voterValue.pop();
        voterIndex.pop();
        delete voterStructsMapping[userAddress];

        emit LogDeleteVoter(
            userAddress,
            voterStructsMapping[userAddress].vindex
        );

        return true;
    }

    // CANDIDATE FUNCITONS

    function findCandidateByStudentId(string memory newStudentId)
        internal
        view
        returns (bool isIndeed)
    {
        // CandidateStruct[] memory temp = candidateValue;
        for (uint256 i = 0; i < candidateValue.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(candidateValue[i].candidateInfo.studentId)
                ) == keccak256(abi.encodePacked(newStudentId))
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
        // CandidateStruct[] memory temp = candidateValue;
        for (uint256 i = 0; i < candidateValue.length; i++) {
            if (
                keccak256(abi.encodePacked(candidateValue[i].candidateEmail)) ==
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
        // CandidateStruct[] memory temp = candidateValue;
        for (uint256 i = 0; i < candidateValue.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(
                        candidateValue[i].candidateInfo.fName,
                        " ",
                        candidateValue[i].candidateInfo.lName,
                        " ",
                        candidateValue[i].candidateInfo.gName
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
        // UserStruct[] memory tempUsers = deployedUser.getAllUsers();
        // require(isUser(userAddress), "User Does not Exist");
        if (candidateIndex.length == 0) return false;

        if (voterIndex.length == 0) return false;
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

        require(!isVoter(candidateInfo.userAddress), "User Already a Voter");
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
            !findCandidateByFullName(
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

    function removeCandidate(address userAddress)
        public
        returns (bool success)
    {
        require(isCandidate(userAddress), "Candidate Does not exist");
        // uint256 rowToDelete = candidateStructsMapping[userAddress].vindex;
        // address keyToMove = candidateIndex[candidateIndex.length - 1];
        candidateIndex[
            candidateStructsMapping[userAddress].vindex
        ] = candidateIndex[candidateIndex.length - 1];
        candidateStructsMapping[candidateIndex[candidateIndex.length - 1]]
            .vindex = candidateStructsMapping[userAddress].vindex;

        candidateValue[
            candidateStructsMapping[userAddress].vindex
        ] = candidateValue[candidateValue.length - 1];
        candidateValue[candidateStructsMapping[userAddress].vindex]
            .vindex = candidateStructsMapping[userAddress].vindex;
        candidateValue.pop();
        candidateIndex.pop();
        delete candidateStructsMapping[userAddress];
        emit LogDeleteCandidate(
            userAddress,
            candidateStructsMapping[userAddress].vindex
        );

        return true;
    }

    // function getAllUsers() public view returns (UserStruct[] memory) {
    //     return userValue;
    // }

    function getVoter(address userAddress)
        public
        view
        returns (VoterStruct memory)
    {
        // if (!isUser(userAddress)) throw;
        require(isVoter(userAddress), "Voter Does not exist");

        return (voterStructsMapping[userAddress]);
    }

    function getAllVoters() public view returns (VoterStruct[] memory) {
        return voterValue;
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

    function getAllCandidates() public view returns (CandidateStruct[] memory) {
        return candidateValue;
    }
}
