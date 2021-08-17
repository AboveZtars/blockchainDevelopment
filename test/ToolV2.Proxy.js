// test/ToolV1Test.js
// Load dependencies
const { expect } = require('chai');

// Start test block
describe('ToolV2 (proxy)', function () {  
  // Test case
  it('Checking transaction', async function () {
    const ToolV1Factory = await ethers.getContractFactory("ToolV1");
    const ToolV2Factory = await ethers.getContractFactory("ToolV2");
    const ToolV1 = await upgrades.deployProxy(ToolV1Factory, [], {initializer: 'balanceToken'});
    const ToolV2 = await upgrades.upgradeProxy(ToolV1.address, ToolV2Factory);
 
    //await ToolV2.deployed();
    // Swap Transaction
    const Tx = await ToolV2.swapForPercentageV2([70],{value:ethers.utils.parseEther("1")});
    await Tx.wait();
    // Showing account balance
    console.log((await ToolV2.balanceToken()).toString()/(1*10**18));
    //console.log((await ToolV1.balanceToken()).toString());
    // Test if the returned value is the same one
    //expect(await ToolV1.printWETHAddress()).to.equal('0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2');
  }).timeout(50000);;
});