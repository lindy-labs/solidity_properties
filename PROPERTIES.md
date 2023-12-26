# Introduction

This file lists all the currently implemented Ethereum's hevm property tests for ERC20, ERC721, and ERC1155. For each property, there is a permalink to the file implementing it in the repository and a small description of the property.

## Table of contents

- [Introduction](#introduction)
  - [Table of contents](#table-of-contents)
  - [ERC20](#erc20)
  - [ERC721](#erc721)
  - [ERC1155](#erc1155)

## ERC20

### Expected properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC20-EXPECT-001 | [prove_Approve](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L19)                   | Tests approving a spender to transfer tokens. Checks allowance is set correctly      |
| ERC20-EXPECT-002 | [prove_Mint](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L33)                   | Tests minting new tokens. Checks total supply and recipient balance increase      |
| ERC20-EXPECT-003 | [prove_Burn](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L50)                   | Tests burning tokens. Checks total supply and recipient balance decrease     |
| ERC20-EXPECT-004 | [prove_Transfer](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L70)                   | Tests transferring tokens. Checks sender and recipient balances update      |
| ERC20-EXPECT-005 | [prove_TransferFrom](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L90)                   |  Tests transferring tokens via an approved allowance. Checks balances and allowance update     |
| ERC20-EXPECT-006 | [prove_Appprove_IncreaseAllowance](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L116)                   | Tests increasing allowance. Checks allowance is increased      |
| ERC20-EXPECT-007 | [prove_DecreaseAllowance](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L133)                   | Tests decreasing allowance. Checks allowance is decreased      |

### Revertable properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC20-REVERT-001 | [proveFail_ApproveZeroAddressForMSGSender](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L154)                   | Tests approve reverts on zero address for msg.sender      |
| ERC20-REVERT-002 | [proveFail_ApproveZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L166)                   | Tests approve reverts on zero address for spender      |
| ERC20-REVERT-003 | [proveFail_TransferZeroAddressForMSGSender](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L178)                   | Tests transfer reverts on zero address for msg.sender      |
| ERC20-REVERT-004 | [proveFail_TransferZeroAddressForRecipient](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L190)                   | Tests transfer reverts on zero address for recipient      |
| ERC20-REVERT-005 | [proveFail_TransferFromZeroAddressForMSGSender](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L202)                   | Tests transferFrom reverts on zero address for msg.sender      |
| ERC20-REVERT-006 | [proveFail_TransferFromZeroAddressForSender](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L214)                   | Tests transferFrom reverts on zero address for sender      |
| ERC20-REVERT-007 | [proveFail_TransferFromZeroAddressForRecipient](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L226)                   | Tests transferFrom reverts on zero address for recipient      |
| ERC20-REVERT-008 | [proveFail_IncreaseAllowanceZeroAddressForMSGSender](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L238)                   | Tests increaseAllowance reverts on zero address for msg.sender      |
| ERC20-REVERT-009 | [proveFail_IncreaseAllowanceZeroAddressForSpender](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L250)                   | Tests increaseAllowance reverts on zero address for spender      |
| ERC20-REVERT-010 | [proveFail_DecreaseAllowanceZeroAddressForMSGSender](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L262)                   | Checks that decreasing allowance for the zero address on msg.sender reverts       |
| ERC20-REVERT-011 | [proveFail_DecreaseAllowanceZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L274)                   | Checks that decreasing allowance for the zero address on spender reverts      |
| ERC20-REVERT-012 | [proveFail_MintZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L286)                   | Checks that minting tokens to the zero address reverts      |
| ERC20-REVERT-013 | [proveFail_BurnZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L297)                   | Checks that burning from the zero address reverts      |
| ERC20-REVERT-014 | [proveFail_TransferUnderBalance](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L308)                   | Checks that transferring more tokens than the sender has reverts      |
| ERC20-REVERT-015 | [proveFail_TransferFromUnderBalance](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L320)                   | Checks that transferring from an account more tokens than it has reverts      |
| ERC20-REVERT-016 | [proveFail_TransferFromNotEnoughAmount](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L335)                   | Checks for overflow when increasing allowance      |
| ERC20-REVERT-017 | [proveFail_IncreaseAllowanceUnderAllowance](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L353)                   | Checks for overflow when increasing allowance      |
| ERC20-REVERT-018 | [proveFail_DecreaseAllowanceUnderAllowance](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L368)                   | Checks for underflow when decreasing allowance      |
| ERC20-REVERT-019 | [proveFail_MintUnderSupply](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L383)                   | Checks for overflow when minting tokens      |
| ERC20-REVERT-020 | [proveFail_BurnUnderSupply](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC20SymbolicProperties.sol#L397)                   | Checks for underflow when burning tokens      |

## ERC721

### Expected properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC721-EXPECT-001 | [prove_ApproveForOwner](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L16)                   | Checks that approve transfers token ownership to the approved address if sender is the owner. Reverts otherwise      |
| ERC721-EXPECT-002 | [prove_ApproveForApprovedOp](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L34)                   | Checks that approve transfers token ownership to the approved address if sender is the approved operator. Reverts otherwise      |
| ERC721-EXPECT-003 | [prove_setApprovalForAll](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L48)                   | Checks that setApprovalForAll sets operator approval if operator is not sender. Reverts otherwise      |
| ERC721-EXPECT-004 | [prove_transferFrom](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L59)                   | Mints a token to from address, approves token to to address, transfers token using transferFrom, and checks balances and ownership transferred correctly      |
| ERC721-EXPECT-005 | [prove_safeTransferFrom](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L82)                   | Mints a token to from address, approves token to to address, transfers token using safeTransferFrom, and checks balances and ownership transferred correctly      |
| ERC721-EXPECT-006 | [prove_Mint](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L105)                   | Mints a token to a non-zero address and checks balance increased and new ownership      |
| ERC721-EXPECT-007 | [prove_Burn](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L119)                   | Burns a token owned by an address and checks approval cleared and ownership removed      |

### Revertable properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC721-REVERT-001 | [proveFail_ApproveToOwner](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L140)                   | Tries approving a token to its existing owner which should fail      |
| ERC721-REVERT-002 | [proveFail_ApproveOwnerIsNotSender](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L154)                   | Tries approving from non-owner and without operator approval which should fail      |
| ERC721-REVERT-003 | [proveFail_setApprovalForAllWithOperatorAsSender](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L168)                   | Tries setting approval with operator as sender which should fail      |
| ERC721-REVERT-004 | [proveFail_transferFromFromZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L176)                   | Tries transferFrom with 0 address from from which should fail      |
| ERC721-REVERT-005 | [proveFail_transferFromToZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L191)                   | Tries transferFrom with 0 address for to which should fail      |
| ERC721-REVERT-006 | [proveFail_transferFromWhenFromEqualsTo](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L207)                   | Tries transferFrom to self which should fail      |
| ERC721-REVERT-007 | [proveFail_transferFromOwnerIsZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L222)                   | Tries transferFrom with token having no owner which should fail      |
| ERC721-REVERT-008 | [proveFail_transferFromWhenTokensOwnerIsNotFrom](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L234)                   | Tries transferFrom as non-owner which should fail      |
| ERC721-REVERT-009 | [proveFail_safeTransferFromFromIsZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L246)                   | Tries safeTransferFrom with 0 address for from which should fail      |
| ERC721-REVERT-010 | [proveFail_safeTransferFromToIsZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L261)                   | Tries safeTransferFrom with 0 address for to which should fail      |
| ERC721-REVERT-011 | [proveFail_safeTransferFromOwnerIsZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L276)                   | Tries safeTransferFrom with unowned token which should fail      |
| ERC721-REVERT-012 | [proveFail_safeTransferFromWhenTokensOwnerIsNotFrom](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L291)                   | Tries safeTransferFrom as non-owner which should fail      |
| ERC721-REVERT-013 | [proveFail_MintToIsZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L306)                   | Tries minting to 0 address which should fail      |
| ERC721-REVERT-014 | [proveFailBurnOwnersBalanceIsLessThanOne](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC721SymbolicProperties.sol#L315)                   | Tries burning without owner balance which should fail      |

## ERC1155

### Expected properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC1155-EXPECT-001 | [prove_setApprovalForAll](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC1155SymbolicProperties.sol#L18)                   | Sets approval for operator to manage caller's tokens. Reverts if operator is caller      |
| ERC1155-EXPECT-002 | [prove_safeTransferFrom](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC1155SymbolicProperties.sol#L31)                   | Transfers token from one account to another if conditions like approval and balances are met      |
| ERC1155-EXPECT-003 | [prove_mint](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC1155SymbolicProperties.sol#L48)                   | Mints new tokens for an account. Reverts if account is zero address      |
| ERC1155-EXPECT-004 | [prove_burn](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC1155SymbolicProperties.sol#L58)                   | Burns tokens of an account if balance allows. Reverts if account is zero address or balance less than amount      |

### Revertable properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC1155-REVERT-001 | [proveFail_setApprovalForAllSenderEqualsOperator](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC1155SymbolicProperties.sol#L75)                   | Negated case of setApprovalForAll. Expects revert if operator is caller      |
| ERC1155-REVERT-002 | [proveFail_safeTransferFromZeroAddressForFrom](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC1155SymbolicProperties.sol#L86)                   | Negated case of safeTransferFrom. Expects revert for zero address      |
| ERC1155-REVERT-003 | [proveFail_safeTransferFromZeroAddressForTo](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC1155SymbolicProperties.sol#L96)                   | Negated case of safeTransferFrom. Expects revert for zero address      |
| ERC1155-REVERT-004 | [proveFail_safeTransferFromBalanceLessThanAmount](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC1155SymbolicProperties.sol#L107)                   | NNegated case of safeTransferFrom. Expects revert if balance less than transfer amount      |
| ERC1155-REVERT-005 | [proveFail_mintZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC1155SymbolicProperties.sol#L120)                   | Negated case of mint. Expects revert for zero address      |
| ERC1155-REVERT-006 | [proveFail_burnZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC1155SymbolicProperties.sol#L130)                   | Negated case of burn. Expects revert for zero address      |
| ERC1155-REVERT-007 | [proveFail_burnBalanceLessThanAmount](https://github.com/lindy-labs/solidity_properties/blob/main/Properties/ERC1155SymbolicProperties.sol#L139)                   | Negated case of burn. Expects revert if balance less than burn amount      |
