// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./AAiTElection.sol";
import "./AAiTVoteToken.sol";
import "./AAiTStudent.sol";
import "./AAiTElectionTimer.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract AAiTElectionHandler {
    address private owner;
    address private AAiTVoteTokenAddress;
    address private AAiTStudentAddress;
    address private AAiTElectionTimerAddress;
    string[] private deptTypes = [
        "Biomedical Engineering",
        "Chemical Engineering",
        "Civil Engineering",
        "Electrical Engineering",
        "Mechanical Engineering",
        "Software Engineering"
    ];

    AAiTElection.ElectionStruct[] private pendingElections;
    // address private AAiTElectionAddress;

    event LogNewElection(AAiTElection.ElectionStruct election);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    AAiTElectionTimer electionTimer;
    AAiTStudent student;
    AAiTVoteToken voteToken;
    AAiTElection election;

    constructor(
        address _AAiTVoteTokenAddress,
        address _AAiTStudentAddress,
        address _AAiTElectionTimerAddress,
        address _AAiTElectionAddress
    ) {
        owner = msg.sender;
        // AAiTVoteTokenAddress = _AAiTVoteTokenAddress;
        // AAiTStudentAddress = _AAiTStudentAddress;
        // AAiTElectionTimerAddress = _AAiTElectionTimerAddress;
        // AAiTElectionAddress = _AAiTElectionAddress;

        electionTimer = AAiTElectionTimer(_AAiTElectionTimerAddress);
        student = AAiTStudent(_AAiTStudentAddress);
        voteToken = AAiTVoteToken(_AAiTVoteTokenAddress);
        election = AAiTElection(_AAiTElectionAddress);
    }

    function createElection(
        uint256 index,
        uint256 startDate,
        uint256 endDate,
        uint256 year,
        uint256 section,
        AAiTElection.DEPTARTMENT_TYPE department
    ) public onlyOwner returns (AAiTElection.ElectionStruct memory) {
        address[] memory empty;

        if (year == 0 && section == 0) {
            // string memory name = AAiTElectionLibrary.bytes32ToString(
            //     keccak256(
            //         abi.encodePacked(
            //             deptTypes[department]
            //             // " Year ",
            //             // Strings.toString(year),
            //             // " Section ",
            //             // Strings.toString(section)
            //         )
            //     )
            // );
            AAiTElection.ElectionStruct[] memory allElections = election
                .getAllElections();

            AAiTElection.ElectionStruct memory electionStruct = AAiTElection
                .ElectionStruct(
                    index,
                    deptTypes[uint256(department)],
                    AAiTElection.ELECTION_TYPE.ONGOING,
                    startDate,
                    endDate,
                    mergeCandidates(year, section, department, allElections),
                    empty,
                    generateVotersForElection(year, section, department),
                    empty,
                    year,
                    section,
                    department
                );
            emit LogNewElection(electionStruct);

            return electionStruct;
        } else if (section == 0) {
            string memory name = AAiTElectionLibrary.bytes32ToString(
                keccak256(
                    abi.encodePacked(
                        deptTypes[uint256(department)],
                        " Year ",
                        Strings.toString(year)
                    )
                )
            );
            AAiTElection.ElectionStruct[] memory allElections = election
                .getAllElections();

            AAiTElection.ElectionStruct memory electionStruct = AAiTElection
                .ElectionStruct(
                    index,
                    name,
                    AAiTElection.ELECTION_TYPE.ONGOING,
                    startDate,
                    endDate,
                    mergeCandidates(year, section, department, allElections),
                    empty,
                    generateVotersForElection(year, section, department),
                    empty,
                    year,
                    section,
                    department
                );
            emit LogNewElection(electionStruct);

            return electionStruct;
        } else if (year != 0 && section != 0) {
            string memory name = AAiTElectionLibrary.bytes32ToString(
                keccak256(
                    abi.encodePacked(
                        deptTypes[uint256(department)],
                        " Year ",
                        Strings.toString(year),
                        " Section ",
                        Strings.toString(section)
                    )
                )
            );
            AAiTElection.ElectionStruct memory electionStruct = AAiTElection
                .ElectionStruct(
                    index,
                    name,
                    AAiTElection.ELECTION_TYPE.ONGOING,
                    startDate,
                    endDate,
                    generateCandidatesForElection(year, section, department),
                    // empty,
                    empty,
                    generateVotersForElection(year, section, department),
                    // empty,
                    empty,
                    year,
                    section,
                    department
                );
            emit LogNewElection(electionStruct);
            return electionStruct;
        } else {
            revert("Invalid Operation");
        }
    }

    function generateElectionsPerPhase() public onlyOwner {
        AAiTElectionTimer.ElectionPhase memory tempPhase = electionTimer
            .getCurrentPhase();
        // AAiTElection.ElectionStruct[] memory allElections = election
        //     .getAllElections();
        if (
            tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.SECTION_ELECTION
        ) {
            for (uint256 i = 0; i < deptTypes.length; i++) {
                for (uint256 j = 1; j < 6; j++) {
                    for (uint256 k = 1; k < 3; k++) {
                        AAiTElection.ElectionStruct
                            memory electionStruct = createElection(
                                pendingElections.length,
                                tempPhase.start,
                                tempPhase.end,
                                j,
                                k,
                                AAiTElection.DEPTARTMENT_TYPE(i)
                            );
                        pendingElections.push(electionStruct);
                    }
                }
            }
            // if (allElections[i].department == department) {
            //     return allElections[i];
            // }
        } else if (
            tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.BATCH_ELECTION
        ) {
            for (uint256 i = 0; i < deptTypes.length; i++) {
                for (uint256 j = 1; j < 6; j++) {
                    // for (uint256 k = 1; k < 3; k++) {
                    AAiTElection.ElectionStruct
                        memory electionStruct = createElection(
                            pendingElections.length,
                            tempPhase.start,
                            tempPhase.end,
                            j,
                            0,
                            AAiTElection.DEPTARTMENT_TYPE(i)
                        );
                    pendingElections.push(electionStruct);
                    // }
                }
                // if (
                //     allElections[i].department == department &&
                //     allElections[i].year == year
                // ) {
                //     return allElections[i];
                // }
            }
        } else if (
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.DEPARTMENT_ELECTION
        ) {
            for (uint256 i = 0; i < deptTypes.length; i++) {
                // if (
                //     allElections[i].department == department &&
                //     allElections[i].year == year &&
                //     allElections[i].section == section
                // ) {
                //     return allElections[i];
                // }

                AAiTElection.ElectionStruct
                    memory electionStruct = createElection(
                        pendingElections.length,
                        tempPhase.start,
                        tempPhase.end,
                        0,
                        0,
                        AAiTElection.DEPTARTMENT_TYPE(i)
                    );
            }
        }
    }

    function burnAllTokens() public onlyOwner {
        // AAiTVoteToken tempToken = AAiTVoteToken(AAiTVoteTokenAddress);
        // AAiTStudent tempStudent = AAiTStudent(AAiTStudentAddress);
        AAiTStudent.CandidateStruct[] memory tempCandidate = student
            .getAllCandidates();
        AAiTStudent.VoterStruct[] memory tempVoter = student.getAllVoters();
        for (uint256 i = 0; i < tempCandidate.length; i++) {
            voteToken.burn(tempCandidate[i].candidateAddress);
        }
        for (uint256 i = 0; i < tempVoter.length; i++) {
            voteToken.burn(tempVoter[i].voterAddress);
        }
        voteToken.burn(owner);
        // temp.burnRemainingTokens(owner);
    }

    function mintAndSendTokens() public onlyOwner {
        // AAiTVoteToken tempToken = AAiTVoteToken(AAiTVoteTokenAddress);
        // AAiTStudent tempStudent = AAiTStudent(AAiTStudentAddress);
        AAiTStudent.VoterStruct[] memory tempVoters = student.getAllVoters();
        uint256 totalTokenCount = tempVoters.length;
        voteToken.mint(tempVoters.length);
        for (uint256 i = 0; i < tempVoters.length; i++) {
            voteToken.transfer(tempVoters[i].voterAddress, 1);
        }
    }

    function generateVotersForElection(
        uint256 year,
        uint256 section,
        AAiTElection.DEPTARTMENT_TYPE department
    ) internal view returns (address[] memory) {
        // AAiTStudent tempStudent = AAiTStudent(AAiTStudentAddress);
        AAiTStudent.VoterStruct[] memory tempVoters = student
            .getAllVoters();
        address[] memory newVoters = new address[](tempVoters.length);
        if (year == 0 && section == 0) {
            for (uint256 i = 0; i < tempVoters.length; i++) {
                if (
                    uint256(
                        tempVoters[i].voterInfo.voterInfo.currentDepartment
                    ) == uint256(department)
                ) {
                    newVoters[i] = tempVoters[i].voterAddress;
                }
            }
        } else if (section == 0) {
            for (uint256 i = 0; i < tempVoters.length; i++) {
                if (
                    tempVoters[i].voterInfo.voterInfo.currentYear == year &&
                    uint256(
                        tempVoters[i].voterInfo.voterInfo.currentDepartment
                    ) ==
                    uint256(department)
                ) {
                    newVoters[i] = tempVoters[i].voterAddress;
                }
            }
        } else {
            for (uint256 i = 0; i < tempVoters.length; i++) {
                if (
                    tempVoters[i].voterInfo.voterInfo.currentYear == year &&
                    tempVoters[i].voterInfo.voterInfo.currentSection ==
                    section &&
                    uint256(
                        tempVoters[i].voterInfo.voterInfo.currentDepartment
                    ) ==
                    uint256(department)
                ) {
                    newVoters[i] = tempVoters[i].voterAddress;
                }
            }
            // }
            return newVoters;
        }
    }

    function generateCandidatesForElection(
        uint256 year,
        uint256 section,
        AAiTElection.DEPTARTMENT_TYPE department
    ) internal view returns (address[] memory) {
        // AAiTStudent tempStudent = AAiTStudent(AAiTStudentAddress);
        AAiTStudent.CandidateStruct[] memory tempCandidates = student
            .getAllCandidates();
        address[] memory newCandidates = new address[](tempCandidates.length);
        // if (year == 0 && section == 0) {
        //     for (uint256 i = 0; i < tempCandidates.length; i++) {
        //         if (
        //             uint256(
        //                 tempCandidates[i].candidateInfo.currentDepartment
        //             ) == uint256(department)
        //         ) {
        //             newCandidates[i] = tempCandidates[i].candidateAddress;
        //         }
        //     }
        // } else if (section == 0) {
        //     for (uint256 i = 0; i < tempCandidates.length; i++) {
        //         if (
        //             tempCandidates[i].candidateInfo.currentYear == year &&
        //             uint256(
        //                 tempCandidates[i].candidateInfo.currentDepartment
        //             ) ==
        //             uint256(department)
        //         ) {
        //             newCandidates[i] = tempCandidates[i].candidateAddress;
        //         }
        //     }
        // } else {
        for (uint256 i = 0; i < tempCandidates.length; i++) {
            if (
                tempCandidates[i].candidateInfo.candidateInfo.currentYear ==
                year &&
                tempCandidates[i].candidateInfo.candidateInfo.currentSection ==
                section &&
                uint256(
                    tempCandidates[i]
                        .candidateInfo
                        .candidateInfo
                        .currentDepartment
                ) ==
                uint256(department)
            ) {
                newCandidates[i] = tempCandidates[i].candidateAddress;
            }
        }
        // }
        return newCandidates;
    }

    function mergeCandidates(
        uint256 year,
        uint256 section,
        AAiTElection.DEPTARTMENT_TYPE department,
        AAiTElection.ElectionStruct[] memory allElections
    ) internal view returns (address[] memory) {
        address[] memory newCandidates = new address[](3);
        // AAiTElection tempElection = AAiTElection(AAiTElectionAddress);
        // AAiTElection.ElectionStruct[] memory allElections = tempElection
        //     .getAllElections();

        if (year == 0 && section == 0) {
            for (uint256 i = 0; i < allElections.length; i++) {
                if (allElections[i].department == department) {
                    // candidates.push(candidates[i].candidateInfo.userAddress);
                    for (
                        uint256 j = 0;
                        j < allElections[i].winners.length;
                        j++
                    ) {
                        newCandidates[j] = allElections[i].winners[j];
                    }
                }
            }
        } else if (section == 0) {
            for (uint256 i = 0; i < allElections.length; i++) {
                if (
                    allElections[i].department == department &&
                    allElections[i].year == year
                ) {
                    // candidates.push(candidates[i].candidateInfo.userAddress);
                    for (
                        uint256 j = 0;
                        j < allElections[i].winners.length;
                        j++
                    ) {
                        newCandidates[j] = allElections[i].winners[j];
                    }
                }
            }
        } else {
            return newCandidates;
        }

        return newCandidates;
    }

    // function mergeVoters(
    //     uint256 year,
    //     uint256 section,
    //     AAiTElection.DEPTARTMENT_TYPE department,
    //     AAiTElection.ElectionStruct[] memory allElections
    // ) internal view returns (address[] memory) {
    //     address[] memory newVoters = new address[](3);
    //     //  AAiTElection tempElection = AAiTElection(AAiTElectionAddress);
    //     // AAiTElection.ElectionStruct[] memory allElections = tempElection
    //     //     .getAllElections();
    //     if (year == 0 && section == 0) {
    //         for (uint256 i = 0; i < allElections.length; i++) {
    //             if (allElections[i].department == department) {
    //                 for (
    //                     uint256 j = 0;
    //                     j < allElections[i].voters.length;
    //                     j++
    //                 ) {
    //                     newVoters[j] = allElections[i].voters[j];
    //                 }
    //             }
    //         }
    //     } else if (section == 0) {
    //         for (uint256 i = 0; i < allElections.length; i++) {
    //             if (
    //                 allElections[i].department == department &&
    //                 allElections[i].year == year
    //             ) {
    //                 for (
    //                     uint256 j = 0;
    //                     j < allElections[i].voters.length;
    //                     j++
    //                 ) {
    //                     newVoters[j] = allElections[i].voters[j];
    //                 }
    //             }
    //         }
    //     } else {
    //         return newVoters;
    //     }

    //     return newVoters;
    // }

    function changeAllLosingCandidatesToVoters(
        AAiTElection.ElectionStruct[] memory allElections
    ) external {
        // AAiTElection tempElection = AAiTElection(AAiTElectionAddress);
        AAiTUser.VoterStruct memory voterInfo;

        for (uint256 i = 0; i < allElections.length; i++) {
            for (uint256 j = 0; j < allElections[i].candidates.length; j++) {
                // allElections[i].voters.push(allElections[i].losingCandidates[j]);
                AAiTStudent.CandidateStruct memory tempCandidate = student
                    .getCandidate(allElections[i].candidates[j]);
                student.removeCandidate(allElections[i].candidates[j]);
                voterInfo.voterInfo = tempCandidate.candidateInfo.candidateInfo;
                voterInfo.vindex = 0;
                student.insertVoter(voterInfo, allElections[i].candidates[j]);
            }
        }
    }

    function endAllOngoingElections() public onlyOwner {
        // ElectionStruct[] memory temp = allElections;
        AAiTElectionTimer.ElectionPhase memory tempPhase = electionTimer
            .getCurrentPhase();
        AAiTElection.ElectionStruct[] memory allElections = election
            .getAllElections();

        if (
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.DEPARTMENT_ELECTION ||
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.SECTION_ELECTION ||
            tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.BATCH_ELECTION
        ) {
            for (uint256 i = 0; i < allElections.length; i++) {
                if (
                    allElections[i].electionType ==
                    AAiTElection.ELECTION_TYPE.ONGOING
                ) {
                    election.declareWinner(allElections[i].name);
                    // endElection(allElections[i].name);
                }
            }
        }
    }
}
