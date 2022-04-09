const UserContract = artifacts.require("User");

module.exports = function (deployer, network) {
  deployer.deploy(UserContract);
};
