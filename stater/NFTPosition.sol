pragma solidity =0.6.12;
import '../dependencies/openzeppelin/contracts/token/ERC721/ERC721.sol';

contract NFTPosition is ERC721 {

    constructor(
        string memory name_,
        string memory symbol_,
        string memory version_
    ) ERC721(name_, symbol) {
    }

    // details about the position
    struct Position {
        // the address that is approved for spending this token
        address operator;
        // the ID of the pools with which this token is connected
        uint8[] poolIds;
        // the liquidity of the position
        uint128 liquidity;
        // the list of the collateral uniswap v3 positions
        address[] collateralList;
        // how many tokens does each nft position owns(not sure we need this)
        mapping(address => uint256[]) tokensOwned; 
        // the borrow amount
        uint256 borrowAmount;
        // the health factor of the position;(not sure)
        uint80 healthFactor;
    }

    /// @dev The ID of the next token that will be minted. Skips 0
    uint176 private _nextId = 1;

    function position(uint256 tokenId) {

    }

    function mint() {

    }

    function increaseLiquidity() {

    }

    function decreaseLiquidity() {

    }

    function collect() {

    }

    function burn() {

    }

    function _approve() {

    }
}