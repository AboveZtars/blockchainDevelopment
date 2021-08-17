// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma abicoder v2; //for using abicoder

import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';
import "hardhat/console.sol";
//IERC20 for testing Purposes
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ToolV2 {
    IUniswapV2Router02 public constant uniswapRouterV2 = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
    ISwapRouter public constant uniswapRouterV3 = ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);
    
    

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
    address internal constant WETH9 = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;


    function balanceToken() public view returns (uint){
        
        console.log("Balance of UNI: ",UNIAddress.balanceOf(msg.sender));
        console.log("Balance of LINK: ",LINKAddress.balanceOf(msg.sender));
        return(address(0x70997970C51812dc3A010C7d01b50e0d17dc79C8).balance);
    }

    function swapForPercentage(uint[] memory percentage) public payable {
        uint deadline = block.timestamp + 30; // using 'now' for convenience
        uint time;
        require(block.timestamp > time + 5, "Simple Reentrancy Guard");
        time = block.timestamp;
        uint balance = msg.value;
        uint fee = (msg.value)/1000;
        balance = balance - fee;
        console.log(balance);
        console.log((balance*percentage[0])/100);
        console.log((balance*(100 - percentage[0]))/100);
        uniswapRouterV2.swapExactETHForTokens{ value: ((balance*percentage[0])/100) }(0, getPath(UNI), address(msg.sender), deadline);
        uniswapRouterV2.swapExactETHForTokens{ value: ((balance*(100 - percentage[0]))/100) }(0, getPath(LINK), address(msg.sender), deadline);
        sendFee(fee);
    }

    function getPath(address _tokenAddress) private pure returns (address[] memory) {
        address[] memory path = new address[](2);
        path[0] = uniswapRouterV2.WETH();
        path[1] = _tokenAddress;
        
        return path;
    }

    function swapForPercentageV2(uint[] memory percentage) external payable {
        require(msg.value > 0, "Must pass non 0 ETH amount");
        uint time;
        
        require(block.timestamp > time + 5, "Simple Reentrancy Guard");
        time = block.timestamp;
        uint balance = msg.value;
        uint dexFee = (msg.value)/1000;
        balance = balance - dexFee;
        console.log(balance);
        console.log((balance*percentage[0])/100);
        console.log((balance*(100 - percentage[0]))/100);
        
        ISwapRouter.ExactInputSingleParams memory params1 =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: WETH9,
                tokenOut: UNI,
                fee: 3000,
                recipient: msg.sender,
                deadline: block.timestamp + 15,
                amountIn: (balance*percentage[0])/100,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        uniswapRouterV3.exactInputSingle{ value: (balance*percentage[0])/100 }(params1);

        ISwapRouter.ExactInputSingleParams memory params2 =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: WETH9,
                tokenOut: LINK,
                fee: 3000,
                recipient: msg.sender,
                deadline: block.timestamp + 15,
                amountIn: (balance*(100 - percentage[0]))/100,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        uniswapRouterV3.exactInputSingle{ value: (balance*(100 - percentage[0]))/100 }(params2);

        sendFee(dexFee);

        /* IUniswapV3Router03.refundETH();
        
        // refund leftover ETH to user
        (bool success,) = msg.sender.call{ value: address(this).balance }("");
        require(success, "refund failed"); */
  }

    function sendFee(uint _fee) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        // 2nd address of Hardhat node
        (bool sent,) = address(0x70997970C51812dc3A010C7d01b50e0d17dc79C8).call{value: _fee}("");
    }
}