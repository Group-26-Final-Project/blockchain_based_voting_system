// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// import "./Candidate.sol";
// import "./Voter.sol";
import "./AAiTVoteToken.sol";
import "./AAiTStudent.sol";
import "./AAiTElectionTimer.sol";
import "./AAiTElectionHandler.sol";

library AAiTElectionLibrary {
    function contains(address[] memory array, address value)
        internal
        pure
        returns (bool)
    {
        for (uint256 i = 0; i < array.length; i++) {
            if (array[i] == value) {
                return true;
            }
        }
        return false;
    }

    function indexOf(address[] memory array, address value)
        internal
        pure
        returns (uint256)
    {
        for (uint256 i = 0; i < array.length; i++) {
            if (array[i] == value) {
                return i;
            }
        }
        return array.length;
    }

    function findLargest(uint256[] memory array)
        internal
        pure
        returns (uint256)
    {
        uint256 largest = 0;
        for (uint256 i = 0; i < array.length; i++) {
            if (array[i] > largest) {
                largest = array[i];
            }
        }
        return largest;
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
}

contract AAiTElection {
    enum DEPTARTMENT_TYPE {
        BIOMED,
        CHEMICAL,
        CIVIL,
        ELEC,
        MECHANICAL,
        SITE
    }
    enum ELECTION_TYPE {
        PENDING,
        ONGOING,
        COMPLETED
    }
    string[] private deptTypes = [
        "Biomedical Engineering",
        "Chemical Engineering",
        "Civil Engineering",
        "Electrical Engineering",
        "Mechanical Engineering",
        "Software Engineering"
    ];

    struct ElectionStruct {
        uint256 index;
        string name;
        ELECTION_TYPE electionType;
        uint256 startDate;
        uint256 endDate;
        address[] candidates;
        address[] winners;
        address[] voters;
        address[] voted;
        uint256 year;
        uint256 section;
        DEPTARTMENT_TYPE department;
    }

    struct ElectionResultStruct {
        string candidateFullName;
        // string candidateLName;
        // string candidateGName;
        address candidateAddress;
        uint256 votes;
    }

    address private owner;
    // address private AAiTVoteTokenAddress;
    // address private AAiTStudentAddress;
    // address private AAiTElectionTimerAddress;

    mapping(string => ElectionStruct) private electionStructsMapping;
    string[] private electionIndex;
    ElectionStruct[] private electionValue;
    ElectionStruct[] private allElections;
    ElectionStruct[] private midTransistionElections;
    ElectionStruct[] private previousElections;
    AAiTStudent.CandidateStruct[] private blacklistedCandidates;
    address[] tempWinners;

    AAiTElectionHandler electionHandler;
    AAiTElectionTimer electionTimer;
    AAiTStudent student;
    AAiTVoteToken voteToken;

    // event LogNewElection(
    //     uint256 index,
    //     string name,
    //     ELECTION_TYPE electionType,
    //     string startDate,
    //     string endDate,
    //     address[] candidates,
    //     address[] winners,
    //     address[] voters,
    //     address[] voted,
    //     uint256 year,
    //     uint256 section,
    //     DEPTARTMENT_TYPE department
    // );
    // event LogUpdateElection(
    //     uint256 index,
    //     string name,
    //     ELECTION_TYPE electionType,
    //     string startDate,
    //     string endDate,
    //     address[] candidates,
    //     address[] winners,
    //     address[] voters,
    //     address[] voted,
    //     uint256 year,
    //     uint256 section,
    //     DEPTARTMENT_TYPE department
    // );

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor(
        address _AAiTVoteTokenAddress,
        address _AAiTStudentAddress,
        address _AAiTElectionTimerAddress
    ) {
        owner = msg.sender;
        // AAiTVoteTokenAddress = _AAiTVoteTokenAddress;
        // AAiTStudentAddress = _AAiTStudentAddress;
        // AAiTElectionTimerAddress = _AAiTElectionTimerAddress;
        // electionHandler = AAiTElectionHandler(AAiTElectionHandlerAddress);
        electionTimer = AAiTElectionTimer(_AAiTElectionTimerAddress);
        student = AAiTStudent(_AAiTStudentAddress);
        voteToken = AAiTVoteToken(_AAiTVoteTokenAddress);
    }

    // ELECTION FUNCTIONS

    function findElectionByName(string memory _name)
        private
        view
        returns (bool)
    {
        for (uint256 i = 0; i < allElections.length; i++) {
            if (
                keccak256(abi.encodePacked(allElections[i].name)) ==
                keccak256(abi.encodePacked(_name))
            ) {
                return true;
            }
        }
        return false;
    }

    function findElectionByType(
        uint256 year,
        uint256 section,
        DEPTARTMENT_TYPE department
    ) private view returns (bool) {
        for (uint256 i = 0; i < allElections.length; i++) {
            if (
                allElections[i].year == year &&
                allElections[i].section == section &&
                keccak256(abi.encodePacked(allElections[i].department)) ==
                keccak256(abi.encodePacked(department))
            ) {
                return true;
            }
        }
        return false;
    }

    // function addElection(
    //     string memory name,
    //     ELECTION_TYPE electionType,
    //     string memory startDate,
    //     string memory endDate,
    //     address[] memory candidates,
    //     address[] memory voters,
    //     uint256 year,
    //     uint256 section,
    //     DEPTARTMENT_TYPE department
    // ) public {
    //     require(
    //         !findElectionByName(name) ||
    //             !findElectionByType(year, section, department),
    //         "exists"
    //     );

    //     uint256 index = allElections.length;
    //     address[] memory empty;
    //     electionStructsMapping[name] = ElectionStruct(
    //         allElections.length,
    //         name,
    //         electionType,
    //         startDate,
    //         endDate,
    //         candidates,
    //         empty,
    //         voters,
    //         empty,
    //         year,
    //         section,
    //         department
    //     );
    //     allElections.push(
    //         ElectionStruct({
    //             index: allElections.length,
    //             name: name,
    //             electionType: electionType,
    //             startDate: startDate,
    //             endDate: endDate,
    //             candidates: candidates,
    //             winners: empty,
    //             voters: voters,
    //             voted: empty,
    //             year: year,
    //             section: section,
    //             department: department
    //         })
    //     );
    // }

    function setElectionHandler (address _AAiTElectionHandlerAddress) public onlyOwner {
        electionHandler = AAiTElectionHandler(_AAiTElectionHandlerAddress);
    }

    function retrieveElections() public {
        // allElections = ;
        delete allElections;
        delete electionIndex;
        delete electionValue;
        // delete electionStructsMapping;
        ElectionStruct[] memory temp = electionHandler.getPendingElections();
        for (uint256 i = 0; i < temp.length; i++) {
            electionStructsMapping[temp[i].name] = temp[i];
            allElections.push(temp[i]);
            electionIndex.push(temp[i].name);
            electionValue.push(temp[i]);
            // electionStructsMapping[allElections[i].name] = allElections[i];
            // electionIndex.push(allElections[i].name);
            // electionValue.push(allElections[i]);
        }
    }

    // function removeElection(string memory name) internal onlyOwner {
    //     require(findElectionByName(name), "No Election");
        // uint256 rowToDelete = electionStructsMapping[name].index;
        // // string memory keyToMove = electionIndex[electionIndex.length - 1];
        // electionIndex[electionStructsMapping[name].index] = electionIndex[
        //     electionIndex.length - 1
        // ];
        // electionStructsMapping[electionIndex[electionIndex.length - 1]]
        //     .index = electionStructsMapping[name].index;

        // electionValue[electionStructsMapping[name].index] = electionValue[
        //     electionValue.length - 1
        // ];
        // electionValue[electionStructsMapping[name].index]
        //     .index = electionStructsMapping[name].index;
        // electionValue.pop();
        // electionIndex.pop();
        // delete allElections[electionStructsMapping[name].index];
        // previousElections.push(
        //     electionStructsMapping[electionIndex[electionIndex.length - 1]]
        // );
        // delete electionStructsMapping[electionIndex[electionIndex.length - 1]];
    // }

    function vote(address voterAddress, address candidateAddress) public {
        // AAiTVoteToken tempToken = AAiTVoteToken(AAiTVoteTokenAddress);
        // AAiTStudent student = AAiTStudent(AAiTStudentAddress);
        AAiTStudent.VoterStruct memory tempVoter = student.getVoter(
            voterAddress
        );
        require(
            voterAddress != candidateAddress &&
                voterAddress != owner &&
                candidateAddress != owner &&
                student.isVoter(
                    // tempVoter.voterInfo.voterInfo.fName,
                    // tempVoter.voterInfo.voterInfo.lName,
                    // tempVoter.voterInfo.voterInfo.gName,
                    voterAddress
                ) &&
                voteToken.balanceOf(voterAddress) > 0 &&
                !AAiTElectionLibrary.contains(
                    getElectionByType(
                        tempVoter.voterInfo.voterInfo.currentYear,
                        tempVoter.voterInfo.voterInfo.currentSection,
                        DEPTARTMENT_TYPE(
                            uint256(
                                tempVoter.voterInfo.voterInfo.currentDepartment
                            )
                        )
                    ).voted,
                    voterAddress
                ),
            "Invalid Operation"
        );

        // require(
        //     ,
        //     "You have already voted"
        // );
        voteToken.transferFrom(voterAddress, candidateAddress, 1);
        // moveToVoted(
        //     voterAddress,
        //     getElectionByType(
        //         tempVoter.voterInfo.voterInfo.currentYear,
        //         tempVoter.voterInfo.voterInfo.currentSection,
        //         DEPTARTMENT_TYPE(
        //             uint256(tempVoter.voterInfo.voterInfo.currentDepartment)
        //         )
        //     ).name
        // );
        string memory tempName = getElectionByType(
            tempVoter.voterInfo.voterInfo.currentYear,
            tempVoter.voterInfo.voterInfo.currentSection,
            DEPTARTMENT_TYPE(
                uint256(tempVoter.voterInfo.voterInfo.currentDepartment)
            )
        ).name;

        electionStructsMapping[tempName].voted.push(voterAddress);
        // delete electionStructsMapping[electionName].voters[index];
        // uint256 index = electionStructsMapping[electionName].index;
        electionValue[electionStructsMapping[tempName].index]
            .voted = electionStructsMapping[tempName].voted;
            allElections[electionStructsMapping[tempName].index]
            .voted = electionStructsMapping[tempName].voted;
    }

    function declareWinner(string memory electionName) public {
        // AAiTVoteToken tempToken = AAiTVoteToken(AAiTVoteTokenAddress);
        ElectionStruct memory temp = electionStructsMapping[electionName];
        delete tempWinners;
        uint256[] memory tempVoteCount = new uint256[](temp.candidates.length);
        for (uint256 i = 0; i < temp.candidates.length; i++) {
            tempVoteCount[i] = voteToken.balanceOf(temp.candidates[i]);
            // tempVoteCount.push(tempToken.balanceOf(temp.candidates[i]));
        }
        uint256 max = AAiTElectionLibrary.findLargest(tempVoteCount);
        for (uint256 i = 0; i < temp.candidates.length; i++) {
            if (tempVoteCount[i] == max) {
                // winners[i] = temp.candidates[i];
                tempWinners.push(temp.candidates[i]);
            }
        }

        temp.winners = tempWinners;
        temp.electionType = ELECTION_TYPE.COMPLETED;

        electionStructsMapping[electionName] = temp;
        electionValue[electionStructsMapping[electionName].index] = temp;
        allElections[electionStructsMapping[electionName].index] = temp;

        // sort candidates
        // uint256[] memory sortedCandidates = temp.candidates;

        // removeElection(electionName);

        // uint256 index = electionStructsMapping[electionName].index;
        // uint256 winnerIndex = electionStructsMapping[electionName].winners.length;
        // electionStructsMapping[electionName].winners.push(electionStructsMapping[electionName].candidates[winnerIndex]);
    }

    function blacklistCandidate(address candidateAddress) public onlyOwner {
        // AAiTStudent student = AAiTStudent(AAiTStudentAddress);
        // AAiTStudent.CandidateStruct memory tempCandidate = student.getCandidate(
        //     candidateAddress
        // );
        blacklistedCandidates.push(student.getCandidate(candidateAddress));
        // ElectionStruct[] memory tempElection = allElections;
        for (uint256 i = 0; i < allElections.length; i++) {
            if (
                AAiTElectionLibrary.contains(
                    allElections[i].candidates,
                    candidateAddress
                )
            ) {
                delete allElections[i].candidates[
                    AAiTElectionLibrary.indexOf(
                        allElections[i].candidates,
                        candidateAddress
                    )
                ];

                electionStructsMapping[allElections[i].name]
                    .candidates = allElections[i].candidates;

                student.removeCandidate(
                    // tempCandidate.candidateInfo.candidateInfo.fName,
                    // tempCandidate.candidateInfo.candidateInfo.lName,
                    // tempCandidate.candidateInfo.candidateInfo.gName,
                    candidateAddress
                );
            }
        }
    }

    // function endElection(string memory electionName) public onlyOwner {
    //     declareWinner(electionName);
    //     removeElection(electionName);
    // }

    function getElectionResult(string memory electionName)
        public
        view
        returns (ElectionResultStruct[] memory)
    {
        // ElectionStruct memory temp = electionStructsMapping[electionName];
        ElectionResultStruct[] memory result = new ElectionResultStruct[](
            electionStructsMapping[electionName].candidates.length
        );
        // AAiTVoteToken tempToken = AAiTVoteToken(AAiTVoteTokenAddress);
        // AAiTStudent student = AAiTStudent(AAiTStudentAddress);

        for (
            uint256 i = 0;
            i < electionStructsMapping[electionName].candidates.length;
            i++
        ) {
            AAiTStudent.CandidateStruct memory tempCandidate = student
                .getCandidate(
                    electionStructsMapping[electionName].candidates[i]
                );
            ElectionResultStruct memory tempResult = ElectionResultStruct(
                tempCandidate.candidateInfo.candidateInfo.fullName,
                // tempCandidate.candidateInfo.candidateInfo.lName,
                // tempCandidate.candidateInfo.candidateInfo.gName,
                electionStructsMapping[electionName].candidates[i],
                voteToken.balanceOf(
                    electionStructsMapping[electionName].candidates[i]
                )
            );
            result[i] = tempResult;
        }
        return result;
    }

    function goToNextPhase() public onlyOwner {
        AAiTElectionTimer.ElectionPhase memory tempPhase = electionTimer
            .getCurrentPhase();
        if (tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.REGISTRATION) {
            electionTimer.changePhase();
            // electionTimer.goToNextPhase();
        } else if (
            tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.REGISTRATION_BREAK
        ) {
            electionTimer.changePhase();
            // electionHandler.generateElectionsPerPhase();
            // retrieveElections();
            // electionHandler.mintAndSendTokens();


        } else if (
            tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.SECTION_ELECTION
        ) {
            electionTimer.changePhase();
            electionHandler.endAllOngoingElections();
            electionHandler.burnAllTokens();
        }
        else if (
            tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.SECTION_ELECTION_BREAK
        ) {
            electionTimer.changePhase();
            retrieveElections();
           electionHandler.mintAndSendTokens();

        } else if (
            tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.BATCH_ELECTION
        ) {
            electionTimer.changePhase();
            electionHandler.endAllOngoingElections();
            electionHandler.burnAllTokens();
        }
        else if (
            tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.BATCH_ELECTION_BREAK
        ) {
            electionTimer.changePhase();
            retrieveElections();
           electionHandler.mintAndSendTokens();

        } else if (
            tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.DEPARTMENT_ELECTION
        ) {
            electionTimer.changePhase();
            electionHandler.endAllOngoingElections();
            electionHandler.burnAllTokens();
        }
        else if (
            tempPhase.phaseName == AAiTElectionTimer.PHASE_NAME.COMPLETED
        ) {
            electionTimer.changePhase();
        }
        else{
            revert("Invalid Operation");
        }
    }


    // function moveToVoted(address voterAddress, string memory electionName)
    //     private
    // {
    //     // uint256 index = electionStructsMapping[electionName].index;

    //     electionStructsMapping[electionName].voted.push(voterAddress);
    //     // delete electionStructsMapping[electionName].voters[index];
    //     // uint256 index = electionStructsMapping[electionName].index;
    //     electionValue[electionStructsMapping[electionName].index]
    //         .voted = electionStructsMapping[electionName].voted;
    //     // emit LogUpdateElection(
    //     //     index,
    //     //     electionStructsMapping[electionName].name,
    //     //     electionStructsMapping[electionName].electionType,
    //     //     electionStructsMapping[electionName].startDate,
    //     //     electionStructsMapping[electionName].endDate,
    //     //     electionStructsMapping[electionName].candidates,
    //     //     electionStructsMapping[electionName].winners,
    //     //     electionStructsMapping[electionName].voters,
    //     //     electionStructsMapping[electionName].voted,
    //     //     electionStructsMapping[electionName].year,
    //     //     electionStructsMapping[electionName].section,
    //     //     electionStructsMapping[electionName].department
    //     // );
    // }

    // GET FUNCTIONS

    function getAllElections() public view returns (ElectionStruct[] memory) {
        return allElections;
    }

    function getElectionByName(string memory electionName)
        public
        view
        returns (ElectionStruct memory)
    {
        return electionStructsMapping[electionName];
    }

    function getElectionByType(
        uint256 year,
        uint256 section,
        AAiTElection.DEPTARTMENT_TYPE department
    ) public view returns (AAiTElection.ElectionStruct memory result) {
        // AAiTElectionTimer electionTimer = AAiTElectionTimer(
        //     AAiTElectionTimerAddress
        // );
        // AAiTElection tempElection = AAiTElection(AAiTElectionAddress);
        // AAiTElection.ElectionStruct[] memory allElections = tempElection
        //     .getAllElections();
        AAiTElectionTimer.ElectionPhase memory tempPhase = electionTimer
            .getCurrentPhase();
        if (
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.DEPARTMENT_ELECTION 
            // ||
            // tempPhase.phaseName ==
            // AAiTElectionTimer.PHASE_NAME.DEPARTMENT_ELECTION_DONE
        ) {
            for (uint256 i = 0; i < allElections.length; i++) {
                if (allElections[i].department == department) {
                    return allElections[i];
                }
            }
        } else if (
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.BATCH_ELECTION 
            // ||
            // tempPhase.phaseName ==
            // AAiTElectionTimer.PHASE_NAME.BATCH_ELECTION_DONE
        ) {
            for (uint256 i = 0; i < allElections.length; i++) {
                if (
                    allElections[i].department == department &&
                    allElections[i].year == year
                ) {
                    return allElections[i];
                }
            }
        } else if (
            tempPhase.phaseName ==
            AAiTElectionTimer.PHASE_NAME.SECTION_ELECTION 
            // ||
            // tempPhase.phaseName ==
            // AAiTElectionTimer.PHASE_NAME.SECTION_ELECTION_DONE
        ) {
            for (uint256 i = 0; i < allElections.length; i++) {
                if (
                    allElections[i].department == department &&
                    allElections[i].year == year &&
                    allElections[i].section == section
                ) {
                    return allElections[i];
                }
            }
        } else {
            revert("Invalid Operation");
        }
    }
}
