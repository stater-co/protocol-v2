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
        mapping(address => mapping(address => uint256)) balances;
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

    uint256 public id = 1;
    mapping(uint256 => StaterPosition) positions;

    function totalPositionsLiquidity(uint256 nftId) external view returns(uint256) {
        uint256 theTotalSupply;
        for (uint256 i = 0; i < positions[nftId].positions.length; ++i)
            theTotalSupply += positions[nftId].positions[i].liquidity;
        return theTotalSupply;
    }

    function balanceOfNftCurrency(uint256 nftId, address holder, address asset) external view returns(uint256) {
        return positions[nftId].balances[asset][holder];
    }

    // @DIIMIIM: Will return the child token id
    function splitNft(uint256 parentNftId, uint128 toSplit) external pure returns(uint256) {
        
        // @DIIMIIM: To be discussed with Raziel
        return parentNftId / toSplit;
    }

    function balanceOf(uint256 nftId) external view returns(uint128) {
        (,,,,,,,uint128 balance,,,,) = nonFungiblePositionManager.positions(nftId);
        return balance;
    }

    // @DIIMIIM: This must handle both cases:
    // 1) A real mint, where a deposit is created for the first time
    // 2) A deposit, where the nft will be updated
    function mint(DepositParams memory params, address owner) external isStater returns(uint256,bool) {
        bool isMinted;
        
        if (positions[params.nftId].positions.length == 0) {
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
        ) = nonFungiblePositionManager.positions(params.nftId);

        positions[params.nftId].positions.push(thePosition);
        positions[params.nftId].owner = owner;
        
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