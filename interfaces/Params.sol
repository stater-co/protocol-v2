// SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.6.12 <=0.8.6;

interface Params {

  struct DepositParams {
    address asset;
    uint256 amount;
    address onBehalfOf;
    address nftAddress;
    uint256 nftId;
    uint16 referralCode;
    bool hasCurrency;
    bool hasNft;    
  }

  struct WithdrawParams {
    address asset;
    uint256 amount;
    address to;
    address nftAddress;
    uint256 nftId;
    bool withdrawsNft;
    bool withdrawsCurrency;
  }
  
  struct ExecuteBorrowParams {
    address asset;
    address user;
    address onBehalfOf;
    uint256 amount;
    uint256 interestRateMode;
    uint256 tokenId;
    uint16 referralCode;
    bool releaseUnderlying;
  }

  struct CalculateInterestRatesParams {
    address reserve;
    uint256 liquidityAdded;
    uint256 liquidityTaken;
    uint256 totalStableDebt;
    uint256 totalVariableDebt;
    uint256 averageStableBorrowRate;
    uint256 reserveFactor;
    uint256 nftId;
    bool hasNft;
  }

}
