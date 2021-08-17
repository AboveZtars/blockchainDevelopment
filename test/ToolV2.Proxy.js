// test/ToolV1Test.js
// Load dependencies
const { expect } = require('chai');
const axios = require('axios');  
// Hardcoded Token Address for testing
/* const WETH9 = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
const  KCS  = 0xf34960d9d60be18cC1D5Afc1A6F012A723a28811; */ //USE THIS FOR TESTING UNISWAP V3 IN 0X API


// Start test block
describe('ToolV2 (proxy)', function () {

    //API FOR SELECTING THE BEST DEX (NOT WORKING), BUT IT DOES GET DATA FROM 0X API
    //AND GET THE PROPORTIONS FOR UNISWAP_V2 AND UNISWAP_V3. 
    //KCS IT'S ONE OF THE FEW TOKENS WITH BETTER PROPORTIONS IN UNISWAP_V3 
    /* axios.get('https://api.0x.org/swap/v1/quote?buyToken='+WETH9+'&sellToken='+KCS+'&sellAmount=1000000000000000000&excludedSources=0x,Kyber,Uniswap,Eth2Dai,Curve,Balancer,Balancer_V2,Bancor,mStable,Mooniswap,Swerve,SnowSwap,SushiSwap,Shell,MultiHop,DODO,DODO_V2,CREAM,LiquidityProvider,CryptoCom,Linkswap,Lido,MakerPsm,KyberDMM,Smoothy,Component,Saddle,xSigma,Curve_V2,ShibaSwap,Clipperer?ID=12345')
    .then(response => {
        // handle success
        //console.log(response.data.sources[2]);
        const uniV2 = response.data.sources[2].proportion;
        //console.log(response.data.sources[29]);
        const uniV3 = response.data.sources[29].proportion;
        return [uniV2,uniV3]
    }).catch(function (error) {
        // handle error
        console.log("dio error");
    }) */
    
    // Test case
        it('Checking transaction', async function () {
            const ToolV1Factory = await ethers.getContractFactory("ToolV1");
            const ToolV2Factory = await ethers.getContractFactory("ToolV2");
            const ToolV1 = await upgrades.deployProxy(ToolV1Factory, [], {initializer: false});
            const ToolV2 = await upgrades.upgradeProxy(ToolV1.address, ToolV2Factory);
            // Swap Transaction    ARRAY PASS THE DESIRE PERCENTAGE OF THE FIRST TOKEN, THE PERCENTAGE OF THE SECOND TOKEN IS CALCULATED BY THE SMART CONTRACT
            const Tx = await ToolV2.swapForPercentageV2([70],{value:ethers.utils.parseEther("1")});
            await Tx.wait();
            // Showing account balance
            console.log("Ether sent to the Recipient:"+((await ToolV2.balanceToken()).toString())/(1*10**18));

        }).timeout(50000);
    
});