// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// IF YOU WANT TO TEST THE BEHAVIOR WITH DIFFERENT TOKENS MAKE SURE TO CHANGE ALL THE VARIABLES AT THE SWAPS FUNCTIONS--
// -- WITH THE CORRESPONDING TOKEN FOR TESTING. 
// THE SELECTION OF A TOKEN MUST BE DONE IN THE FRONTEND.

import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "hardhat/console.sol";
//IERC20 for testing Purposes
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ToolV1 {
    IUniswapV2Router02 public constant uniswapRouterV2 = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

    //Hardcoded Tokens for testing purposes
    IERC20 private constant UNIAddress = IERC20(UNI);
    IERC20 private constant LINKAddress = IERC20(LINK);
    address internal constant  USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
    address internal constant  USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address internal constant  UNI  = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984;
    address internal constant  LINK = 0x514910771AF9Ca656af840dff83E8264EcF986CA;
    address internal constant  BUSD = 0x4Fabb145d64652a948d72533023f6E7A623C7C53;
    address internal constant  DAI  = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address internal constant SUSHI = 0x6B3595068778DD592e39A122f4f5a5cF09C90fE2;
    address internal constant  BAT  = 0x0D8775F648430679A709E98d2b0Cb6250d2887EF;
    address internal constant  RSR  = 0x8762db106B2c2A0bccB3A80d1Ed41273552616E8;
    address internal constant STRONG= 0x990f341946A3fdB507aE7e52d17851B87168017c;


    function balanceToken() public view returns (uint){
        
        console.log("Balance of UNI: ",UNIAddress.balanceOf(msg.sender));
        console.log("Balance of LINK: ",LINKAddress.balanceOf(msg.sender));
        return(address(0x70997970C51812dc3A010C7d01b50e0d17dc79C8).balance);
    }

    function swapForPercentage(uint[] memory percentage) public payable {
        require(msg.value > 0, "Must pass non 0 ETH amount");
        require(percentage[0] >= 0 && percentage[0] <=100 , "Must be 0 or greater"); //overflow - underflow guard
        uint deadline = block.timestamp + 30; 
        uint time;
        require(block.timestamp > time + 5, "Simple Reentrancy Guard"); // Simple reentrancy guard
        time = block.timestamp;
        uint balance = msg.value;
        uint fee = (msg.value)/1000;
        balance = balance - fee;
        console.log(balance);
        console.log((balance*percentage[0])/100);
        console.log((balance*(100 - percentage[0]))/100);
        swapUNIV2((balance*percentage[0])/100, getPath(UNI), deadline); // change UNI for testing
        swapUNIV2(((balance*(100 - percentage[0]))/100), getPath(LINK), deadline); // change LINK for testing
        sendFee(fee);
    }
    //swap of uniswap v2
    function swapUNIV2(uint valueForTx, address[] memory path, uint deadline ) private {
        uniswapRouterV2.swapExactETHForTokens{ value: valueForTx }(0, path, address(msg.sender), deadline);
    }
    //calculate the path for uniswap v2
    function getPath(address _tokenAddress) private pure returns (address[] memory) {
    address[] memory path = new address[](2);
    path[0] = uniswapRouterV2.WETH();
    path[1] = _tokenAddress;
    
    return path;
    }

    function sendFee(uint _fee) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        // 2nd address of Hardhat node
        (bool sent,) = address(0x70997970C51812dc3A010C7d01b50e0d17dc79C8).call{value: _fee}("");
    }
}