// SPDX-License-Identifier: agpl-3.0
pragma solidity >=0.6.12 <=0.8.6;
import {Ownable} from '../../dependencies/openzeppelin/contracts/access/Ownable.sol';

contract LendingPoolStaterConnector is Ownable {

    address public STATER_NFT = address(0); // @DIIMIIM: To be hardcoded here later
    IStaterNft public staterNft;
    uint256 public maxStableRateBorrowSizePercent = 2500;
    uint256 public maxNumberOfReserves = 128;

    function setStaterNft(address staterNftAddress) external onlyOwner {
        STATER_NFT = staterNftAddress;
        staterNft = IStaterNft(STATER_NFT);
    }

    function setMaxStableRateBorrowSizePercent(uint256 maxStableRateBorrowSizePercentValue) external onlyOwner {
        maxStableRateBorrowSizePercent = maxStableRateBorrowSizePercentValue;
    }

    function setMaxNumberOfReserves(uint256 maxNumberOfReservesValue) external onlyOwner {
        maxNumberOfReserves = maxNumberOfReservesValue;
    }


    function getStaterNft() external view returns(address) {
        return STATER_NFT;
    }

    function MAX_STABLE_RATE_BORROW_SIZE_PERCENT() external view returns(uint256) {
        return maxStableRateBorrowSizePercent;
    }

    function MAX_NUMBER_RESERVES() external view returns(uint256) {
        return maxNumberOfReserves;
    }

}