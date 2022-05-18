// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./AAiTElection.sol";
import "./AAiTVoteToken.sol";
import "./AAiTStudent.sol";
import "./AAiTElectionTimer.sol";

contract AAiTElectionHandler{
 address private owner;
    address private AAiTVoteTokenAddress;
    address private AAiTStudentAddress;
    address private AAiTElectionTimerAddress;
    // address private AAiTElectionAddress;

     modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }


    constructor(
        address _AAiTVoteTokenAddress,
        address _AAiTStudentAddress,
        address _AAiTElectionTimerAddress
        // address _AAiTElectionAddress
    ) {
        owner = msg.sender;
        AAiTVoteTokenAddress = _AAiTVoteTokenAddress;
        AAiTStudentAddress = _AAiTStudentAddress;
        AAiTElectionTimerAddress = _AAiTElectionTimerAddress;
        // AAiTElectionAddress = _AAiTElectionAddress;
    }
    function burnAllTokens() public onlyOwner {
        AAiTVoteToken tempToken = AAiTVoteToken(AAiTVoteTokenAddress);
        AAiTStudent tempStudent = AAiTStudent(AAiTStudentAddress);
        AAiTStudent.CandidateStruct[] memory tempCandidate = tempStudent.getAllCandidates();
        AAiTStudent.VoterStruct[] memory tempVoter = tempStudent.getAllVoters();
        for (uint256 i = 0; i < tempCandidate.length; i++) {
            tempToken.burn(tempCandidate[i].candidateAddress);
        }
        for (uint256 i = 0; i < tempVoter.length; i++) {
            tempToken.burn(tempVoter[i].voterAddress);
        }
        tempToken.burn(owner);
        // temp.burnRemainingTokens(owner);
    }

    function mintAndSendTokens() public onlyOwner {
        AAiTVoteToken tempToken = AAiTVoteToken(AAiTVoteTokenAddress);
        AAiTStudent tempStudent = AAiTStudent(AAiTStudentAddress);
        AAiTStudent.VoterStruct[] memory tempVoters = tempStudent
            .getAllVoters();
        uint256 totalTokenCount = tempVoters.length;
        tempToken.mint(tempVoters.length);
        for (uint256 i = 0; i < tempVoters.length; i++) {
            tempToken.transfer(tempVoters[i].voterAddress, 1);
        }
    }

    function generateVotersForElection(
        uint256 year,
        uint256 section,
        AAiTElection.DEPTARTMENT_TYPE department
    ) internal view returns (address[] memory) {
        AAiTStudent tempStudent = AAiTStudent(AAiTStudentAddress);
        AAiTStudent.VoterStruct[] memory tempVoters = tempStudent
            .getAllVoters();
        address[] memory newVoters = new address[](tempVoters.length);
        // if (year == 0 && section == 0) {
        //     for (uint256 i = 0; i < tempVoters.length; i++) {
        //         if (
        //             uint256(tempVoters[i].voterInfo.currentDepartment) ==
        //             uint256(department)
        //         ) {
        //             newVoters[i] = tempVoters[i].voterAddress;
        //         }
        //     }
        // } else if (section == 0) {
        //     for (uint256 i = 0; i < tempVoters.length; i++) {
        //         if (
        //             tempVoters[i].voterInfo.currentYear == year &&
        //             uint256(tempVoters[i].voterInfo.currentDepartment) ==
        //             uint256(department)
        //         ) {
        //             newVoters[i] = tempVoters[i].voterAddress;
        //         }
        //     }
        // } else {
            for (uint256 i = 0; i < tempVoters.length; i++) {
                if (
                    tempVoters[i].voterInfo.voterInfo.currentYear == year &&
                    tempVoters[i].voterInfo.voterInfo.currentSection == section &&
                    uint256(tempVoters[i].voterInfo.voterInfo.currentDepartment) ==
                    uint256(department)
                ) {
                    newVoters[i] = tempVoters[i].voterAddress;
                }
            }
        // }
        return newVoters;
    }

    function generateCandidatesForElection(
        uint256 year,
        uint256 section,
        AAiTElection.DEPTARTMENT_TYPE department
    ) internal view returns (address[] memory) {
        AAiTStudent tempStudent = AAiTStudent(AAiTStudentAddress);
        AAiTStudent.CandidateStruct[] memory tempCandidates = tempStudent
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
                    tempCandidates[i].candidateInfo.candidateInfo.currentYear == year &&
                    tempCandidates[i].candidateInfo.candidateInfo.currentSection == section &&
                    uint256(
                        tempCandidates[i].candidateInfo.candidateInfo.currentDepartment
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

    function mergeVoters(
        uint256 year,
        uint256 section,
        AAiTElection.DEPTARTMENT_TYPE department,
        AAiTElection.ElectionStruct[] memory allElections
    ) internal view returns (address[] memory) {
        address[] memory newVoters = new address[](3);
        //  AAiTElection tempElection = AAiTElection(AAiTElectionAddress);
        // AAiTElection.ElectionStruct[] memory allElections = tempElection
        //     .getAllElections();
        if (year == 0 && section == 0) {
            for (uint256 i = 0; i < allElections.length; i++) {
                if (allElections[i].department == department) {
                    for (
                        uint256 j = 0;
                        j < allElections[i].voters.length;
                        j++
                    ) {
                        newVoters[j] = allElections[i].voters[j];
                    }
                }
            }
        } else if (section == 0) {
            for (uint256 i = 0; i < allElections.length; i++) {
                if (
                    allElections[i].department == department &&
                    allElections[i].year == year
                ) {
                    for (
                        uint256 j = 0;
                        j < allElections[i].voters.length;
                        j++
                    ) {
                        newVoters[j] = allElections[i].voters[j];
                    }
                }
            }
        } else {
            return newVoters;
        }

        return newVoters;
    }


}