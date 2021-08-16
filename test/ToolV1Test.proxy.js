// test/ToolV1Test.proxy.js
// Load dependencies
const { expect } = require('chai');
 
let ToolV1Factory;
let ToolV1;
 
// Start test block
describe('ToolV1 (proxy)', function () {
  beforeEach(async function () {
    ToolV1Factory = await ethers.getContractFactory("ToolV1");
    ToolV1 = await upgrades.deployProxy(ToolV1Factory, [], {initializer: 'balanceToken'});
  });
 
  // Test case
  it('Another check but with the proxy', async function () {
      await ToolV1.swapForPercentage([70],{value:ethers.utils.parseEther("1")});
      
      console.log((await ToolV1.balanceToken()).toString()/(1*10**18));
    // Test if the returned value is the same one
    // Note that we need to use strings to compare the 256 bit integers
    //expect(await ToolV1.printWETHAddress()).to.equal('0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2');
  });
});