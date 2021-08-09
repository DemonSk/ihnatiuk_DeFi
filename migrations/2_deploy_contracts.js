const DSToken = artifacts.require("DSToken");
const WDSToken = artifacts.require("WDSToken");

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(DSToken);
  const myToken = await DSToken.deployed();

  await deployer.deploy(WDSToken, myToken.address);
};
