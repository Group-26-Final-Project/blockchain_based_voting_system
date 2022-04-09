const CandidateContract = artifacts.require("Candidate");

module.exports = function (deployer, network) {
  deployer.deploy(CandidateContract);
};
