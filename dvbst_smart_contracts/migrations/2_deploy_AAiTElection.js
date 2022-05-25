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
    console.log("AAiTElectionTimer deployed at: " + AAiTElectionTimer.address);
    return deployer.deploy(AAiTUser).then(function () {
      console.log("AAiTUser deployed at: " + AAiTUser.address);
      return deployer.deploy(AAiTStudent, AAiTUser.address).then(function () {
        console.log("AAiTStudent deployed at: " + AAiTStudent.address);
        return deployer.deploy(AAiTVoteToken).then(function () {
          console.log("AAiTVoteToken deployed at: " + AAiTVoteToken.address);
          return deployer
            .deploy(
              AAiTElection,
              AAiTVoteToken.address,
              AAiTStudent.address,
              AAiTElectionTimer.address
            )
            .then(function () {
              console.log("AAiTElection deployed at: " + AAiTElection.address);
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
                    "AAiTElectionHandler deployed at: " +
                      AAiTElectionHandler.address
                  );
                });
            });
        });
      });
    });
  });
};
