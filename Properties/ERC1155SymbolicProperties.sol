// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {ERC1155} from "../src/ERC1155Examples/Openzeppelin/ERC1155.sol"; // A contract to be formally verified

contract ERC1155ymbolicProperties is Test {

    ERC1155 token;

    function setUp() public {
        token = new ERC1155("ERC1155Token");
    }

    /*
        prove_setApprovalForAll: Sets approval for operator to manage caller's tokens. Reverts if operator is caller.
    */
    function prove_setApprovalForAll(address msg_sender, address operator, bool approved) public {
        if(msg_sender != operator) {
            vm.prank(msg_sender);
            token.setApprovalForAll(operator, approved);
            assert(token.isApprovedForAll(msg_sender, operator)==approved);
        }
        else revert();
    }

    /*
        prove_safeTransferFrom: Transfers token from one account to another if conditions like approval and balances are met.
            Reverts otherwise.
    */
    function prove_safeTransferFrom(address msg_sender, address from, address to, uint256 id, uint256 initAmount, uint256 amount) public {
        if((from == msg_sender || token.isApprovedForAll(from, msg_sender)) && from != address(0) && to != address(0) && from != to) {
            bytes memory data = new bytes(3);
            uint256 _balanceIdFrom = token.balanceOf(from, id);
            uint256 _balanceIdTo = token.balanceOf(to, id);
            if(_balanceIdFrom >= amount) {
                vm.prank(msg_sender);
                token.safeTransferFrom(from, to, id, amount, data);
                assert(token.balanceOf(from, id) == _balanceIdFrom - amount);
                assert(token.balanceOf(to, id) == _balanceIdTo + amount);
            } else revert();
        } else revert();
    }

    /*
        prove_mint: Mints new tokens for an account. Reverts if account is zero address.
    */
    function prove_mint(address account, uint256 id, uint256 amount) public {
        if(account != address(0)) {
            bytes memory data;
            uint256 _balanceAcc = token.balanceOf(account, id);
            token.mint(account, id, amount, data);
            assert(token.balanceOf(account, id) == _balanceAcc + amount);
        } else revert();
    }

    /*
        prove_burn: Burns tokens of an account if balance allows. Reverts if account is zero address or balance less than
            amount.
    */
    function prove_burn(address account, uint256 id, uint256 amount) public {
        if(account != address(0)) {
            uint256 _balanceAcc = token.balanceOf(account, id);
            token.burn(account, id, amount);
            assert(token.balanceOf(account, id) == _balanceAcc - amount);
        } else revert();
    }

// ********************************* Revertable properties **************************************

    /*
        proveFail_setApprovalForAllSenderEqualsOperator: Negated case of setApprovalForAll. Expects revert if operator is
            caller.
    */
    function proveFail_setApprovalForAllSenderEqualsOperator(address msg_sender, address operator, bool approved) public {
        if(msg_sender == operator) {
            vm.prank(msg_sender);
            token.setApprovalForAll(operator, approved);
        }
        else revert();
    }

    /*
        proveFail_safeTransferFromZeroAddressForFrom: Negated case of safeTransferFrom. Expects revert for zero address.
    */
    function proveFail_safeTransferFromZeroAddressForFrom(address from, address to, uint256 id, uint256 amount) public {
        if(from == address(0)) {
            bytes memory data;
            token.safeTransferFrom(from, to, id, amount, data);
        } else revert();
    }

    /*
        proveFail_safeTransferFromZeroAddressForTo: Negated case of safeTransferFrom. Expects revert for zero address.
    */
    function proveFail_safeTransferFromZeroAddressForTo(address from, address to, uint256 id, uint256 amount) public {
        if(to == address(0)) {
            bytes memory data;
            token.safeTransferFrom(from, to, id, amount, data);
        } else revert();
    }

    /*
        proveFail_safeTransferFromBalanceLessThanAmount: Negated case of safeTransferFrom. Expects revert if balance less
            than transfer amount.
    */
    function proveFail_safeTransferFromBalanceLessThanAmount(address from, address to, uint256 id, uint256 initAmount, uint256 amount) public {
        if((from == msg.sender || token.isApprovedForAll(from, msg.sender)) && from != address(0) && to != address(0) && from != to) {
            bytes memory data;
            uint256 _balanceIdFrom = token.balanceOf(from, id);
            if(_balanceIdFrom < amount) {
                token.safeTransferFrom(from, to, id, amount, data);
            } else revert();
        } else revert();
    }

    /*
        proveFail_mintZeroAddress: Negated case of mint. Expects revert for zero address.
    */
    function proveFail_mintZeroAddress(address account, uint256 id, uint256 amount) public {
        if(account == address(0)) {
            bytes memory data;
            token.mint(account, id, amount, data);
        } else revert();
    }

    /*
        proveFail_burnZeroAddress: Negated case of burn. Expects revert for zero address.
    */
    function proveFail_burnZeroAddress(address account, uint256 id, uint256 amount) public {
        if(account == address(0)) {
            token.burn(account, id, amount);
        } else revert();
    }

    /*
        proveFail_burnBalanceLessThanAmount: Negated case of burn. Expects revert if balance less than burn amount.
    */
    function proveFail_burnBalanceLessThanAmount(address account, uint256 id, uint256 amount) public {
        if(account != address(0)) {
            uint256 balanceAcc = token.balanceOf(account, id);
            if(balanceAcc < amount) {
                token.burn(account, id, amount);
                vm.expectRevert();
            } else revert();
        } else revert();
    }
    
}

