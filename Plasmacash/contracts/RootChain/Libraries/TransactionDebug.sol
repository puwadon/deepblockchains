/** Copyright 2018 Wolk Inc.
* This file is part of the Plasmacash library.
*
* The plasmacash library is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* The Plasmacash library is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with the plasmacash library. If not, see <http://www.gnu.org/licenses/>.
*/


/**
 * @title Deep Blockchains - Plasma Transaction Debug
 * @author Michael Chung (michael@wolk.com)
 * @dev Plasma Transaction Debug Tool. Helper functions are not exposed in production contract
 */

pragma solidity ^0.4.25;

import './Transaction.sol';

contract TransactionDebug {

    using Transaction for bytes;
    using RLP for bytes;
    using RLP for RLP.RLPItem;
    using RLP for RLP.Iterator;
    using RLPEncode for bytes[];
    using RLPEncode for bytes;

    function verifyTx(bytes txBytes) public pure returns (bool) {
        return txBytes.verifyTx();
    }

    function getSigner(bytes txBytes) public pure returns (address) {
        return txBytes.getSigner();
    }

    function getTxHash(bytes memory txBytes) public pure returns (bytes32) {
        return keccak256(txBytes);
    }

    function getMsgHash(bytes memory txBytes) public pure returns (bytes32) {
        RLP.RLPItem[] memory rlpTx = txBytes.toRLPItem().toList(9);
        bytes[] memory unsignedTx = new bytes[](9);
        for(uint i=0; i<rlpTx.length; i++) {
            if (i!=8){
                unsignedTx[i] = rlpTx[i].toBytes();
            }else{
                unsignedTx[i] = new bytes(0).encodeBytes();
            }
        }
        bytes memory rlpUnsignedTx = unsignedTx.encodeList();
        return keccak256(rlpUnsignedTx);
    }

    function getUnsignedtxBytes(bytes memory txBytes) public pure returns (bytes) {
        RLP.RLPItem[] memory rlpTx = txBytes.toRLPItem().toList(9);
        bytes[] memory unsignedTx = new bytes[](9);
        for(uint i=0; i<rlpTx.length; i++) {
            if (i!=8){
                unsignedTx[i] = rlpTx[i].toBytes();
            }else{
                unsignedTx[i] = new bytes(0).encodeBytes();
            }
        }
        return unsignedTx.encodeList();
    }

    function getTokenID(bytes memory txBytes) public pure returns (uint64) {
        return txBytes.parseTx().TokenID;
    }

    function getDenomination(bytes memory txBytes) public pure returns (uint64) {
        return txBytes.parseTx().Denomination;
    }

    function getDepositIndex(bytes memory txBytes) public pure returns (uint64) {
        return txBytes.parseTx().DepositIndex;
    }

    function getPrevBlock(bytes memory txBytes) public pure returns (uint64) {
        return txBytes.parseTx().PrevBlock;
    }

    function getPrevOwner(bytes memory txBytes) public pure returns (address) {
        return txBytes.parseTx().PrevOwner;
    }

    function getRecipient(bytes memory txBytes) public pure returns (address) {
        return txBytes.parseTx().Recipient;
    }

    function getAllowance(bytes memory txBytes) public pure returns (uint64) {
        return txBytes.parseTx().Allowance;
    }

    function getSpent(bytes memory txBytes) public pure returns (uint64) {
        return txBytes.parseTx().Spent;
    }

    function getBalance(bytes memory txBytes) public pure returns (uint64) {
        return txBytes.parseTx().Balance;
    }

    function getSig(bytes memory txBytes) public pure returns (bytes) {
        RLP.RLPItem[] memory rlpTx = txBytes.toRLPItem().toList(9);
        return rlpTx[8].toData();
    }
}
