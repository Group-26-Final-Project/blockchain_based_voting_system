const AAiTVoteToken = artifacts.require("AAiTVoteToken");
const AAiTElection = artifacts.require("AAiTElection");
const AAiTStudent = artifacts.require("AAiTStudent");
// const biconomyForwarder = require("../list/biconomyForwarder.json");

module.exports = function (deployer, network) {
  //   const getBiconomyForwarderByNetwork = biconomyForwarder[network];
  //   if (getBiconomyForwarderByNetwork) {
  //     deployer.deploy(SimpleStorage, getBiconomyForwarderByNetwork);
  //   } else {
  //     console.log("No Biconomy Forwarder Found in the desired network!");
  //   }
  deployer.deploy(AAiTStudent).then(function () {
    console.log("AAiTStudent deployed at: " + AAiTStudent.address);
    return deployer.deploy(AAiTVoteToken).then(function () {
      console.log("AAiTVoteToken deployed at: " + AAiTVoteToken.address);
      return deployer
        .deploy(AAiTElection, AAiTVoteToken.address, AAiTStudent.address)
        .then(function () {
          console.log("AAiTElection deployed at: " + AAiTElection.address);
        });
    });
  });
};
