//SPDX-License-Identifier: agpl-3.0
pragma solidity =0.6.12;

interface IStaterNft {
    function balanceOf(address user, uint256 positionId) external view returns(uint128);
    function getNftTokenFrom(uint256 positionId) external view returns(address);
    function getNftTokenTo(uint256 positionId) external view returns(address);
    function totalSupply(uint256 positionId) external view returns(uint128);
    function splitNft(uint256 parentPositionId, uint128 toSplit) external returns(uint256);
    function mint() external returns(uint256,uint128,uint256,uint256) 
}