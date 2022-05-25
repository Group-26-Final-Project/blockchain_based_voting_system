// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./AAiTUser.sol";

contract AAiTStudent {
    enum DEPTARTMENT_TYPE {
        SITE,
        ELEC
    }

    struct VoterStruct {
        AAiTUser.VoterStruct voterInfo;
        // uint256 vindex;
        // string voterEmail;
        // string voterPassword;
        address voterAddress;
    }

    struct CandidateStruct {
        AAiTUser.CandidateStruct candidateInfo;
        // uint256 vindex;
        // string candidateEmail;
        // string candidatePassword;
        // string candidateBio;
        // string candidateProfilePicture;
        address candidateAddress;
    }

    mapping(address => VoterStruct) private voterStructsMapping;
    address[] private voterIndex;
    VoterStruct[] private voterValue;

    // event LogNewVoter(
    //     AAiTUser.UserStruct voterInfo,
    //     string voterEmail,
    //     string voterPassword
    // );
    // event LogUpdateVoter(
    //     AAiTUser.UserStruct voterInfo,
    //     string voterEmail,
    //     string voterPassword
    // );
    // event LogDeleteVoter(address indexed userAddress, uint256 index);

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
    address private AAiTUserContractAddress;

    // event LogNewCandidate(
    //     AAiTUser.UserStruct candidateInfo,
    //     string candidateEmail,
    //     string candidatePassword,
    //     string candidateBio,
    //     string candidateProfilePicture
    // );
    // event LogUpdateCandidate(
    //     AAiTUser.UserStruct candidateInfo,
    //     string candidateEmail,
    //     string candidatePassword,
    //     string candidateBio,
    //     string candidateProfilePicture
    // );
    // event LogDeleteCandidate(address indexed userAddress, uint256 index);

    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor(address _AAiTUserContractAddress) {
        owner = msg.sender;
        AAiTUserContractAddress = _AAiTUserContractAddress;
        // AAiTVoteTokenAddress = _AAiTVoteTokenAddress;
    }

    // VOTER FUNCTIONS

    function findVoterByStudentId(string memory newStudentId)
        internal
        view
        returns (bool)
    {
        for (uint256 i = 0; i < voterValue.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(
                        voterValue[i].voterInfo.voterInfo.studentId
                    )
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
                keccak256(
                    abi.encodePacked(voterValue[i].voterInfo.voterInfo.email)
                ) == keccak256(abi.encodePacked(newEmail))
            ) {
                return true;
            }
        }
        return false;
        // return isIndeed;
    }

    // function findVoterByFullName(
    //     // string memory newfName,
    //     // string memory newlName,
    //     string memory newFullName
    // ) internal view returns (bool) {
    //     for (uint256 i = 0; i < voterValue.length; i++) {
    //         if (
    //             keccak256(
    //                 abi.encodePacked(voterValue[i].voterInfo.voterInfo.fullName)
    //             ) == keccak256(abi.encodePacked(newFullName))
    //         ) {
    //             return true;
    //         }
    //     }
    //     return false;
    // }

    function isVoter(
        // string memory newfName,
        // string memory newlName,
        // string memory newgName,
        address userAddress
    ) public view returns (bool) {
        // UserStruct[] memory tempUsers = deployedUser.getAllUsers();
        // AAiTUser deployedUser = AAiTUser(AAiTUserContractAddress);
        // require(
        //     deployedUser.isUser(newfName, newlName, newgName),
        //     "User Does not Exist"
        // );
        if (voterIndex.length == 0) return false;
        if (candidateIndex.length == 0) return false;
        return (voterIndex[voterStructsMapping[userAddress].voterInfo.vindex] ==
            userAddress);
    }

    function insertVoter(
        AAiTUser.VoterStruct memory voterInfo,
        address userAddress
    )
        public
        returns (
            // string memory email,
            // string memory password
            uint256
        )
    {
        // if (isUser(userAddress)) throw;
        require(userAddress != owner, "Permission Denied");

        require(
            !isCandidate(
                // voterInfo.voterInfo.fName,
                // voterInfo.voterInfo.lName,
                // voterInfo.voterInfo.gName,
                userAddress
            ),
            "User Already a Candidate"
        );
        require(
            !isVoter(
                // voterInfo.voterInfo.fName,
                // voterInfo.voterInfo.lName,
                // voterInfo.voterInfo.gName,
                userAddress
            ),
            "Voter Already Exists"
        );
        require(
            !findVoterByStudentId(voterInfo.voterInfo.studentId),
            "Voter Already Exists"
        );
        require(
            !findVoterByEmail(voterInfo.voterInfo.email),
            "Voter Already Exists"
        );
        // require(
        //     !findVoterByFullName(
        //         voterInfo.voterInfo.fullName
        //         // voterInfo.voterInfo.lName,
        //         // voterInfo.voterInfo.gName
        //     ),
        //     "Voter Already Exists"
        // );

        voterStructsMapping[userAddress].voterInfo = voterInfo;
        // voterStructsMapping[userAddress].voterEmail = email;
        // voterStructsMapping[userAddress].voterPassword = password;
        voterStructsMapping[userAddress].voterAddress = userAddress;

        voterIndex.push(userAddress);
        voterStructsMapping[userAddress].voterInfo.vindex =
            voterIndex.length -
            1;
        voterValue.push(VoterStruct(voterInfo, userAddress));
        // emit LogNewVoter(voterInfo, email, password);
        return voterIndex.length - 1;
    }

    function removeVoter(
        // string memory newfName,
        // string memory newlName,
        // string memory newgName,
        address userAddress
    ) external returns (bool success) {
        // require(findVoterByFullName(newfName, newlName, newgName), "Voter Does not Exist");
        require(isVoter(userAddress), "Voter Does not exist");
        // uint256 rowToDelete = voterStructsMapping[userAddress].vindex;
        // address keyToMove = voterIndex[voterIndex.length - 1];
        voterIndex[
            voterStructsMapping[userAddress].voterInfo.vindex
        ] = voterIndex[voterIndex.length - 1];
        voterStructsMapping[voterIndex[voterIndex.length - 1]]
            .voterInfo
            .vindex = voterStructsMapping[userAddress].voterInfo.vindex;

        voterValue[
            voterStructsMapping[userAddress].voterInfo.vindex
        ] = voterValue[voterValue.length - 1];
        voterValue[voterStructsMapping[userAddress].voterInfo.vindex]
            .voterInfo
            .vindex = voterStructsMapping[userAddress].voterInfo.vindex;
        voterValue.pop();
        voterIndex.pop();
        delete voterStructsMapping[userAddress];

        // emit LogDeleteVoter(
        //     userAddress,
        //     voterStructsMapping[userAddress].vindex
        // );

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
                    abi.encodePacked(
                        candidateValue[i].candidateInfo.candidateInfo.studentId
                    )
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
                keccak256(
                    abi.encodePacked(
                        candidateValue[i].candidateInfo.candidateInfo.email
                    )
                ) == keccak256(abi.encodePacked(newEmail))
            ) {
                return true;
            }
        }
        return false;
        // return isIndeed;
    }

    // function findCandidateByFullName(
    //     // string memory newfName,
    //     // string memory newlName,
    //     string memory newfullName
    // ) internal view returns (bool isIndeed) {
    //     // CandidateStruct[] memory temp = candidateValue;
    //     for (uint256 i = 0; i < candidateValue.length; i++) {
    //         if (
    //             keccak256(
    //                 abi.encodePacked(
    //                     candidateValue[i].candidateInfo.candidateInfo.fullName
    //                     )
    //             ) ==
    //             keccak256(
    //                 abi.encodePacked(newfullName)
    //             )
    //         ) {
    //             return true;
    //         }
    //     }
    //     return false;
    // }

    function isCandidate(
        // string memory newfName,
        // string memory newlName,
        // string memory newgName,
        address userAddress
    ) public view returns (bool isIndeed) {
        // UserStruct[] memory tempUsers = deployedUser.getAllUsers();
        // require(isUser(userAddress), "User Does not Exist");
        // AAiTUser deployedUser = AAiTUser(AAiTUserContractAddress);
        // require(
        //     deployedUser.isUser(newfName, newlName, newgName),
        //     "User Does not Exist"
        // );
        if (candidateIndex.length == 0) return false;

        if (voterIndex.length == 0) return false;
        // require(candidateIndex[candidateStructsMapping[userAddress].vindex] ==
        //     userAddress,"index out of bounds error over here");
        return (candidateIndex[
            candidateStructsMapping[userAddress].candidateInfo.vindex
        ] == userAddress);
    }

    function insertCandidate(
        AAiTUser.CandidateStruct memory userInfo,
        // string memory email,
        // string memory password,
        // string memory bio,
        // string memory profilePicture,
        address userAddress
    ) public returns (uint256 index) {
        // if (isUser(userAddress)) throw;
        require(userAddress != owner, "Permission Denied");

        require(
            !isVoter(
                // userInfo.candidateInfo.fName,
                // userInfo.candidateInfo.lName,
                // userInfo.candidateInfo.gName,
                userAddress
            ),
            "User Already a Voter"
        );
        require(
            !isCandidate(
                // userInfo.candidateInfo.fName,
                // userInfo.candidateInfo.lName,
                // userInfo.candidateInfo.gName,
                userAddress
            ),
            "Candidate Already Exists"
        );
        require(
            !findCandidateByStudentId(userInfo.candidateInfo.studentId),
            "Candidate Already Exists"
        );
        require(
            !findCandidateByEmail(userInfo.candidateInfo.email),
            "Candidate Already Exists"
        );
        // require(
        //     !findCandidateByFullName(
        //         userInfo.candidateInfo.fullName
        //         // userInfo.candidateInfo.lName,
        //         // userInfo.candidateInfo.gName
        //     ),
        //     "Candidate Already Exists"
        // );

        candidateStructsMapping[userAddress].candidateInfo = userInfo;
        // candidateStructsMapping[userAddress]
        //     .candidateEmail = email;
        // candidateStructsMapping[userAddress]
        //     .candidatePassword = password;
        // candidateStructsMapping[userAddress].candidateBio = bio;
        // candidateStructsMapping[userAddress].candidateAddress = userAddress;
        // candidateStructsMapping[userAddress]
        //     .candidateProfilePicture = profilePicture;
        // userStructsMapping[userAddress].gName = gName;
        candidateStructsMapping[userAddress].candidateAddress = userAddress;
        candidateIndex.push(userAddress);
        candidateStructsMapping[userAddress].candidateInfo.vindex =
            candidateIndex.length -
            1;
        candidateValue.push(CandidateStruct(userInfo, userAddress));

        //     emit LogNewCandidate(
        //         candidateInfo,
        //         email,
        //         password,
        //         bio,
        //         profilePicture
        //     );
        return candidateIndex.length - 1;
    }

    function removeCandidate(
        // string memory newfName,
        // string memory newlName,
        // string memory newgName,
        address userAddress
    ) public returns (bool success) {
        require(isCandidate(userAddress), "Candidate Does not exist");
        // uint256 rowToDelete = candidateStructsMapping[userAddress].vindex;
        // address keyToMove = candidateIndex[candidateIndex.length - 1];
        candidateIndex[
            candidateStructsMapping[userAddress].candidateInfo.vindex
        ] = candidateIndex[candidateIndex.length - 1];
        candidateStructsMapping[candidateIndex[candidateIndex.length - 1]]
            .candidateInfo
            .vindex = candidateStructsMapping[userAddress].candidateInfo.vindex;

        candidateValue[
            candidateStructsMapping[userAddress].candidateInfo.vindex
        ] = candidateValue[candidateValue.length - 1];
        candidateValue[
            candidateStructsMapping[userAddress].candidateInfo.vindex
        ].candidateInfo.vindex = candidateStructsMapping[userAddress]
            .candidateInfo
            .vindex;
        candidateValue.pop();
        candidateIndex.pop();
        delete candidateStructsMapping[userAddress];
        // emit LogDeleteCandidate(
        //     userAddress,
        //     candidateStructsMapping[userAddress].vindex
        // );

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
        // require(isVoter(userAddress), "Voter Does not exist");

        return (voterStructsMapping[userAddress]);
    }

    function getVoterByEmail(string memory email)
        public
        view
        returns (VoterStruct memory)
    {
        for (uint256 i = 0; i < voterValue.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(voterValue[i].voterInfo.voterInfo.email)
                ) == keccak256(abi.encodePacked(email))
            ) {
                return voterValue[i];
            }
        }
        revert("Not found");
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
        // require(isCandidate(userAddress), "Candidate Does not exist");

        return (candidateStructsMapping[userAddress]);
    }

    function getCandidateByEmail(string memory email)
        public
        view
        returns (CandidateStruct memory)
    {
        for (uint256 i = 0; i < candidateValue.length; i++) {
            if (
                keccak256(
                    abi.encodePacked(
                        candidateValue[i].candidateInfo.candidateInfo.email
                    )
                ) == keccak256(abi.encodePacked(email))
            ) {
                return candidateValue[i];
            }
        }
        revert("Not found");
    }

    function getAllCandidates() public view returns (CandidateStruct[] memory) {
        return candidateValue;
    }

    // function getVoterByType (uint256 year,
    //     uint256 section,
    //     DEPTARTMENT_TYPE department) public view returns (VoterStruct memory) {

    //     // return temp2;
    // }

    function removeAllUsers() public onlyOwner {
        // for (uint256 i = 0; i < voterValue.length; i++) {
        //     delete voterStructsMapping[voterValue[i].voterAddress];
        // }
        // delete voterValue;
        // delete voterIndex;
        // for (uint256 i = 0; i < candidateValue.length; i++) {
        //     delete candidateStructsMapping[candidateValue[i].candidateAddress];
        // }
        // delete candidateValue;
        // delete candidateIndex;
    }
}
