// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// import "./Candidate.sol";
// import "./Voter.sol";
import "./AAiTVoteToken.sol";
import "./AAiTStudent.sol";

contract AAiTElection {
    struct ElectionStruct {
        uint256 index;
        string name;
        string electionType;
        string startDate;
        string endDate;
        address[] candidates;
        address[] winners;
        address[] voters;
        address[] voted;
        uint256 year;
        uint256 section;
        string department;
    }

    address private owner;
    address private AAiTVoteTokenAddress;
    address private AAiTStudentAddress;

    mapping(string => ElectionStruct) private electionStructsMapping;
    string[] private electionIndex;
    ElectionStruct[] private electionValue;
    ElectionStruct[] private allElections;
    ElectionStruct[] private previousElections;

    event LogNewElection(
        uint256 index,
        string name,
        string electionType,
        string startDate,
        string endDate,
        address[] candidates,
        address[] winners,
        address[] voters,
        address[] voted,
        uint256 year,
        uint256 section,
        string department
    );
    event LogUpdateElection(
        uint256 index,
        string name,
        string electionType,
        string startDate,
        string endDate,
        address[] candidates,
        address[] winners,
        address[] voters,
        address[] voted,
        uint256 year,
        uint256 section,
        string department
    );

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor(address _AAiTVoteTokenAddress, address _AAiTStudentAddress) {
        owner = msg.sender;
        AAiTVoteTokenAddress = _AAiTVoteTokenAddress;
        AAiTStudentAddress = _AAiTStudentAddress;
    }

    // ELECTION FUNCTIONS

    function findElectionByName(string memory _name)
        private
        view
        returns (bool)
    {
        ElectionStruct[] memory temp = allElections;
        for (uint256 i = 0; i < temp.length; i++) {
            if (
                keccak256(abi.encodePacked(temp[i].name)) ==
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
        string memory department
    ) private view returns (bool) {
        ElectionStruct[] memory temp = allElections;
        for (uint256 i = 0; i < temp.length; i++) {
            if (
                temp[i].year == year &&
                temp[i].section == section &&
                keccak256(abi.encodePacked(temp[i].department)) ==
                keccak256(abi.encodePacked(department))
            ) {
                return true;
            }
        }
        return false;
    }

    function addElection(
        string memory name,
        string memory electionType,
        string memory startDate,
        string memory endDate,
        address[] memory candidates,
        address[] memory voters,
        uint256 year,
        uint256 section,
        string memory department
    ) public {
        require(!findElectionByName(name), "Election already exists");
        require(
            !findElectionByType(year, section, department),
            "Election already exists"
        );
        uint256 index = allElections.length;
        address[] memory empty;
        electionStructsMapping[name] = ElectionStruct(
            index,
            name,
            electionType,
            startDate,
            endDate,
            candidates,
            empty,
            voters,
            empty,
            year,
            section,
            department
        );
        allElections.push(
            ElectionStruct({
                index: index,
                name: name,
                electionType: electionType,
                startDate: startDate,
                endDate: endDate,
                candidates: candidates,
                winners: empty,
                voters: voters,
                voted: empty,
                year: year,
                section: section,
                department: department
            })
        );
    }

    function removeElection(string memory name) internal onlyOwner {
        require(
            findElectionByName(name),
            "Election with this name does not exist"
        );
        // uint256 rowToDelete = electionStructsMapping[name].index;
        // string memory keyToMove = electionIndex[electionIndex.length - 1];
        electionIndex[electionStructsMapping[name].index] = electionIndex[
            electionIndex.length - 1
        ];
        electionStructsMapping[electionIndex[electionIndex.length - 1]]
            .index = electionStructsMapping[name].index;

        electionValue[electionStructsMapping[name].index] = electionValue[
            electionValue.length - 1
        ];
        electionValue[electionStructsMapping[name].index]
            .index = electionStructsMapping[name].index;
        electionValue.pop();
        electionIndex.pop();
        delete allElections[electionStructsMapping[name].index];
        previousElections.push(
            electionStructsMapping[electionIndex[electionIndex.length - 1]]
        );
        delete electionStructsMapping[electionIndex[electionIndex.length - 1]];
    }

    function vote(address voterAddress, address candidateAddress) public {
        AAiTVoteToken tempToken = AAiTVoteToken(AAiTVoteTokenAddress);
        AAiTStudent tempStudent = AAiTStudent(AAiTStudentAddress);
        require(voterAddress != candidateAddress, "Permission Denied");
        require(
            voterAddress != owner || candidateAddress != owner,
            "Invalid Operation"
        );
        require(tempStudent.isVoter(voterAddress), "You can not vote");
        require(tempToken.balanceOf(voterAddress) > 0, "Insufficient Token");

        tempToken.transferFrom(voterAddress, candidateAddress, 1);
        moveToVoted(voterAddress, "electionName");
    }

    function burnAllTokens() public onlyOwner {
        AAiTVoteToken temp = AAiTVoteToken(AAiTVoteTokenAddress);
        temp.burnRemainingTokens(owner);
    }

    function declareWinner(string memory electionName, address[] memory winners)
        public
        view
    {
        ElectionStruct memory temp = electionStructsMapping[electionName];
        temp.winners = winners;

        // removeElection(electionName);

        // uint256 index = electionStructsMapping[electionName].index;
        // uint256 winnerIndex = electionStructsMapping[electionName].winners.length;
        // electionStructsMapping[electionName].winners.push(electionStructsMapping[electionName].candidates[winnerIndex]);
    }

    function moveToVoted(address voterAddress, string memory electionName)
        private
    {
        uint256 index = electionStructsMapping[electionName].index;

        electionStructsMapping[electionName].voted.push(voterAddress);
        delete electionStructsMapping[electionName].voters[index];
        // uint256 index = electionStructsMapping[electionName].index;
        electionValue[index] = electionStructsMapping[electionName];
        emit LogUpdateElection(
            index,
            electionStructsMapping[electionName].name,
            electionStructsMapping[electionName].electionType,
            electionStructsMapping[electionName].startDate,
            electionStructsMapping[electionName].endDate,
            electionStructsMapping[electionName].candidates,
            electionStructsMapping[electionName].winners,
            electionStructsMapping[electionName].voters,
            electionStructsMapping[electionName].voted,
            electionStructsMapping[electionName].year,
            electionStructsMapping[electionName].section,
            electionStructsMapping[electionName].department
        );
    }

    // GET FUNCTIONS

    function getAllElections() public view returns (ElectionStruct[] memory) {
        return allElections;
    }
}
