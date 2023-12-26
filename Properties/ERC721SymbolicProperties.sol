// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {ERC721} from "../src/ERC721Examples/NFT-Marketplace/ERC721.sol"; // A contract to be formally verified

contract ERC721SymbolicProperties is Test {

    ERC721 token;

    function setUp() public {
        token = new ERC721("ERC721Token", "ERC721Token");
    }

    /*
        prove_ApproveForOwner: Checks that approve transfers token ownership to the approved address if sender is the owner. Reverts otherwise.
    */

    function prove_ApproveForOwner(address msg_sender, address to, uint256 tokenId) public {
        address owner = token.ownerOf(tokenId);
        if(to != owner) {
            if(msg_sender == owner && !token.isApprovedForAll(owner, msg_sender)) {
                vm.prank(msg_sender);
                token.approve(to, tokenId);
                assert(token.getApproved(tokenId) ==  to);
            } else revert();
        } else revert();
    }

    /*
        prove_ApproveForApprovedOp: Checks that approve transfers token ownership to the approved address if sender is the approved operator. Reverts otherwise.
    */

    function prove_ApproveForApprovedOp(address msg_sender, address to, uint256 tokenId) public {
        address owner = token.ownerOf(tokenId);
        if(to != owner) {
            if(msg_sender != owner && token.isApprovedForAll(owner, msg_sender)) {
                vm.prank(msg_sender);
                token.approve(to, tokenId);
                assert(token.getApproved(tokenId) ==  to);
            } else revert();
        } else revert();
    }

    /*
        prove_setApprovalForAll: Checks that setApprovalForAll sets operator approval if operator is not sender. Reverts otherwise.
    */
    function prove_setApprovalForAll(address msg_sender, address operator, bool approved) public {
        if(operator != msg_sender) {
            vm.prank(msg_sender);
            token.setApprovalForAll(operator, approved);
            assert(token.isApprovedForAll(msg_sender, operator) == approved);
        } else revert();
    }

    /*
        prove_transferFrom: Mints a token to from address, approves token to to address, transfers token using transferFrom, and checks balances and ownership transferred correctly.
    */
    function prove_transferFrom(address msg_sender, address from, address to, uint256 tokenId) public {
        if(from != address(0) && to != address(0) && from != to) {
            token.mint(from, tokenId);
            address owner = token.ownerOf(tokenId);
            if(owner != address(0) && owner == from) {
                if(msg_sender == owner || token.getApproved(tokenId) == msg_sender || token.isApprovedForAll(owner, msg_sender)) {
                    uint256 _balancesFrom = token.balanceOf(from);
                    uint256 _balancesTo = token.balanceOf(to);

                    vm.prank(msg_sender);
                    token.transferFrom(from, to, tokenId);

                    assert(token.balanceOf(from) == _balancesFrom - 1);
                    assert(token.balanceOf(to) == _balancesTo + 1);
                    assert(token.ownerOf(tokenId) == to);
                } else revert();
            } else revert();
        } else revert();
    }

    /*
        prove_safeTransferFrom: Mints a token to from address, approves token to to address, transfers token using safeTransferFrom, and checks balances and ownership transferred correctly.
    */
    function prove_safeTransferFrom(address msg_sender, address from, address to, uint256 tokenId) public {
        if(from != address(0) && to != address(0) && from != to) {
            token.mint(from, tokenId);
            address owner = token.ownerOf(tokenId);
            if(owner != address(0) && owner == from) {
                if(msg_sender == owner || token.getApproved(tokenId) == msg_sender || token.isApprovedForAll(owner, msg_sender)) {
                    uint256 _balancesFrom = token.balanceOf(from);
                    uint256 _balancesTo = token.balanceOf(to);

                    vm.prank(msg_sender);
                    token.safeTransferFrom(from, to, tokenId);

                    assert(token.balanceOf(from) == _balancesFrom - 1);
                    assert(token.balanceOf(to) == _balancesTo + 1);
                    assert(token.ownerOf(tokenId) == to);
                } else revert();
            } else revert();
        } else revert();
    }

    /*
        prove_Mint: Mints a token to a non-zero address and checks balance increased and new ownership.
    */
    function prove_Mint(address to, uint256 tokenId) public {
        if(to != address(0)) {
            uint256 _balanceTo = token.balanceOf(to);

            token.mint(to, tokenId);

            assert(token.balanceOf(to) == _balanceTo + 1);
            assert(token.ownerOf(tokenId) == to);
        } else revert();
    }

    /*
        prove_Burn: Burns a token owned by an address and checks approval cleared and ownership removed.
    */
    function prove_Burn(uint256 tokenId, uint256 initToken) public {
        address owner = token.ownerOf(tokenId);
        if(owner != address(0)) {
            token.mint(owner, initToken);
            uint256 _balanceOwner = token.balanceOf(owner);
            if(_balanceOwner >= 1) {

                token.burn(tokenId);

                assert(token.balanceOf(owner) == _balanceOwner - 1);
                assert(token.getApproved(tokenId) ==  address(0));
                assert(token.ownerOf(tokenId) == address(0));
            } else revert();
        } else revert();
    }
    
// ********************************** Revertable properties ***********************************************

    /*
        proveFail_ApproveToOwner: Tries approving a token to its existing owner which should fail.
    */
    function proveFail_ApproveToOwner(address msg_sender, address to, uint256 tokenId) public {
        address owner = token.ownerOf(tokenId);
        if(to == owner) {
            if(msg_sender == owner || token.isApprovedForAll(owner, msg_sender)) {
                vm.prank(msg_sender);
                token.approve(to, tokenId);
                assert(token.getApproved(tokenId) ==  to);
            } else revert();
        } else revert();
    }

    /*
        proveFail_ApproveOwnerIsNotSenderAndForAll: Tries approving from non-owner and without operator approval which should fail.
    */
    function proveFail_ApproveOwnerIsNotSender(address msg_sender, address to, uint256 tokenId) public {
        address owner = token.ownerOf(tokenId);
        if(to != owner) {
            if(msg_sender != owner && !token.isApprovedForAll(owner, msg_sender)) {
                vm.prank(msg_sender);
                token.approve(to, tokenId);
                assert(token.getApproved(tokenId) ==  to);
            } else revert();
        } else revert();
    }

    /*
        proveFail_setApprovalForAllWithOperatorAsSender: Tries setting approval with operator as sender which should fail.
    */
    function proveFail_setApprovalForAllWithOperatorAsSender(address operator, bool approved) public {
        vm.prank(operator);
        token.setApprovalForAll(operator, approved);
    }

    /*
        proveFail_transferFromFromZeroAddress: Tries transferFrom with 0 address from from which should fail.
    */
    function proveFail_transferFromFromZeroAddress(address msg_sender, address from, address to, uint256 tokenId, uint256 initToken) public {
        if(from == address(0)) {
            address owner = token.ownerOf(tokenId);
            if(owner != address(0) && owner == from) {
                if(msg_sender == owner || token.isApprovedForAll(owner, msg_sender)) {
                    vm.prank(msg_sender);
                    token.transferFrom(from, to, tokenId);
                } else revert();
            } else revert();
        } else revert();
    }

    /*
        proveFail_transferFromToZeroAddress: Tries transferFrom with 0 address for to which should fail.
    */
    function proveFail_transferFromToZeroAddress(address msg_sender, address from, address to, uint256 tokenId, uint256 initToken) public {
        if(to == address(0)) {
            address owner = token.ownerOf(tokenId);
            if(owner != address(0) && owner == from) {
                if(msg_sender == owner || token.isApprovedForAll(owner, msg_sender)) {
                    vm.prank(msg_sender);
                    token.transferFrom(from, to, tokenId);
                } else revert();
            } else revert();
        } else revert();
    }


    /*
        proveFail_transferFromWhenFromEqualsTo: Tries transferFrom to self which should fail.
    */
    function proveFail_transferFromWhenFromEqualsTo(address msg_sender, address from, address to, uint256 tokenId, uint256 initToken) public {
        if(from != address(0) && to != address(0) && from == to) {
            address owner = token.ownerOf(tokenId);
            if(owner != address(0) && owner == from) {
                if(msg_sender == owner || token.isApprovedForAll(owner, msg_sender)) {
                    vm.prank(msg_sender);
                    token.transferFrom(from, to, tokenId);
                } else revert();
            } else revert();
        } else revert();
}

    /*
        proveFail_transferFromOwnerIsZeroAddress: Tries transferFrom with token having no owner which should fail.
    */
    function proveFail_transferFromOwnerIsZeroAddress(address from, address to, uint256 tokenId, uint256 initToken) public {
        if(from != address(0) && to != address(0) && from != to) {
            address owner = token.ownerOf(tokenId);
            if(owner == address(0)) {
                token.transferFrom(from, to, tokenId);
            } else revert();
        } else revert();
    }

    /*
        proveFail_transferFromWhenTokensOwnerIsNotFrom: Tries transferFrom as non-owner which should fail.
    */
    function proveFail_transferFromWhenTokensOwnerIsNotFrom(address from, address to, uint256 tokenId, uint256 initToken) public {
        if(from != address(0) && to != address(0) && from != to) {
            address owner = token.ownerOf(tokenId);
            if(owner != address(0) && owner != from) {
                token.transferFrom(from, to, tokenId);
            } else revert();
        } else revert();
    }

    /*
        proveFail_safeTransferFromFromIsZeroAddress: Tries safeTransferFrom with 0 address for from which should fail.
    */
    function proveFail_safeTransferFromFromIsZeroAddress(address msg_sender, address from, address to, uint256 tokenId, uint256 initToken) public {
          if(from == address(0) && to != address(0)) {
            address owner = token.ownerOf(tokenId);
            if(owner != address(0) && owner == from) {
                if(msg_sender == owner || token.isApprovedForAll(owner, msg_sender)) {
                        vm.prank(msg_sender);
                        token.safeTransferFrom(from, to, tokenId);
                } else revert();
            } else revert();
        } else revert();
    }

    /*
        proveFail_safeTransferFromToIsZeroAddress: Tries safeTransferFrom with 0 address for to which should fail.
    */
    function proveFail_safeTransferFromToIsZeroAddress(address msg_sender, address from, address to, uint256 tokenId, uint256 initToken) public {
          if(from != address(0) && to == address(0)) {
            address owner = token.ownerOf(tokenId);
            if(owner != address(0) && owner == from) {
                if(msg_sender == owner || token.isApprovedForAll(owner, msg_sender)) {
                        vm.prank(msg_sender);
                        token.safeTransferFrom(from, to, tokenId);
                } else revert();
            } else revert();
        } else revert();
    }

    /*
        proveFail_safeTransferFromOwnerIsZeroAddress: Tries safeTransferFrom with unowned token which should fail.
    */
    function proveFail_safeTransferFromOwnerIsZeroAddress(address msg_sender, address from, address to, uint256 tokenId, uint256 initToken) public { // Need to fix this
          if(from != address(0) && to != address(0) && from != to) {
            address owner = token.ownerOf(tokenId);
            if(owner == address(0)) {
                if(msg_sender == owner || token.isApprovedForAll(owner, msg_sender)) {
                        vm.prank(msg_sender);
                        token.safeTransferFrom(from, to, tokenId);
                } else revert();
            } else revert();
        } else revert();
    }

    /*
        proveFail_safeTransferFromWhenTokensOwnerIsNotFrom: Tries safeTransferFrom as non-owner which should fail.
    */
    function proveFail_safeTransferFromWhenTokensOwnerIsNotFrom(address msg_sender, address from, address to, uint256 tokenId, uint256 initToken) public {
          if(from != address(0) && to != address(0) && from != to) {
            address owner = token.ownerOf(tokenId);
            if(owner != address(0) && owner != from) {
                if(msg_sender == owner || token.isApprovedForAll(owner, msg_sender)) {
                        vm.prank(msg_sender);
                        token.safeTransferFrom(from, to, tokenId);
                } else revert();
            } else revert();
        } else revert();
    }

    /*
        proveFail_MintToIsZeroAddress: Tries minting to 0 address which should fail.
    */
    function proveFail_MintToIsZeroAddress(address to, uint256 tokenId) public {
        if(to == address(0)) {
            token.mint(to, tokenId);
        } else revert();
    }

    /*
        proveFailBurnOwnersBalanceIsLessThanOne: Tries burning without owner balance which should fail.
    */
    function proveFailBurnOwnersBalanceIsLessThanOne(uint256 tokenId, uint256 initToken) public {
        address owner = token.ownerOf(tokenId);
        if(owner != address(0)) {
            if(token.balanceOf(owner) < 1) {
                token.burn(tokenId);
            } else revert();
        } else revert();
    }
    
}