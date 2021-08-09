//SPDX-License-Identifier: agpl-3.0
pragma solidity 0.7.6;
pragma abicoder v2;
import {Params} from "../interfaces/Params.sol";
import "./ERC721/ERC721.sol";
import "./Uniswap/Position/Position.sol";
import "./INonfungiblePositionManager.sol";



contract StaterNft is ERC721, Params {
    using Position for Position.Info;
    INonfungiblePositionManager public nonFungiblePositionManager;
    
    address public STATER;

    struct StaterPosition {
        Position.Info[] positions;
        address owner;
        uint256 id;
        // tokensOwed0 and tokensOwed1 is stored inside Position.Info
        address token0;
        address token1;
        uint24 fee;
    }

    modifier isStater {
        require(msg.sender == STATER);
        _;
    }

    constructor(
        string memory name,
        string memory symbol,
        address uniswapV3NftPositionManagerAddress,
        address stater
    ) ERC721(name, symbol) {
        nonFungiblePositionManager = INonfungiblePositionManager(uniswapV3NftPositionManagerAddress);
        STATER = stater;
    }

    uint256 public id;
    mapping(uint256 => StaterPosition) positions;

    function totalSupply(uint256 positionId) external view returns(uint256) {
        uint256 theTotalSupply;
        for (uint256 i = 0; i < positions[positionId].positions.length; ++i)
            theTotalSupply += positions[positionId].positions[i].liquidity;
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
    function mint(DepositPosition memory position, address owner) external isStater returns(uint256,bool) {
        bool isMinted;
        
        if (positions[position.positionId].positions.length == 0) {
            isMinted = true;
            _safeMint(msg.sender, id, "");
        }
    
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
        ) = nonFungiblePositionManager.positions(position.positionId);

        positions[position.positionId].positions.push(thePosition);
        positions[position.positionId].owner = owner;
        
        ++id;
        return (id-1,isMinted);
    }
    
    function burn(uint256 nftId) external isStater {
        _burn(nftId);
        delete positions[nftId];
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



    function _approve() external {
        return;
    }
    */
    
}