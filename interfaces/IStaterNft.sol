//SPDX-License-Identifier: agpl-3.0
pragma solidity =0.6.12;

interface IStaterNft {
    function balanceOf(address user, uint256 tokenId) external view returns(uint128);
    function getNftTokenFrom(uint256 tokenId) external view returns(address);
    function getNftTokenTo(uint256 tokenId) external view returns(address);
}