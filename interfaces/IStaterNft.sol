//SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.6.12 <=0.8.6;
pragma abicoder v2;
import {Params} from "./Params.sol";

interface IStaterNft is Params {
    function balanceOf(address user, uint256 positionId) external view returns(uint256);
    function getNftTokenFrom(uint256 positionId) external view returns(address);
    function getNftTokenTo(uint256 positionId) external view returns(address);
    function totalSupply(uint256 positionId) external view returns(uint256);
    function splitNft(uint256 parentPositionId, uint128 toSplit) external returns(uint256);
    function mint(DepositPosition memory position, address owner) external returns(uint256,bool);
    function burn(uint256 nftId) external;
}