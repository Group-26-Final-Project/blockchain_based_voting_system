const AAiTVoteToken = artifacts.require("AAiTVoteToken");
const AAiTElection = artifacts.require("AAiTElection");
const AAiTStudent = artifacts.require("AAiTStudent");
const AAiTUser = artifacts.require("AAiTUser");
const AAiTElectionTimer = artifacts.require("AAiTElectionTimer");
const AAiTElectionHandler = artifacts.require("AAiTElectionHandler");
// const biconomyForwarder = require("../list/biconomyForwarder.json");

module.exports = function (deployer, network) {
  //   const getBiconomyForwarderByNetwork = biconomyForwarder[network];
  //   if (getBiconomyForwarderByNetwork) {
  //     deployer.deploy(SimpleStorage, getBiconomyForwarderByNetwork);
  //   } else {
  //     console.log("No Biconomy Forwarder Found in the desired network!");
  //   }
  deployer.deploy(AAiTElectionTimer).then(function () {
    return deployer
      .deploy(AAiTUser, AAiTElectionTimer.address)
      .then(function () {
        return deployer.deploy(AAiTStudent, AAiTUser.address).then(function () {
          return deployer.deploy(AAiTVoteToken).then(function () {
            return deployer
              .deploy(
                AAiTElection,
                AAiTVoteToken.address,
                AAiTStudent.address,
                AAiTElectionTimer.address
              )
              .then(function () {
                return deployer
                  .deploy(
                    AAiTElectionHandler,
                    AAiTVoteToken.address,
                    AAiTStudent.address,
                    AAiTElectionTimer.address,
                    AAiTElection.address
                  )
                  .then(function () {
                    console.log(
                      "REACT_APP_AAITELECTIONHANDLER_CONTRACT_ADDRESS=" +
                        AAiTElectionHandler.address
                    );
                    console.log(
                      "REACT_APP_AAITELECTION_CONTRACT_ADDRESS=" + AAiTElection.address
                    );
                    console.log(
                      "REACT_APP_AAITVOTETOKEN_CONTRACT_ADDRESS=" + AAiTVoteToken.address
                    );
                    console.log(
                      "REACT_APP_AAITSTUDENT_CONTRACT_ADDRESS=" + AAiTStudent.address
                    );
                    console.log("REACT_APP_AAITUSER_CONTRACT_ADDRESS=" + AAiTUser.address);
                    console.log(
                      "REACT_APP_AAITELECTIONTIMER_CONTRACT_ADDRESS=" +
                        AAiTElectionTimer.address
                    );
                  });
              });
          });
        });
      });
  });
};
