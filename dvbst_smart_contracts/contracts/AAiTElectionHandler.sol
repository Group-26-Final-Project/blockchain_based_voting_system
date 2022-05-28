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
    address private AAiTElectionAddress;
    string[] private deptTypes = [
        "Biomedical Engineering",
        "Chemical Engineering",
        "Civil Engineering",
        "Electrical Engineering",
        "Mechanical Engineering",
        "Software Engineering"
    ];

    AAiTElection.ElectionStruct[] private pendingElections;
    // AAiTElection.ElectionStruct private mukeraElection;
    // address private AAiTElectionAddress;

    event LogNewElection(AAiTElection.ElectionStruct election);

    // struct electionInputValues {
    //     uint256 index;
    //     uint256 startDate;
    //     uint256 endDate;
    //     uint256 year;
    //     uint256 section;
    //     AAiTElection.DEPTARTMENT_TYPE department;
    // }

    // electionInputValues[] private electionInputs;
    address[] newVoters;
    address[] newCandidates;

    modifier onlyOwner() {
        require(
            msg.sender == owner || msg.sender == AAiTElectionAddress,
            "not owner"
        );
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
        AAiTElectionAddress = _AAiTElectionAddress;
    }

    function createElection(
        uint256 index,
        uint256 startDate,
        uint256 endDate,
        uint256 year,
        uint256 section,
        AAiTElection.DEPTARTMENT_TYPE department
    ) public returns (AAiTElection.ElectionStruct memory newElection) {
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

            // AAiTElection.ElectionStruct memory electionStruct = AAiTElection
            return
                AAiTElection.ElectionStruct(
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
            // emit LogNewElection(electionStruct);

            // return electionStruct;
        } else if (section == 0) {
            string memory name = string(
                abi.encodePacked(
                    deptTypes[uint256(department)],
                    " Year ",
                    Strings.toString(year)
                )
            );
            AAiTElection.ElectionStruct[] memory allElections = election
                .getAllElections();

            // AAiTElection.ElectionStruct memory electionStruct = AAiTElection
            return
                AAiTElection.ElectionStruct(
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
            // emit LogNewElection(electionStruct);

            // return electionStruct;
        } else if (year != 0 && section != 0) {
            // electionInputs.push(
            //     electionInputValues(
            //         index,
            //         startDate,
            //         endDate,
            //         year,
            //         section,
            //         department
            //     )
            // );
            string memory name = string(
                abi.encodePacked(
                    deptTypes[uint256(department)],
                    " Year ",
                    Strings.toString(year),
                    " Section ",
                    Strings.toString(section)
                )
            );
            // AAiTElection.ElectionStruct memory electionStruct = AAiTElection
            return
                AAiTElection.ElectionStruct(
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
            // emit LogNewElection(electionStruct);
            // return electionStruct;
        } else {
            revert("Invalid Operation");
        }
    }

    function generateElectionsPerPhase() public {
        AAiTElectionTimer.ElectionPhase memory tempPhase = electionTimer
            .getCurrentPhase();
        delete pendingElections;
        // AAiTElection.ElectionStruct[] memory allElections = election
        //     .getAllElections();
        if (
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.SECTION_ELECTION ||
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.REGISTRATION_BREAK
        ) {
            for (uint256 i = 0; i < deptTypes.length; i++) {
                for (uint256 j = 1; j < 2; j++) {
                    for (uint256 k = 1; k < 2; k++) {
                        // AAiTElection.ElectionStruct
                        //     memory electionStruct = ;

                        pendingElections.push(
                            createElection(
                                pendingElections.length,
                                tempPhase.start,
                                tempPhase.end,
                                j,
                                k,
                                AAiTElection.DEPTARTMENT_TYPE(i)
                            )
                        );
                    }
                }
            }
            // if (allElections[i].department == department) {
            //     return allElections[i];
            // }
        } else if (
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.BATCH_ELECTION ||
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.SECTION_ELECTION_BREAK
        ) {
            // changeAllLosingCandidatesToVoters(election.getAllElections());
            for (uint256 i = 0; i < deptTypes.length; i++) {
                for (uint256 j = 1; j < 2; j++) {
                    // for (uint256 k = 1; k < 3; k++) {
                    // AAiTElection.ElectionStruct
                    //     memory electionStruct = ;
                    pendingElections.push(
                        createElection(
                            pendingElections.length,
                            tempPhase.start,
                            tempPhase.end,
                            j,
                            0,
                            AAiTElection.DEPTARTMENT_TYPE(i)
                        )
                    );
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
            AAiTElectionTimer.PHASE_NAME.DEPARTMENT_ELECTION ||
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.BATCH_ELECTION_BREAK
        ) {
            // changeAllLosingCandidatesToVoters(election.getAllElections());

            for (uint256 i = 0; i < deptTypes.length; i++) {
                // if (
                //     allElections[i].department == department &&
                //     allElections[i].year == year &&
                //     allElections[i].section == section
                // ) {
                //     return allElections[i];
                // }

                // AAiTElection.ElectionStruct
                //     memory electionStruct = ;
                pendingElections.push(
                    createElection(
                        pendingElections.length,
                        tempPhase.start,
                        tempPhase.end,
                        0,
                        0,
                        AAiTElection.DEPTARTMENT_TYPE(i)
                    )
                );
            }
        }
        // return pendingElections;mukera
    }

    // function getMukeraElection()
    //     public
    //     view
    //     returns (AAiTElection.ElectionStruct memory)
    // {
    //     return mukeraElection;
    // }

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
        // uint256 totalTokenCount = tempVoters.length;
        voteToken.mint(tempVoters.length);
        for (uint256 i = 0; i < tempVoters.length; i++) {
            voteToken.transfer(tempVoters[i].voterAddress, 1);
        }
    }

    // function goToNextPhase() public {
    //     AAiTElectionTimer.ElectionPhase memory tempPhase = electionTimer
    //         .getCurrentPhase();
    //     if (tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.REGISTRATION) {
    //         electionTimer.changePhase();
    //         mintAndSendTokens();
    //         // electionTimer.goToNextPhase();
    //     } else if (
    //         tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.REGISTRATION_BREAK
    //     ) {
    //         electionTimer.changePhse();

    //     } else if (
    //         tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.DEPARTMENT_ELECTION
    //     ) {
    //         electionTimer.goToNextPhase();
    //     }
    //     else if (
    //         tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.COMPLETED
    //     ) {
    //         electionTimer.changePhase();
    //     }
    // }

    function generateVotersForElection(
        uint256 year,
        uint256 section,
        AAiTElection.DEPTARTMENT_TYPE department
    ) internal returns (address[] memory generatedVoters) {
        // AAiTStudent tempStudent = AAiTStudent(AAiTStudentAddress);
        // newVoters = address[];
        delete newVoters;
        AAiTStudent.VoterStruct[] memory tempVoters = student.getAllVoters();
        // address[] memory newVoters = new address[](tempVoters.length);
        if (year == 0 && section == 0) {
            for (uint256 i = 0; i < tempVoters.length; i++) {
                if (
                    uint256(
                        tempVoters[i].voterInfo.voterInfo.currentDepartment
                    ) == uint256(department)
                ) {
                    // newVoters[i] = tempVoters[i].voterAddress;
                    newVoters.push(tempVoters[i].voterAddress);
                }
            }
            return newVoters;

        } else if (section == 0 && year != 0) {
            for (uint256 i = 0; i < tempVoters.length; i++) {
                if (
                    tempVoters[i].voterInfo.voterInfo.currentYear == year &&
                    uint256(
                        tempVoters[i].voterInfo.voterInfo.currentDepartment
                    ) ==
                    uint256(department)
                ) {
                    // newVoters[i] = tempVoters[i].voterAddress;
                    newVoters.push(tempVoters[i].voterAddress);
                }
            }
            return newVoters;

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
                    // newVoters[i] = tempVoters[i].voterAddress;
                    newVoters.push(tempVoters[i].voterAddress);
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
    ) internal returns (address[] memory) {
        // AAiTStudent tempStudent = AAiTStudent(AAiTStudentAddress);
        AAiTStudent.CandidateStruct[] memory tempCandidates = student
            .getAllCandidates();
        // address[] memory newCandidates = new address[](tempCandidates.length);
        // newCandidates = address[];
        delete newCandidates;
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
                // newCandidates[i] = tempCandidates[i].candidateAddress;
                newCandidates.push(tempCandidates[i].candidateAddress);
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
    ) internal returns (address[] memory) {
        // address[] memory newCandidates = new address[](3);
        delete newCandidates;
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
                        // newCandidates[j] = allElections[i].winners[j];
                        newCandidates.push(allElections[i].winners[j]);
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
                        // newCandidates[j] = allElections[i].winners[j];
                        newCandidates.push(allElections[i].winners[j]);
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

    function changeAllLosingCandidatesToVoters()
        public
    // AAiTElection.ElectionStruct[] memory allElections
    {
        // AAiTElection tempElection = AAiTElection(AAiTElectionAddress);
        AAiTUser.VoterStruct memory voterInfo;
        AAiTElection.ElectionStruct[] memory allElections = election
            .getAllElections();

        for (uint256 i = 0; i < allElections.length; i++) {
            for (uint256 j = 0; j < allElections[i].candidates.length; j++) {
                if (
                    !AAiTElectionLibrary.contains(
                        allElections[i].winners,
                        allElections[i].candidates[j]
                    )
                ) {
                    AAiTStudent.CandidateStruct memory tempCandidate = student
                        .getCandidate(allElections[i].candidates[j]);
                    student.removeCandidate(allElections[i].candidates[j]);
                    voterInfo.voterInfo = tempCandidate
                        .candidateInfo
                        .candidateInfo;
                    voterInfo.vindex = 0;
                    student.insertVoter(
                        voterInfo,
                        allElections[i].candidates[j]
                    );
                }
                // allElections[i].voters.push(allElections[i].losingCandidates[j]);
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
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.BATCH_ELECTION ||
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.SECTION_ELECTION_BREAK ||
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.BATCH_ELECTION_BREAK ||
            tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.COMPLETED
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
        } else {
            revert("Invalid Operation");
        }
    }

    function getPendingElections()
        public
        view
        returns (AAiTElection.ElectionStruct[] memory tempPendingElections)
    {
        return pendingElections;
    }

    function getPendingElectionByIndex(uint256 index)
        public
        view
        returns (AAiTElection.ElectionStruct memory tempElection)
    {
        return pendingElections[index];
    }
    // function getElectionInputs()
    //     public
    //     view
    //     returns (electionInputValues[] memory inputs)
    // {
    //     return electionInputs;
    // }
}
