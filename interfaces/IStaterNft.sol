//SPDX-License-Identifier: agpl-3.0
pragma solidity =0.6.12;

interface IStaterNft {

    function balanceOf(uint256 tokenId) external view returns(uint128);
    
}