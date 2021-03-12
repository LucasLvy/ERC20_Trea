var Trealos = artifacts.require("./Token.sol");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(Trealos);
};