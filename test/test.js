const axios = require('axios');  
const WETH9 = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2";
const  DAI  = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
const  USDT = "0xdAC17F958D2ee523a2206206994597C13D831ec7";
const  USDC = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
const  UNI  = "0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984";
const  LINK = "0x514910771AF9Ca656af840dff83E8264EcF986CA";
const  BUSD = "0x4Fabb145d64652a948d72533023f6E7A623C7C53";
const SUSHI = "0x6B3595068778DD592e39A122f4f5a5cF09C90fE2";
const  BAT  = "0x0D8775F648430679A709E98d2b0Cb6250d2887EF";
const  RSR  = "0x8762db106B2c2A0bccB3A80d1Ed41273552616E8";
const STRONG= "0x990f341946A3fdB507aE7e52d17851B87168017c";


const urlV2FirstToken = "https://api.0x.org/swap/v1/quote?buyToken="+UNI+"&sellToken="+WETH9+"&sellAmount=1000000000000000000&includedSources=Uniswap_V2"; 
const urlV3FirstToken = "https://api.0x.org/swap/v1/quote?buyToken="+UNI+"&sellToken="+WETH9+"&sellAmount=1000000000000000000&includedSources=Uniswap_V3";
const urlV2SecondToken = "https://api.0x.org/swap/v1/quote?buyToken="+USDT+"&sellToken="+WETH9+"&sellAmount=1000000000000000000&includedSources=Uniswap_V2"; 
const urlV3SecondToken = "https://api.0x.org/swap/v1/quote?buyToken="+USDT+"&sellToken="+WETH9+"&sellAmount=1000000000000000000&includedSources=Uniswap_V3"; 
axios.get(urlV2FirstToken)
    .then(response => {
        // handle success
        console.log("First token price for V2 " + response.data.price);
        

    }).catch(function (error) {
        // handle error
        console.log("dio error");
    }) 

axios.get(urlV3FirstToken)
    .then(response => {
        // handle success
        console.log("First token price for V3 " + response.data.price);
  

    }).catch(function (error) {
        // handle error
        console.log("dio error");
    }) 
axios.get(urlV2SecondToken)
    .then(response => {
        // handle success
        console.log("Second token price for V2 " + response.data.price);
        

    }).catch(function (error) {
        // handle error
        console.log("dio error");
    }) 

axios.get(urlV3SecondToken)
    .then(response => {
        // handle success
        console.log("Second token price for V3 " + response.data.price);
  

    }).catch(function (error) {
        // handle error
        console.log("dio error");
    }) 