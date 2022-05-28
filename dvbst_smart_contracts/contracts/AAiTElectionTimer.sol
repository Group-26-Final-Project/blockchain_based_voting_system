// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract AAiTElectionTimer {
    uint256 private votingDuration;
    uint256 private breakDuration;
    address public immutable owner;
    string private val;

    enum PHASE_NAME {
        REGISTRATION,
        REGISTRATION_BREAK,
        SECTION_ELECTION,
        SECTION_ELECTION_BREAK,
        BATCH_ELECTION,
        BATCH_ELECTION_BREAK,
        DEPARTMENT_ELECTION,
        COMPLETED       
    }

    //  REGISTRATION,
    //     REGISTRATION_BREAK,
    //     SECTION_ELECTION,
    //     // SECTION_ELECTION_DONE,
    //     SECTION_ELECTION_BREAK,
    //     BATCH_ELECTION,
    //     BATCH_ELECTION_BREAK,
    //     // BATCH_ELECTION_DONE,
    //     DEPARTMENT_ELECTION,
    //     // DEPARTMENT_ELECTION_DONE,
    //     COMPLETED

    struct ElectionPhase {
        PHASE_NAME phaseName;
        uint256 start;
        uint256 end;
    }

    ElectionPhase public phase;

    event LogCurrentElectionPhase(string currentPhase);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

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

    // function getPhaseEnd() public view returns (uint256) {
    //     return end;
    // }

    function startTimer(uint256 _votingDuration, uint256 _breakDuration)
        public
        onlyOwner
    {
        if (phase.phaseName == PHASE_NAME.COMPLETED) {
            votingDuration = _votingDuration;
            breakDuration = _breakDuration;
            phase = ElectionPhase(
                PHASE_NAME.REGISTRATION,
                block.timestamp,
                block.timestamp + votingDuration
            );
        }
    }

    function stopTimer() public onlyOwner {
        phase = ElectionPhase(PHASE_NAME.COMPLETED, 0, 0);
    }



    function changePhase() public {
        // require(msg.sender == owner, "Only the owner can change the phase");

         if (phase.phaseName == PHASE_NAME.DEPARTMENT_ELECTION) {
            phase = ElectionPhase(PHASE_NAME.COMPLETED, 0, 0);
            // changeVal("unos");
            return;
        }
        else if(phase.phaseName == PHASE_NAME.COMPLETED){
            phase = ElectionPhase(PHASE_NAME.REGISTRATION, block.timestamp, block.timestamp + 200);
            return;

        }
        // return uint(phase.phaseName)+1;
        phase.phaseName = PHASE_NAME(uint(phase.phaseName) + 1);
        // phase.phaseName = PHASE_NAME.REGISTRATION_BREAK;
        phase.start = block.timestamp;
        // phase.end = block.timestamp + _newEnd;
        phase.end = block.timestamp + 200;
    }

    function getRemainingTime() external view returns (uint256) {
        if (phase.phaseName == PHASE_NAME.COMPLETED) {
            return 0;
        }
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

    function getCurrentPhase() public view returns (ElectionPhase memory) {
        return phase;
    }

    // function checkCurrentPhase() external {
    //     // require(msg.sender == owner, "only owner");
    //     if (phase.phaseName == PHASE_NAME.REGISTRATION) {
    //         if (block.timestamp >= phase.end) {
    //             changePhase(votingDuration);
    //             return;
    //             // return "ON REGISTRATION";
    //             // return phase;
    //         }
    //         phase = ElectionPhase(
    //             PHASE_NAME.REGISTRATION,
    //             block.timestamp,
    //             phase.end
    //         );
    //         // return "SECTION ELECTION INITIATED";
    //         // return phase;

    //         // changeVal("initial phase");
    //     }else if (phase.phaseName == PHASE_NAME.REGISTRATION_BREAK) {
    //         if (block.timestamp >= phase.end) {
                
    //             changePhase(breakDuration);
    //             return;

    //             // return "ON SECTION_ELECTION";
    //             // return phase;
    //         }
    //         phase = ElectionPhase(
    //             PHASE_NAME.REGISTRATION_BREAK,
    //             block.timestamp,
    //             phase.end
    //         );
            
    //         // return "SECTION ELECTION DONE";
    //         // return phase;
    //     }  
    //     else if (phase.phaseName == PHASE_NAME.SECTION_ELECTION) {
    //         if (block.timestamp >= phase.end) {
    //             changePhase(breakDuration);
    //             return;

    //             // return "ON SECTION_ELECTION";
    //             // return phase;
    //         }
    //         phase = ElectionPhase(
    //             PHASE_NAME.SECTION_ELECTION,
    //             block.timestamp,
    //             phase.end
    //         );
            
    //         // return "SECTION ELECTION DONE";
    //         // return phase;
    //     }  else if (phase.phaseName == PHASE_NAME.SECTION_ELECTION_DONE) {
    //         if (block.timestamp >= phase.end) {
    //             changePhase(breakDuration);
    //             return;

    //             // return "ON SECTION_ELECTION";
    //             // return phase;
    //         }
    //         phase = ElectionPhase(
    //             PHASE_NAME.SECTION_ELECTION_DONE,
    //             block.timestamp,
    //             phase.end
    //         );
            
    //         // return "SECTION ELECTION DONE";
    //         // return phase;
    //     } 
        
    //     else if (phase.phaseName == PHASE_NAME.SECTION_ELECTION_BREAK) {
    //         if (block.timestamp >= phase.end) {
    //             changePhase(votingDuration);
    //             return;

    //             // return "ON SECTION ELECTION BREAK";
    //             // return phase;
    //         }
    //         phase = ElectionPhase(
    //             PHASE_NAME.SECTION_ELECTION_BREAK,
    //             block.timestamp,
    //             phase.end
    //         );
    //         // return "BATCH ELECTION INITIATED";
    //         // return phase;

    //         // changeVal("initial phase");
    //     } else if (phase.phaseName == PHASE_NAME.BATCH_ELECTION) {
    //         if (block.timestamp >= phase.end) {
    //             changePhase(breakDuration);
    //             return;

    //             // return "ON BATCH ELECTION";
    //         }
    //         phase = ElectionPhase(
    //             PHASE_NAME.BATCH_ELECTION,
    //             block.timestamp,
    //             phase.end
    //         );
    //         // return phase;
    //         // return "BATCH ELECTION DONE";
    //     }else if (phase.phaseName == PHASE_NAME.BATCH_ELECTION_DONE) {
    //         if (block.timestamp >= phase.end) {
    //             changePhase(breakDuration);
    //             return;

    //             // return "ON SECTION_ELECTION";
    //             // return phase;
    //         }
    //         phase = ElectionPhase(
    //             PHASE_NAME.BATCH_ELECTION_DONE,
    //             block.timestamp,
    //             phase.end
    //         );
            
    //         // return "SECTION ELECTION DONE";
    //         // return phase;
    //     }  else if (phase.phaseName == PHASE_NAME.BATCH_ELECTION_BREAK) {
    //         if (block.timestamp >= phase.end) {
    //             changePhase(votingDuration);
    //             return;

    //             // return phase;
    //             // return "ON BATCH ELECTION BREAK";
    //         }
    //         phase = ElectionPhase(
    //             PHASE_NAME.BATCH_ELECTION_BREAK,
    //             block.timestamp,
    //             phase.end
    //         );
    //         // return phase;
    //         // return "DEPARTMENT ELECTION INITIATED";
    //         // changeVal("initial phase");
    //     } else if (phase.phaseName == PHASE_NAME.DEPARTMENT_ELECTION) {
    //         if (block.timestamp >= phase.end) {
    //             stopTimer();
    //             return;

    //             // return phase;
    //             // return "ON DEPARTMENT ELECTION";
    //         }
    //         phase = ElectionPhase(
    //             PHASE_NAME.DEPARTMENT_ELECTION,
    //             block.timestamp,
    //             phase.end
    //         );
    //         // return phase;
    //         // return "DEPARTMENT ELECTION DONE";
    //     }else if (phase.phaseName == PHASE_NAME.DEPARTMENT_ELECTION_DONE) {
    //         if (block.timestamp >= phase.end) {
    //             changePhase(breakDuration);
    //             return;

    //             // return "ON SECTION_ELECTION";
    //             // return phase;
    //         }
    //         phase = ElectionPhase(
    //             PHASE_NAME.DEPARTMENT_ELECTION_DONE,
    //             block.timestamp,
    //             phase.end
    //         );
            
    //         // return "SECTION ELECTION DONE";
    //         // return phase;
    //     }  else {
    //         phase = ElectionPhase(PHASE_NAME.COMPLETED, 0, 0);
    //         return;

    //         // return "UNKNOWN PHASE";
    //         // return phase;
    //     }
    //     // changeVal("to this");
    //     // if(token == address(0)) {
    //     //   owner.transfer(amount);
    //     // } else {
    //     //   IERC20(token).transfer(owner, amount);
    //     // }
    // }
}
