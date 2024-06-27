# Introduction

This file lists all the currently implemented Ethereum's hevm property tests for ERC20, ERC721, and ERC1155. For each property, there is a permalink to the file implementing it in the repository and a small description of the property.

## Table of contents

- [Introduction](#introduction)
  - [Table of contents](#table-of-contents)
  - [ERC20](#erc20)
  - [ERC721](#erc721)
  - [ERC1155](#erc1155)
  - [ERC4626](#erc4626)

## ERC20

### Expected properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC20-EXPECT-001 | [prove_Approve](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#18) | Proves approving a spender to transfer tokens. Checks allowance is set correctly. |
| ERC20-EXPECT-002 | [prove_Mint](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#26) | Proves minting new tokens. Checks total supply and recipient balance increase. |
| ERC20-EXPECT-003 | [prove_MintZeroTokens](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#38) | Proves minting zero tokens. Checks balance is not changed. |
| ERC20-EXPECT-004 | [prove_BurnSameAccount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#46) | Proves burning tokens, when using the same account. Checks total supply and recipient balance decrease. |
| ERC20-EXPECT-005 | [prove_BurnDifferentAccount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#58) | Proves burning tokens, when using different accounts. Checks total supply and recipient balance decrease. |
| ERC20-EXPECT-006 | [prove_Transfer](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#74) | Proves transferring tokens. Checks sender and recipient balances update. |
| ERC20-EXPECT-007 | [prove_TransferFrom](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#89) | Proves transferring tokens via an approved allowance. Checks balances and allowance update. |
| ERC20-EXPECT-008 | [prove_IncreaseAllowance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#106) | Proves increasing allowance. Checks allowance is increased. |
| ERC20-EXPECT-009 | [prove_DecreaseAllowance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#120) | Proves decreasing allowance. Checks allowance is decreased. |
| ERC20-EXPECT-010 | [prove_BurnFromNonZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#134) | Proves burning from non-zero address. Checks balance is decreased. |
| ERC20-EXPECT-011 | [prove_BurnZeroTokens](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#143) | Proves burning zero tokens. Checks balance is not changed. |
| ERC20-EXPECT-012 | [prove_ApproveNonZeroAmount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#151) | Proves that approve works as expected. |
| ERC20-EXPECT-013 | [prove_ApproveZeroAmount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#159) | Proves approving zero amount |
| ERC20-EXPECT-014 | [prove_ApproveMaxAmount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#166) | Proves approving max amount |
| ERC20-EXPECT-015 | [prove_TransferZeroAmount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#174) | Proves that transfering zero amount reverts. |
| ERC20-EXPECT-016 | [prove_TransferFromZeroAmount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#186) | Proves that transferring from a zero address works. |
| ERC20-EXPECT-017 | [prove_ZeroAddressHasNoToken](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#198) | Proves that a zero address SHOULD have no tokens. |
| ERC20-EXPECT-018 | [prove_MsgSenderCanRetrieveOwnBalance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#203) | Proves that a msg.sender SHOULD be able to retrieve balance of himself/herself |
| ERC20-EXPECT-019 | [prove_MsgSenderCanRetrieveOtherBalance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#209) | Proves that a msg.sender SHOULD be able to retrieve balance of another address |
| ERC20-EXPECT-020 | [prove_ConsecutiveApprovePositiveToPositive](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#217) | Proves that consecutive approves from the same owner to the same spender |
| ERC20-EXPECT-021 | [prove_TransferFromNoFees](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#231) | Proves that a transferFrom SHOULD NOT charge fees |
| ERC20-EXPECT-022 | [prove_TransferFromAllowanceReachesZero](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#251) | Proves that multiple calls of transferFrom SHOULD NOT be allowed once allowance reach zero even if the tokenSender's balance is more than the allowance |
| ERC20-EXPECT-023 | [prove_MultipleTransfersAllowed](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#279) | Proves that multiple transfers SHOULD be allowed if the sender has enough balance and allowance |
| ERC20-EXPECT-024 | [prove_MultipleTransferFromAllowed](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#304) | Proves that multiple transferFrom calls SHOULD be allowed if the owner has enough balance and allowance |
| ERC20-EXPECT-025 | [prove_SelfApprovePositiveAmount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#329) | Proves that the owner can approve the spender to spend the amount of tokens |
| ERC20-EXPECT-026 | [prove_SelfApproveAndTransferFromOwnAccount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#337) | Proves that the owner can approve the spender to spend the amount of tokens |
| ERC20-EXPECT-027 | [prove_SelfTransferPositiveAmountAllowed](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#356) | Proves that the owner can transfer the amount of tokens |
| ERC20-EXPECT-028 | [prove_TokenReceiverCanTransferFromTotalBalance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#366) | Proves that the token receiver can transfer the amount of tokens from the token sender |
| ERC20-EXPECT-029 | [prove_MsgSenderCanTransferTotalBalance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#385) | Proves that the msg.sender can transfer the amount of tokens from the token sender |
| ERC20-EXPECT-030 | [prove_TransferDoesNotUpdateOtherBalances](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#402) | Proves that the transfer function does not update the balances of the token sender and receiver |
| ERC20-EXPECT-031 | [prove_TransferFromDecreasesAllowance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#422) | Proves that the transferFrom function decreases the allowance of the spender |
| ERC20-EXPECT-032 | [prove_TransferFromDoesNotUpdateOtherBalances](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#441) | Proves that the transferFrom function does not update the balances of the token sender and receiver |
| ERC20-EXPECT-033 | [prove_MultipleTransfersOfZeroAmountAllowed](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#466) | Proves that multiple transfers of zero amount are allowed |
| ERC20-EXPECT-034 | [prove_MultipleTransferFromsOfZeroAmountAllowed](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#484) | Proves that multiple transferFroms of zero amount are allowed |
| ERC20-EXPECT-035 | [prove_SelfApproveZeroAmountAllowed](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#508) | Proves that self-approval of zero amount is allowed |
| ERC20-EXPECT-036 | [prove_SelfApproveAndTransferFromOwnAccountZeroAmountAllowed](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#516) | Proves that self-approval and transferFrom of zero amount are allowed |
| ERC20-EXPECT-037 | [prove_SelfTransferZeroAmountAllowed](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#531) | Proves that self-transfer of zero amount is allowed |
| ERC20-EXPECT-038 | [prove_TokenReceiverCanTransferFromTotalBalanceZero](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#538) | Proves that a token receiver can transferFrom the total balance of a token |
| ERC20-EXPECT-039 | [prove_MsgSenderCanTransferTotalBalanceZero](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#554) | Proves that a token sender can transfer the total balance of a token |
| ERC20-EXPECT-040 | [prove_TransferFromZeroAmountToZeroAddressReverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#568) | Proves that a token sender can transferFrom the total balance of a token to the zero address |
| ERC20-EXPECT-041 | [prove_TransferZeroAmountToZeroAddressReverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#580) | Proves that a token sender can transfer the zero amount of a token to the zero address |
| ERC20-EXPECT-042 | [prove_AllowanceUpdatedAfterBurn](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#586) | Proves that the allowance of a token sender is updated after burning |
| ERC20-EXPECT-043 | [prove_BalanceUpdatedAfterBurn](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#602) | Proves that the balance of a token sender is updated after burning. The balance of the tokenSender is decreased by the burned amount. |
### Revertable properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC20-REVERT-001 | [proveFail_ApproveZeroAddressForMSGSender](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#622) | Proves approve reverts on zero address for msg.sender. |
| ERC20-REVERT-002 | [proveFail_ApproveZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#629) | Proves approve reverts on zero address for spender. |
| ERC20-REVERT-003 | [proveFail_MintToZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#636) | Proves minting to zero address reverts. |
| ERC20-REVERT-004 | [proveFail_MintOverflow](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#647) | Proves minting overflow. Checks minting fails. |
| ERC20-REVERT-005 | [proveFail_TransferFromZeroAddressForMSGSender](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#659) | Proves transferFrom reverts on zero address for msg.sender. |
| ERC20-REVERT-006 | [proveFail_TransferUnderBalance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#667) | Proves that transferring more tokens than the sender has reverts |
| ERC20-REVERT-007 | [proveFail_TransferFromUnderBalance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#675) | Proves that transferring from an account more tokens than it has reverts |
| ERC20-REVERT-008 | [proveFail_TransferFromNotEnoughAmount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#684) | Proves for overflow when increasing allowance |
| ERC20-REVERT-009 | [proveFail_IncreaseAllowanceUnderAllowance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#694) | Proves for overflow when increasing allowance |
| ERC20-REVERT-010 | [proveFail_DecreaseAllowanceUnderAllowance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#704) | Proves for underflow when decreasing allowance |
| ERC20-REVERT-011 | [proveFail_MintUnderSupply](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#715) | Proves for overflow when minting tokens |
| ERC20-REVERT-012 | [proveFail_BurnUnderSupply](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#724) | Proves for underflow when burning tokens |
| ERC20-REVERT-013 | [proveFail_BurnFromZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#732) | Proves burning from zero address reverts. |
| ERC20-REVERT-014 | [proveFail_BurnUnderBalance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#743) | Proves burning an amount that is greater than the balance of the account reverts. |
| ERC20-REVERT-015 | [proveFail_ApproveFromZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#756) | Proves approving from zero address reverts. |
| ERC20-REVERT-016 | [proveFail_ApproveToZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#768) | Proves approving to zero address reverts. |
| ERC20-REVERT-017 | [proveFail_TransferToZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#779) | Proves that transferring to the zero address reverts. |
| ERC20-REVERT-018 | [proveFail_TransferFromZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#791) | Proves that transferring from the zero address reverts. |
| ERC20-REVERT-019 | [proveFail_TransferUnderBalance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#801) | Proves that transferring more than the balance reverts. |
| ERC20-REVERT-020 | [proveFail_TransferFromToZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#813) | Proves that transferring to the zero address reverts. |
| ERC20-REVERT-021 | [proveFail_TransferFromZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#826) | Proves that transferring from the zero address reverts. |
| ERC20-REVERT-022 | [proveFail_TransferFromUnderBalance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC20SymbolicProperties.sol#836) | Proves that transferring from an address with a balance under the amount reverts. |


## ERC721

### Expected properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC721-EXPECT-001 | [prove_setApprovalForAll](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#37) | This function verifies the `setApprovalForAll` function of the ERC721 contract. It sets the approval for an operator and checks if the `isApprovedForAll` function returns the correct value. |
| ERC721-EXPECT-002 | [prove_ApproveWhenOwnerEqualsMSGSender](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#44) | This function verifies the `approve` function when the owner of the token is the same as the message sender. It mints a token for the message sender, approves a spender, and checks if the `getApproved` function returns the correct spender address. |
| ERC721-EXPECT-003 | [prove_ApproveWhenIsApprovedForAllOnwerDifferentFromMSGSender](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#55) | This function verifies the `approve` function when the owner of the token is different from the message sender, but the message sender is approved for all tokens of the owner. |
| ERC721-EXPECT-004 | [prove_transferFrom](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#68) | This function verifies the `transferFrom` function of the ERC721 contract. It mints a token for the `from` address, checks if the caller is the owner or an approved operator, transfers the token to the `to` address, and verifies the balances and ownership. |
| ERC721-EXPECT-005 | [prove_safeTransferFrom](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#87) | This function verifies the `safeTransferFrom` function of the ERC721 contract, similar to `prove_transferFrom`. |
| ERC721-EXPECT-006 | [prove_Mint](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#107) | This function mints a new ERC721 token with the given `id` and transfers ownership to the `to` address. |
| ERC721-EXPECT-007 | [prove_Burn](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#118) | This function burns (destroys) the ERC721 token with the given `id`. |

### Revertable properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC721-REVERT-001 | [proveFail_ApproveWhenIdHasNotAnOwner](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#137) | This function verifies that the `approve` function reverts when the given token ID does not have an owner. |
| ERC721-REVERT-002 | [proveFail_ApproveWhenIsNotApprovedForAll](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#143) | This function verifies that the `approve` function reverts when the caller is not the owner of the token and is not approved for all tokens of the owner. |
| ERC721-REVERT-003 | [proveFail_transferFromWhenFromIsNotTheOwner](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#156) | This function verifies that the `transferFrom` function reverts when the `from` address is not the owner of the token. |
| ERC721-REVERT-004 | [proveFail_transferFromWhenToIsAddressZero](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#163) | This function verifies that the `transferFrom` function reverts when the `to` address is the zero address. |
| ERC721-REVERT-005 | [proveFail_MintWhenToIsAddressZero](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#175) | This function verifies that the `mint` function reverts when the `to` address is the zero address. |
| ERC721-REVERT-006 | [proveFail_Burn](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#181) | This function verifies that the `burn` function reverts when the given token ID does not have an owner. |
| ERC721-REVERT-007 | [proveFail_setApprovalForAll](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC721SymbolicProperties.sol#188) | This function verifies that the `setApprovalForAll` function reverts when the caller is not the owner of the tokens. |

## ERC1155

### Expected properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC1155-EXPECT-001 | [prove_setApprovalForAll](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#45) | prove_setApprovalForAll: Sets approval for operator to manage caller's tokens. Reverts if operator is caller. |
| ERC1155-EXPECT-002 | [prove_safeTransferFrom](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#53) | prove_safeTransferFrom: Transfers token from one account to another if conditions like approval and balances are met. Reverts otherwise. |
| ERC1155-EXPECT-003 | [prove_safeBatchTransferFrom](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#66) | prove_safeBatchTransferFrom: Transfers token from one account to another if conditions like approval and balances are met. Reverts otherwise. |
| ERC1155-EXPECT-004 | [prove_mint](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#86) | prove_mint: Mints new tokens for an account. Reverts if account is zero address. |
| ERC1155-EXPECT-005 | [prove_burn](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#94) | prove_burn: Burns tokens of an account if balance allows. Reverts if account is zero address or balance less than amount. |

### Revertable properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC1155-REVERT-001 | [proveFail_setApprovalForAllSenderEqualsOperator](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#105) | proveFail_setApprovalForAllSenderEqualsOperator: Negated case of setApprovalForAll. Expects revert if operator is caller. |
| ERC1155-REVERT-002 | [proveFail_safeTransferFromWhenSenderIsNotMSGSender](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#112) | proveFail_safeTransferFromWhenSenderIsNotMSGSender: Negated case of safeTransferFrom. Expects revert when sende is not msg.sender. |
| ERC1155-REVERT-003 | [proveFail_safeTransferFromWhenSenderIsNotApprovedForAll](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#119) | proveFail_safeTransferFromWhenSenderIsNotMSGSender: Negated case of safeTransferFrom. Expects revert when sende is not msg.sender. |
| ERC1155-REVERT-004 | [proveFail_safeTransferFromZeroAddressForFrom](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#128) | proveFail_safeTransferFromZeroAddressForFrom: Negated case of safeTransferFrom. Expects revert when from is the zero address. |
| ERC1155-REVERT-005 | [proveFail_safeTransferFromZeroAddressForTo](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#135) | proveFail_safeTransferFromZeroAddressForTo: Negated case of safeTransferFrom. Expects revert when to is the zero address. |
| ERC1155-REVERT-006 | [proveFail_safeTransferFromBalanceLessThanAmount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#141) | proveFail_safeTransferFromBalanceLessThanAmount: Negated case of safeTransferFrom. Expects revert if balance less than transfer amount. |
| ERC1155-REVERT-007 | [proveFail_mintZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#152) | proveFail_mintZeroAddress: Negated case of mint. Expects revert for zero address. |
| ERC1155-REVERT-008 | [proveFail_burnZeroAddress](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#158) | proveFail_burnZeroAddress: Negated case of burn. Expects revert for zero address. |
| ERC1155-REVERT-009 | [proveFail_burnBalanceLessThanAmount](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC1155SymbolicProperties.sol#163) | proveFail_burnBalanceLessThanAmount: Negated case of burn. Expects revert if balance less than burn amount. |


## ERC4626

### Expected properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC4626-EXPECT-001 | [prove_mint_increases_balance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#20) | Proves that minting tokens increases the balance of the recipient |
| ERC4626-EXPECT-002 | [prove_burn_decreases_balance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#29) | Proves that burning tokens decreases the balance of the account |
| ERC4626-EXPECT-003 | [prove_transfer_updates_balances](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#40) | Proves that transfer decreases the balance of the sender and increases the balance of the recipient |
| ERC4626-EXPECT-004 | [prove_transferFrom_updates_balances](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#58) | Proves that transferFrom decreases the balance of the sender and increases the balance of the recipient |
| ERC4626-EXPECT-005 | [prove_approvesets_allowance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#84) | Proves that approve sets the correct allowance |
| ERC4626-EXPECT-006 | [prove_approveoverwrites_allowance](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#95) | Proves that approve overwrites the existing allowance |
| ERC4626-EXPECT-007 | [prove_convertToShares_gte_previewDeposit](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#110) | Proves that convertToShares is greater than or equal to previewDeposit |
| ERC4626-EXPECT-008 | [prove_convertToShares_rounds_down_towards_0](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#123) | Proves that convertToShares rounds down towards 0 |
| ERC4626-EXPECT-009 | [prove_share_price_maintained_after_mint](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#141) | Proves that the share price is maintained after minting shares |
| ERC4626-EXPECT-010 | [prove_convertToAssets_lte_previewMint](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#165) | Proves that the share price is maintained after burning shares |
| ERC4626-EXPECT-011 | [prove_convertToAssets_rounds_down_towards_0](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#189) | Proves that convertToAssets is less than or equal to previewMint |
| ERC4626-EXPECT-012 | [prove_maxDeposit_returns_correct_value](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#211) | Proves that maxDeposit returns the maximum value of the UINT256 type |
| ERC4626-EXPECT-013 | [prove_maxMint_returns_correct_value](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#216) | Proves that maxMint returns the the maximum value of the UINT256 type |
| ERC4626-EXPECT-014 | [prove_previewDepositRelationToDeposit](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#221) | Proves that previewDeposit is less than or equal to deposit |
| ERC4626-EXPECT-015 | [prove_previewRedeem_lte_redeem](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#242) | Proves that previewRedeem is less than or equal to redeem |
| ERC4626-EXPECT-016 | [prove_integrity_of_deposit](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#263) | Proves the integrity of the deposit function |
| ERC4626-EXPECT-017 | [prove_integrity_of_withdraw](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#289) | Proves the integrity of the withdraw function |
| ERC4626-EXPECT-018 | [prove_integrity_of_redeem](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#306) | Proves the integrity of the redeem function |


### Revertable properties

| ID             | Name                                                                                                                                                           | Property                                                               |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| ERC4626-REVERT-001 | [proveFail_mint_to_zero_address_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#326) | Proves that minting to the zero address reverts |
| ERC4626-REVERT-002 | [proveFail_mint_overflow_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#335) | Proves that minting an amount that would cause an overflow reverts |
| ERC4626-REVERT-003 | [proveFail_burn_exceeds_balance_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#346) | Proves that burning more tokens than the account's balance reverts |
| ERC4626-REVERT-004 | [proveFail_burn_from_zero_address_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#357) | Proves that burning tokens from the zero address reverts |
| ERC4626-REVERT-005 | [proveFail_transfer_insufficient_balance_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#366) | Proves that transfer reverts when the sender's balance is insufficient |
| ERC4626-REVERT-006 | [proveFail_transfer_to_zero_address_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#379) | Proves that transfer reverts when transferring to the zero address |
| ERC4626-REVERT-007 | [proveFail_transfer_from_zero_address_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#390) | Proves that transfer reverts when transferring from the zero address |
| ERC4626-REVERT-008 | [proveFail_transferFrom_insufficient_balance_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#401) | Proves that transferFrom reverts when the sender's balance is insufficient |
| ERC4626-REVERT-009 | [proveFail_transferFrom_insufficient_allowance_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#419) | Proves that transferFrom reverts when the spender's allowance is insufficient |
| ERC4626-REVERT-010 | [proveFail_transferFrom_to_zero_address_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#434) | Proves that transferFrom reverts when transferring to the zero address |
| ERC4626-REVERT-011 | [proveFail_transferFrom_from_zero_address_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#448) | Proves that transferFrom reverts when transferring from the zero address |
| ERC4626-REVERT-012 | [proveFail_approvezero_address_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#459) | Proves that approve reverts when approving the zero address |
| ERC4626-REVERT-013 | [proveFail_approvefrom_zero_address_reverts](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#470) | Proves that approve reverts when the owner is the zero address |
| ERC4626-REVERT-014 | [proveFail_depositWithMSGSenderEqualsThis](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#481) | The deposit function is expected to revert if msg.sender is this contract |
| ERC4626-REVERT-015 | [proveFail_depositWithReceiverEqualsThis](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#505) | The deposit function is expected to revert if receiver is this contract |
| ERC4626-REVERT-016 | [proveFail_depositWithAmountLessThanAssets](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#524) | The deposit function is expected to revert if amount < assets |
| ERC4626-REVERT-017 | [proveFail_redeemWithAmountLessThanShares](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#547) | The redeem function is expected to revert if amount < shares |
| ERC4626-REVERT-018 | [proveFail_mintWithMSGSenderEqualsThis](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#564) | The mint function is expected to revert if msg.sender is this contract |
| ERC4626-REVERT-019 | [proveFail_mintWithReceiverAsThis](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#581) | The mint function is expected to revert if receiver is this contract |
| ERC4626-REVERT-020 | [proveFail_mintWithAmountLessThanShares](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#602) | The mint function is expected to revert if amount < shares |
| ERC4626-REVERT-021 | [proveFail_withdrawWithMSGSenderEqualsThis](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#623) | The withdraw function is expected to revert if msg.sender is this contract |
| ERC4626-REVERT-022 | [proveFail_withdrawWithReceiverEqualsThis](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#647) | The withdraw function is expected to revert if receiver is this contract |
| ERC4626-REVERT-023 | [proveFail_withdrawWithMSGSenderEqualsOwner](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#671) | The withdraw function is expected to revert if msg.sender == owner |
| ERC4626-REVERT-024 | [proveFail_withdrawWithOwnerEqualsThis](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#695) | The withdraw function is expected to revert if owner is this contract |
| ERC4626-REVERT-025 | [proveFail_withdrawWithOwnerEqualsReceiver](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#719) | The withdraw function is expected to revert if owner == receiver |
| ERC4626-REVERT-026 | [proveFail_withdrawWithAmountLessThanAssets](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#743) | The withdraw function is expected to revert if amount < assets |
| ERC4626-REVERT-027 | [proveFail_redeemWithMSGSenderEqualsThis](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#767) | The redeem function is expected to revert if msg.sender is this contract |
| ERC4626-REVERT-028 | [proveFail_redeemWithReceiverEqualsThis](https://github.com/lindy-labs/solidity_properties/blob/main/hevm/Properties/ERC4626SymbolicProperties.sol#784) | The redeem function is expected to revert if receiver is this contract |
