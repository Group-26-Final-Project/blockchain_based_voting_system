const AAiTVoteToken = artifacts.require("AAiTVoteToken");

module.exports = function (deployer, network) {
deployer.deploy(AAiTVoteToken);
};