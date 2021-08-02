//SPDX-License-Identifier: agpl-3.0
pragma solidity =0.6.12;
import "../dependencies/openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./uniswap-v3/core/libraries/Position.sol";
//import "./uniswap-v3/periphery/interfaces/INonfungiblePositionManager.sol";

contract NFTPosition is ERC721 {

    constructor(
        string memory name_,
        string memory symbol_ /*,
        string memory version_*/
    ) ERC721(name_, symbol_) public {
        
    }

    /// @dev The ID of the next token that will be minted. Skips 0
    uint256 public id;
    using Position for mapping(uint256 => Position.Info);
    using Position for Position.Info;
    mapping(uint256 => Position.Info) positions;


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