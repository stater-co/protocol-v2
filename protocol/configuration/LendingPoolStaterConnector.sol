// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.6.12;

import {Ownable} from '../../dependencies/openzeppelin/contracts/Ownable.sol';

contract LendingPoolStaterConnector is Ownable {
  address public STATER_NFT = address(0); // @DIIMIIM: To be hardcoded here later

  function setStaterNft(address staterNftAddress) external onlyOwner {
      STATER_NFT = staterNftAddress;
  }

  function getStaterNft() external view returns(address) {
      return STATER_NFT;
  }

}