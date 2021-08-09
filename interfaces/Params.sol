// SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.6.12 <=0.8.6;

interface Params {

  struct DepositPosition {
    address asset;
    uint256 amount;
    address onBehalfOf;
    uint16 referralCode;
    bool hasCurrency;
    bool hasNft;
    uint256 nftId;
  }

  struct WithdrawParams {
    address asset;
    uint256 amount;
    address to;
    uint256 nftId;
  }

}
