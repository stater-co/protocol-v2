//SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.6.12 <=0.8.6;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@uniswap/v3-core/contracts/libraries/Position.sol";
import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";

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
    mapping(uint256 => bool) positionsExistence;

    function totalSupply(uint256 positionId) external view returns(uint128) {
        return positions[positionId].liquidity; // to implement the right logic later, right now for tests purpose only
    }

    // @DIIMIIM: Will return the child token id
    function splitNft(uint256 parentPositionId, uint128 toSplit) external returns(uint256) {
        
        // @DIIMIIM: To be discussed with Raziel
        return parentPositionId;
    }

    function balanceOf(uint256 positionId) external view returns(uint128) {
        (,,,,,,,uint128 balance,,,,) = nonFungiblePositionManager.positions(positionId);
        return balance;
    }

    // @DIIMIIM: This must handle both cases:
    // 1) A real mint, where a deposit is created for the first time
    // 2) A deposit, where the nft will be updated
    function mint(uint256 positionIds) external returns(uint256) {
        
        // To be adapted to array
        if (positionsExistence[positionIds]) {
            // Perform update
        } else {
            positionsExistence[positionIds] = true;
            // Perform mint
        }
        
        return positionIds;
    }

    /*
    function position(uint256 tokenId) external view {
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