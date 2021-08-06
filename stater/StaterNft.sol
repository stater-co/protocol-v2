//SPDX-License-Identifier: agpl-3.0
pragma solidity 0.7.6;
import "./ERC721/ERC721.sol";
import "./Uniswap/Position/Position.sol";
import "./INonfungiblePositionManager.sol";



contract StaterNft is ERC721 {
    using Position for Position.Info;
    INonfungiblePositionManager public nonFungiblePositionManager;

    struct position {
        Position.Info[] parents;
        address owner;
        uint256 id;
    }

    constructor(
        string memory name,
        string memory symbol,
        address uniswapV3NftPositionManagerAddress
    ) ERC721(name, symbol) {
        nonFungiblePositionManager = INonfungiblePositionManager(uniswapV3NftPositionManagerAddress);
    }

    // In this case it might be good to keep the 0 id unused considering the previous smart contracts development
    uint256 public id = 1;
    mapping(uint256 => position) positions;
    
    // Uniswap position id => stater position id
    mapping(uint256 => uint256) positionsExistence;

    function totalSupply(uint256 positionId) external view returns(uint256) {
        uint256 theTotalSupply;
        for ( uint256 i = 0; i < positions[positionId].parents.length; ++i ) {
            theTotalSupply += positions[positionId].parents[i].liquidity;
        }
        return theTotalSupply;
    }

    // @DIIMIIM: Will return the child token id
    function splitNft(uint256 parentPositionId, uint128 toSplit) external pure returns(uint256) {
        
        // @DIIMIIM: To be discussed with Raziel
        return parentPositionId / toSplit;
    }

    function balanceOf(uint256 positionId) external view returns(uint128) {
        (,,,,,,,uint128 balance,,,,) = nonFungiblePositionManager.positions(positionId);
        return balance;
    }

    // @DIIMIIM: This must handle both cases:
    // 1) A real mint, where a deposit is created for the first time
    // 2) A deposit, where the nft will be updated
    function mint(uint256[] calldata positionIds, address onBehalfOf) external returns(uint256,bool) {
        bool isMinted = true;
    
        for ( uint256 i = 0; i < positionIds.length; ++i ) {
            
            // Constructing the uniswap position
            Position.Info memory thePosition;
            (
                ,
                ,
                ,
                ,
                ,
                ,
                ,
                thePosition.liquidity,
                thePosition.feeGrowthInside0LastX128,
                thePosition.feeGrowthInside1LastX128,
                thePosition.tokensOwed0,
                thePosition.tokensOwed1
            ) = nonFungiblePositionManager.positions(positionIds[i]);
            
            
            // If position already exists in our smart contract state, we check its owner so we can update it after
            // Otherwise we mint it and also set the owner
            if (positionsExistence[positionIds[i]] > 0) {
                require(positions[positionsExistence[positionIds[i]]].owner == onBehalfOf);
                isMinted = false;
                for ( uint j = 0; j < positions[positionsExistence[positionIds[i]]].parents.length; ++j )
                    if (positions[positionsExistence[positionIds[i]]].parents[j].)
                // positions
                // Perform update
            } else {
                positionsExistence[positionIds] = true;
                // Perform mint
            }
        }

        ++id;
        return (positionIds,positionsExistence[positionIds]);
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