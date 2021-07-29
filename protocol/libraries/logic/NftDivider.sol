// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;


import {INonfungiblePositionManager} from '../../../interfaces/INonfungiblePositionManager.sol';
import {Multicall} from '../../../interfaces/IMulticall.sol';
import {SplitComponents} from '../types/DataTypes.sol';

/**
 * @title NftDivider library
 * @author DIIMIIM
 * @title Implements protocol-level logic for splitting a uniswap v3 based on its liquidity
 */
library NftDivider {


    /* @DIIMIIM: From Uniswap v3 periphery */
    struct DecreaseLiquidityParams {
        uint256 tokenId;
        uint128 liquidity;
        uint256 amount0Min;
        uint256 amount1Min;
        uint256 deadline;
    }


   /*
    * @DIIMIIM: Splits the uniswap v3 nft
    * 1 - Withdraws from the current position
    * 2 - Creates a new position with the exact same parameters + the withdrawn amount
    */
    function splitNft(uint256 position, uint128 toSplit, SplitComponents memory splitComponents) external returns(uint256) {
        DecreaseLiquidityParams memory decreaseLiquidityParams;
        decreaseLiquidityParams.tokenId = position;
        decreaseLiquidityParams.liquidity = toSplit;

        decreaseLiquidityParams.amount0Min = 0;
        decreaseLiquidityParams.amount1Min = 0;
        decreaseLiquidityParams.deadline = 0; // A variable from multicall will be used here
        INonfungiblePositionManager.decreaseLiquidity();
    }


}
