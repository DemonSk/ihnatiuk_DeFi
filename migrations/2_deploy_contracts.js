const DSToken = artifacts.require("DSToken");
const DSStorage = artifacts.require("DSStorage");

module.exports = async function (deployer, network, accounts) {
  await deployer.deploy(DSToken);
  const myToken = await DSToken.deployed();

  await deployer.deploy(
    DSStorage,
    myToken.address,
    "0x09676Ee4685B618d0DCc85E221019c9Ce3810211"
  );
};
