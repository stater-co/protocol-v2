//SPDX-License-Identifier: agpl-3.0
pragma solidity =0.6.12;
import "../dependencies/openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./uniswap-v3/core/libraries/Position.sol";
import {INonfungiblePositionManager} from '../interfaces/INonfungiblePositionManager.sol';

contract StaterNft is ERC721 {

    INonfungiblePositionManager public nonFungiblePositionManager;

    constructor(
        string memory name,
        string memory symbol,
        address uniswapV3NftPositionManagerAddress
    ) ERC721(name, symbol) public {
        nonFungiblePositionManager = INonfungiblePositionManager(uniswapV3NftPositionManagerAddress);
    }

    uint256 public id;
    using Position for mapping(uint256 => Position.Info);
    using Position for Position.Info;
    mapping(uint256 => Position.Info) positions;

    function totalSupply(uint256 tokenId) external view returns(uint128) {
        returns positions[tokenId].liquidity; // to implement the right logic later, right now for tests purpose only
    }

    // @DIIMIIM: Will return the child token id
    function splitNft(uint256 parentTokenId, uint128 toSplit) external returns(uint256) {
        
        // @DIIMIIM: To be discussed with Raziel
        return parentTokenId;
    }

    /*
    function position(uint256 tokenId) external view {
        return;
    }

    function mint() external {
        return;
    }

    function increaseLiquidity() external {
        return;
    }

    function decreaseLiquidity() external {
        return;
    }

    function collect() external {
        return;
    }

    function burn() external {
        return;
    }

    function _approve() external {
        return;
    }
    */
    
}