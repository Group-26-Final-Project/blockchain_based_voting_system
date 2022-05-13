// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract AAiTElectionTimer {
    uint256 private end;
    address public immutable owner;
    string private val;

    enum PHASE_NAME {
        REGISTRATION,
        SECTION_ELECTION,
        SECTION_ELECTION_BREAK,
        BATCH_ELECTION,
        BATCH_ELECTION_BREAK,
        DEPARTMENT_ELECTION,
        COMPLETED
    }

    struct ElectionPhase {
        PHASE_NAME phaseName;
        uint256 start;
        uint256 end;
    }

    ElectionPhase public phase;

    event LogCurrentElectionPhase(string currentPhase);

    constructor() {
        owner = msg.sender;
        phase = ElectionPhase(PHASE_NAME.COMPLETED, 0, 0);
        // val = "unos";
    }

    // function changeVal(string memory _newVal) internal {
    //     require(msg.sender == owner, "Only the owner can change the value");
    //     val = _newVal;
    //     // IERC20(token).transferFrom(msg.sender, address(this), amount);
    // }

    function getPhaseEnd() public view returns (uint256) {
        return end;
    }

    function setPhaseEnd(uint256 _newEnd) public {
        end = _newEnd;
    }

    function changePhase(uint256 _newEnd) internal {
        require(msg.sender == owner, "Only the owner can change the phase");

        if (phase.phaseName == PHASE_NAME.DEPARTMENT_ELECTION) {
            phase = ElectionPhase(PHASE_NAME.COMPLETED, 0, 0);
            // changeVal("unos");
            return;
        }
        phase.phaseName = PHASE_NAME(uint256(phase.phaseName) + 1);
        phase.start = block.timestamp;
        phase.end = block.timestamp + _newEnd;
    }

    function getRemainingTime() external view returns (uint256) {
        return phase.end - block.timestamp;
    }

    // function getVal() public view returns (string memory) {
    //     return val;
    // }

    // function getCurrentPhase()
    //     internal
    //     view
    //     returns (string memory)
    // {
    //     if (phase.phaseName == PHASE_NAME.INITIAL) {
    //         return "ON INITIAL";
    //     } else if (phase.phaseName == PHASE_NAME.INITIAL_BREAK) {
    //         return "ON INITIAL_BREAK";
    //     } else if (phase.phaseName == PHASE_NAME.MIDDLE) {
    //         return "ON MIDDLE";
    //     } else if (phase.phaseName == PHASE_NAME.MIDDLE_BREAK) {
    //         return "ON MIDDLE_BREAK";
    //     } else if (phase.phaseName == PHASE_NAME.FINAL) {
    //         return "ON FINAL";
    //     }
    //     return "ON UNKNOWN";
    // }

    function getCurrentPhase() public returns (ElectionPhase memory){
        return checkCurrentPhase();
    }

    function checkCurrentPhase() internal returns (ElectionPhase memory) {
        // require(msg.sender == owner, "only owner");
        if (phase.phaseName == PHASE_NAME.REGISTRATION) {
            if (block.timestamp >= phase.end) {
                // return "ON REGISTRATION";
                return phase;
            }
            changePhase(20);
            // return "SECTION ELECTION INITIATED";
            return phase;

            // changeVal("initial phase");
        } else if (phase.phaseName == PHASE_NAME.SECTION_ELECTION) {
            if (block.timestamp >= phase.end) {
                // return "ON SECTION_ELECTION";
                return phase;
            }
            changePhase(20);
            // return "SECTION ELECTION DONE";
            return phase;
        } else if (phase.phaseName == PHASE_NAME.SECTION_ELECTION_BREAK) {
            if (block.timestamp >= phase.end) {
                // return "ON SECTION ELECTION BREAK";
                return phase;
            }
            changePhase(20);
            // return "BATCH ELECTION INITIATED";
            return phase;

            // changeVal("initial phase");
        } else if (phase.phaseName == PHASE_NAME.BATCH_ELECTION) {
            if (block.timestamp >= phase.end) {
                // return "ON BATCH ELECTION";
            }
            changePhase(20);
            return phase;
            // return "BATCH ELECTION DONE";
        } else if (phase.phaseName == PHASE_NAME.BATCH_ELECTION_BREAK) {
            if (block.timestamp >= phase.end) {
                return phase;
                // return "ON BATCH ELECTION BREAK";
            }
            changePhase(20);
            return phase;
            // return "DEPARTMENT ELECTION INITIATED";
            // changeVal("initial phase");
        } else if (phase.phaseName == PHASE_NAME.DEPARTMENT_ELECTION) {
            if (block.timestamp >= phase.end) {
                return phase;
                // return "ON DEPARTMENT ELECTION";
            }
            changePhase(0);
            return phase;
            // return "DEPARTMENT ELECTION DONE";
        } else {
            phase = ElectionPhase(PHASE_NAME.COMPLETED, 0, 0);

            // return "UNKNOWN PHASE";
            return phase;
        }
        // changeVal("to this");
        // if(token == address(0)) {
        //   owner.transfer(amount);
        // } else {
        //   IERC20(token).transfer(owner, amount);
        // }
    }
}