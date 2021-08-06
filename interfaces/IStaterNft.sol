//SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.6.12 <=0.8.6;

interface IStaterNft {
    function balanceOf(address user, uint256 positionId) external view returns(uint256);
    function getNftTokenFrom(uint256 positionId) external view returns(address);
    function getNftTokenTo(uint256 positionId) external view returns(address);
    function totalSupply(uint256 positionId) external view returns(uint128);
    function splitNft(uint256 parentPositionId, uint128 toSplit) external returns(uint256);
    function mint(uint256 positionIds) external returns(uint256,bool);
}