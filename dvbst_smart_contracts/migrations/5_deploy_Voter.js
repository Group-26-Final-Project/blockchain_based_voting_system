const VoterContract = artifacts.require("Voter");

module.exports = function (deployer, network) {
  deployer.deploy(VoterContract);
};
