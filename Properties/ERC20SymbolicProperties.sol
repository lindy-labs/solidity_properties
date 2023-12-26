// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {MyToken} from "../src/ERC20Examples/Openzeppelin/MyToken.sol"; // A contract to be formally verified

contract ERC20SymbolicProperties is Test {

    MyToken token;

    function setUp() public {
        token = new MyToken("ERC20Token", "ERC20Token", 10 ** 18);
    }

    /*
        prove_Approve: Tests approving a spender to transfer tokens. Checks allowance is set correctly.
    */

    function prove_Approve(address msg_sender, address spender, uint256 amount) public {
        if(msg_sender != address(0) && spender != address(0)) {
            vm.prank(msg_sender);
            bool success = token.approve(spender, amount);
            assert(success);
            assert(token.allowance(msg_sender, spender) ==  amount);
        }
        else revert();
    }

    /*
        prove_Mint: Tests minting new tokens. Checks total supply and recipient balance increase.
    */

    function prove_Mint(address account, uint256 amount) public {
        uint256 _balanceRecipient;
        uint256 _totalSupply;
        _totalSupply = token.totalSupply();
        if(account != address(0) && type(uint256).max - _totalSupply >= amount) {
            _balanceRecipient = token.balanceOf(account);
            token.mint(account, amount);
            assert(token.totalSupply() == _totalSupply + amount);
            assert(token.balanceOf(account) == _balanceRecipient + amount);
        }
        else revert();
    }

    /*
        prove_Burn: Tests burning tokens. Checks total supply and recipient balance decrease.
    */

    function prove_Burn(address account, uint256 amount) public {
        uint256 _balanceRecipient;
        uint256 _totalSupply;
        if(account != address(0)) {
            _balanceRecipient = token.balanceOf(account);
            _totalSupply = token.totalSupply();
            if(_balanceRecipient >= amount) {
                token.burn(account, amount);
                assert(token.totalSupply() == _totalSupply - amount);
                assert(token.balanceOf(account) == _balanceRecipient - amount);
            }
            else revert();
        }
        else revert();
    }

    /*
        prove_Transfer: Tests transferring tokens. Checks sender and recipient balances update.
    */

    function prove_Transfer(address msg_sender, address recipient, uint256 preAmount, uint256 amount) public {
        uint256 _balanceSender;
        uint256 _balanceRecipient;
        token.mint(msg_sender, preAmount);
        _balanceSender = token.balanceOf(msg_sender);
        if(msg_sender != recipient && msg_sender != address(0) && recipient != address(0) && _balanceSender >= amount) {
            _balanceRecipient = token.balanceOf(recipient);
            vm.prank(msg_sender);
            bool success = token.transfer(recipient, amount);
            assert(success);
            assert(token.balanceOf(msg_sender) <=  _balanceSender - amount);
            assert(token.balanceOf(recipient) ==  _balanceRecipient + amount);
        }
        else revert();
    }

    /*
        prove_TransferFrom: Tests transferring tokens via an approved allowance. Checks balances and allowance update.
    */

    function prove_TransferFrom(address msg_sender, address sender, address recipient, uint256 preAmount, uint256 amount) public {
        uint256 _balanceSender;
        uint256 _balanceRecipient;
        uint256 _allowanceFromTo;
        if(msg_sender != address(0) && sender != address(0)) {
            token.mint(msg_sender, preAmount);
            _balanceSender = token.balanceOf(sender);
            _allowanceFromTo = token.allowance(sender, msg_sender);
            if(_balanceSender >= amount && _allowanceFromTo >= amount && recipient != address(0)) {
                _balanceRecipient = token.balanceOf(recipient);
                vm.prank(msg_sender);
                bool success = token.transferFrom(sender, recipient, amount);
                assert(success);
                assert(token.balanceOf(sender) ==  _balanceSender - amount &&
                    token.balanceOf(recipient) ==  _balanceRecipient + amount &&
                    token.allowance(sender, msg_sender) ==  _allowanceFromTo - amount);
            }
            else revert();
        }
        else revert();
    }

    /*
        prove_IncreaseAllowance: Tests increasing allowance. Checks allowance is increased.
    */

    function prove_IncreaseAllowance(address msg_sender, address spender, uint256 addedValue) public {
        uint256 _allowanceFromTo;
        if(msg_sender != address(0) && spender != address(0)) {
            _allowanceFromTo = token.allowance(msg_sender, spender);
            if(_allowanceFromTo + addedValue >= _allowanceFromTo && _allowanceFromTo + addedValue >= addedValue) {
                vm.prank(msg_sender);
                bool success = token.increaseAllowance(spender, addedValue);
                assert(success);
                assert(token.allowance(msg_sender, spender) ==  _allowanceFromTo + addedValue);
            } else revert();
        } else revert();
    }

    /*
        prove_DecreaseAllowance: Tests decreasing allowance. Checks allowance is decreased.
    */

    function prove_DecreaseAllowance(address msg_sender, address spender, uint256 subtractedValue) public {
        uint256 _allowanceFromTo;
        if(msg_sender != address(0) && spender != address(0)) {
            vm.prank(msg_sender);
            _allowanceFromTo = token.allowance(msg_sender, spender);
            if(_allowanceFromTo >= subtractedValue) {
                bool success = token.decreaseAllowance(spender, subtractedValue);
                assert(success);
                assert(token.allowance(msg_sender, spender) ==  _allowanceFromTo - subtractedValue);
            }
            else revert();
        }
        else revert();
    }

// *********************************************** Revertable properties ********************************************************

    /*
        proveFail_ApproveZeroAddressForMSGSender: Tests approve reverts on zero address for msg.sender.
    */

    function proveFail_ApproveZeroAddressForMSGSender(address spender, uint256 amount) public {
        if(spender != address(0)) {
            vm.prank(address(0));
            token.approve(spender, amount);
        }
        else revert();
    }

    /*
        proveFail_ApproveZeroAddressForSpender: Tests approve reverts on zero address for spender.
    */

    function proveFail_ApproveZeroAddress(address msg_sender, uint256 amount) public {
        if(msg_sender != address(0)) {
            vm.prank(msg_sender);
            token.approve(address(0), amount);
        }
        else revert();
    }

    /*
        proveFail_TransferZeroAddressForMSGSender: Tests transfer reverts on zero address for msg.sender.
    */

    function proveFail_TransferZeroAddressForMSGSender(address recipient, uint256 amount) public {
        if(recipient != address(0)) {
            vm.prank(address(0));
            token.transfer(recipient, amount);
        }
        else revert();
    }

    /*
        proveFail_TransferZeroAddressForRecipient: Tests transfer reverts on zero address for recipient.
    */

    function proveFail_TransferZeroAddressForRecipient(address msg_sender, uint256 amount) public {
        if(msg_sender != address(0)) {
            vm.prank(msg_sender);
            token.transfer(address(0), amount);
        }
        else revert();
    }

    /*
        proveFail_TransferFromZeroAddressForMSGSender: Tests transferFrom reverts on zero address for msg.sender.
    */

    function proveFail_TransferFromZeroAddressForMSGSender(address sender, address recipient, uint256 amount) public {
        if(recipient != address(0) && sender != address(0)) {
            vm.prank(address(0));
            token.transferFrom(sender, recipient, amount);
        }
        else revert();
    }

    /*
        proveFail_TransferFromZeroAddressForSender: Tests transferFrom reverts on zero address for sender.
    */

    function proveFail_TransferFromZeroAddressForSender(address msg_sender, address recipient, uint256 amount) public {
        if(msg_sender != address(0) && recipient != address(0)) {
            vm.prank(msg_sender);
            token.transferFrom(address(0), recipient, amount);
        }
        else revert();
    }

    /*
        proveFail_TransferFromZeroAddressForRecipient: Tests transferFrom reverts on zero address for recipient.
    */

    function proveFail_TransferFromZeroAddressForRecipient(address msg_sender, address sender, uint256 amount) public {
        if(msg_sender != address(0) && sender != address(0)) {
            vm.prank(msg_sender);
            token.transferFrom(sender, address(0), amount);
        }
        else revert();
    }

    /*
        proveFail_IncreaseAllowanceZeroAddress: Tests increaseAllowance reverts on zero address for msg.sender.
    */

    function proveFail_IncreaseAllowanceZeroAddressForMSGSender(address spender, uint256 addedValue) public {
        if(spender != address(0)) {
            vm.prank(address(0));
            token.increaseAllowance(spender, addedValue);
        }
        else revert();
    }

    /*
        proveFail_IncreaseAllowanceZeroAddressForSpender: Tests increaseAllowance reverts on zero address for spender.
    */

    function proveFail_IncreaseAllowanceZeroAddressForSpender(address msg_sender, uint256 addedValue) public {
        if(msg_sender != address(0)) {
            vm.prank(msg_sender);
            token.increaseAllowance(address(0), addedValue);
        }
        else revert();
    }

    /*
        proveFail_DecreaseAllowanceZeroAddressMSGSender: Checks that decreasing allowance for the zero address on msg.sender reverts 
    */

    function proveFail_DecreaseAllowanceZeroAddressForMSGSender(address spender, uint256 subtractedValue) public {
        if(spender != address(0)) {
            vm.prank(address(0));
            token.decreaseAllowance(spender, subtractedValue);
        }
        else revert();
    }

    /*
        proveFail_DecreaseAllowanceZeroAddressForSpender: Checks that decreasing allowance for the zero address on spender reverts 
    */

    function proveFail_DecreaseAllowanceZeroAddress(address msg_sender, uint256 subtractedValue) public {
        if(msg_sender != address(0)) {
            vm.prank(msg_sender);
            token.decreaseAllowance(address(0), subtractedValue);
        }
        else revert();
    }

    /*
        proveFail_MintZeroAddress: Checks that minting tokens to the zero address reverts
    */

    function proveFail_MintZeroAddress(address account, uint256 amount) public {
        if(account == address(0)) {
            token.mint(account, amount);
        }
        else revert();
    }

    /*
        proveFail_BurnZeroAddress: Checks that burning from the zero address reverts  
    */

    function proveFail_BurnZeroAddress(address account, uint256 amount) public {
        if(account == address(0)) {
            token.burn(account, amount);
        }
        else revert();
    }

    /*
        proveFail_TransferUnderBalance: Checks that transferring more tokens than the sender has reverts
    */

    function proveFail_TransferUnderBalance(address msg_sender, address recipient, uint256 amount) public {
        if(msg_sender != address(0) && recipient != address(0) && token.balanceOf(msg_sender) < amount) {
            vm.prank(msg_sender);
            token.transfer(recipient, amount);
        }
        else revert();
    }

    /*
        proveFail_TransferFromUnderBalance: Checks that transferring from an account more tokens than it has reverts
    */

    function proveFail_TransferFromUnderBalance(address msg_sender, address sender, address recipient, uint256 amount) public {
        if(msg_sender != address(0) && sender != address(0) && recipient != address(0)) {
            if(token.balanceOf(sender) < amount || token.allowance(sender, msg.sender) < amount) {
                vm.prank(msg_sender);
                token.transferFrom(sender, recipient, amount);
            }
            else revert();
        }
        else revert();
    }

    /*
        proveFail_IncreaseAllowanceUnderAllowance: Checks for overflow when increasing allowance
    */

    function proveFail_TransferFromNotEnoughAmount(address msg_sender, address sender, address recipient, uint256 amount) public {
        if(msg_sender != address(0) && sender != address(0)) {
            if(token.balanceOf(sender) >= amount && token.allowance(sender, msg.sender) >= amount && recipient != address(0)) {
                if(type(uint256).max - token.balanceOf(recipient) < amount) {
                    vm.prank(msg_sender);
                    token.transferFrom(sender, recipient, amount);
                }
                else revert();
            }
            else revert();
        }
        else revert();
    }

    /*
        proveFail_IncreaseAllowanceUnderAllowance: Checks for overflow when increasing allowance
    */

    function proveFail_IncreaseAllowanceUnderAllowance(address msg_sender, address spender, uint256 addedValue) public {
        if(msg_sender != address(0) && spender != address(0)) {
            uint256 _allowanceFromTo = token.allowance(msg.sender, spender);
            if(_allowanceFromTo + addedValue < _allowanceFromTo || _allowanceFromTo + addedValue < addedValue) {
                vm.prank(msg_sender);
                token.increaseAllowance(spender, addedValue);
            } else revert();
        }
        else revert();
    }

    /*
        proveFail_DecreaseAllowanceUnderAllowance: Checks for underflow when decreasing allowance
    */

    function proveFail_DecreaseAllowanceUnderAllowance(address msg_sender, address spender, uint256 subtractedValue) public {
        if(msg_sender != address(0) && spender != address(0)) {
            if(token.allowance(msg.sender, spender) < subtractedValue) {
                vm.prank(msg_sender);
                token.decreaseAllowance(spender, subtractedValue);
            }
            else revert();
        }
        else revert();
    }

    /*
        proveFail_MintUnderSupply: Checks for overflow when minting tokens
    */

    function proveFail_MintUnderSupply(address account, uint256 amount) public {
        if(account != address(0)) {
            if(token.totalSupply() + amount < token.totalSupply() || token.totalSupply() + amount < amount) {
                token.mint(account, amount);
            } else revert();
        }
        else revert();
    }


    /*
        proveFail_BurnUnderSupply: Checks for underflow when burning tokens  
    */

    function proveFail_BurnUnderSupply(address account, uint256 amount) public {
        if(account != address(0)) {
            if(token.balanceOf(account) < amount || token.totalSupply() < amount) {
                token.burn(account, amount);
            }
            else revert();
        }
        else revert();
    }

}

