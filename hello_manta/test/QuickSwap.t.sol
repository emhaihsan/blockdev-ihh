// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface IQuickSwap {
    function WETH9() external view returns (address);

    function exactInput(
        ISwapRouter.ExactInputParams memory params
    ) external payable returns (uint256 amountOut);

    function exactInputSingle(
        ISwapRouter.ExactInputSingleParams memory params
    ) external payable returns (uint256 amountOut);

    function exactOutput(
        ISwapRouter.ExactOutputParams memory params
    ) external payable returns (uint256 amountIn);

    function exactOutputSingle(
        ISwapRouter.ExactOutputSingleParams memory params
    ) external payable returns (uint256 amountIn);

    function factory() external view returns (address);

    function multicall(
        bytes[] memory data
    ) external payable returns (bytes[] memory results);

    function refundETH() external payable;

    function selfPermit(
        address token,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;

    function selfPermitAllowed(
        address token,
        uint256 nonce,
        uint256 expiry,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;

    function selfPermitAllowedIfNecessary(
        address token,
        uint256 nonce,
        uint256 expiry,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;

    function selfPermitIfNecessary(
        address token,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;

    function sweepToken(
        address token,
        uint256 amountMinimum,
        address recipient
    ) external payable;

    function sweepTokenWithFee(
        address token,
        uint256 amountMinimum,
        address recipient,
        uint256 feeBips,
        address feeRecipient
    ) external payable;

    function uniswapV3SwapCallback(
        int256 amount0Delta,
        int256 amount1Delta,
        bytes memory _data
    ) external;

    function unwrapWETH9(
        uint256 amountMinimum,
        address recipient
    ) external payable;

    function unwrapWETH9WithFee(
        uint256 amountMinimum,
        address recipient,
        uint256 feeBips,
        address feeRecipient
    ) external payable;

    receive() external payable;
}

interface ISwapRouter {
    struct ExactInputParams {
        bytes path;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
    }

    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96;
    }

    struct ExactOutputParams {
        bytes path;
        address recipient;
        uint256 deadline;
        uint256 amountOut;
        uint256 amountInMaximum;
    }

    struct ExactOutputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 deadline;
        uint256 amountOut;
        uint256 amountInMaximum;
        uint160 sqrtPriceLimitX96;
    }
}

contract QuickSwapTest is Test {
    address weth = 0x0Dc808adcE2099A9F62AA87D9670745AbA741746;
    address usdc = 0xb73603C5d87fA094B7314C74ACE2e64D165016fb;
    address quickSwap = 0xfdE3eaC61C5Ad5Ed617eB1451cc7C3a0AC197564;

    function setUp() public {
        // men-fork data dari Manta Mainnet
        vm.createSelectFork("https://1rpc.io/manta", 4545582);

        // memberikan ETH kepada kontrak ini
        deal(weth, address(this), 100 ether);
    }

    function test_swap() public {
        IQuickSwap quickSwap = IQuickSwap(payable(quickSwap));

        console.log(
            "USDC balance before swap",
            IERC20(usdc).balanceOf(address(this))
        );

        IERC20(weth).approve(address(quickSwap), 100 ether);

        // swap 1 ETH ke USDC
        quickSwap.exactInputSingle(
            ISwapRouter.ExactInputSingleParams({
                tokenIn: weth,
                tokenOut: usdc,
                fee: 100,
                recipient: address(this),
                deadline: block.timestamp,
                amountIn: 1 ether,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            })
        );

        console.log(
            "USDC balance after swap",
            IERC20(usdc).balanceOf(address(this))
        );
    }
}
