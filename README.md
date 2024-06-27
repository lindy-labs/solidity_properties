# Table of contents

- [Table of contents](#table-of-contents)
- [Properties](#properties)
  - [Verifying the properties with symbolic testing](#testing-the-properties-with-symbolic-testing)
    - ERC20 tests
    - ERC721 tests
    - ERC1155 tests
    - ERC4626 tests
    - ABDKMath tests
- [How to contribute to this repo?](#how-to-contribute-to-this-repo)

# Properties

This Foundry-based repository contains 226 code properties for:

- [ERC20](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/) token: [65 properties](PROPERTIES.md#erc20);
- [ERC721](https://ethereum.org/en/developers/docs/standards/tokens/erc-721/) token: [15 properties](PROPERTIES.md#erc721);
- [ERC1155](https://ethereum.org/en/developers/docs/standards/tokens/erc-1155/) token: [28 properties](PROPERTIES.md#erc1155);
- [ERC4626](https://ethereum.org/en/developers/docs/standards/tokens/erc-4626/) token: [46 properties](PROPERTIES.md#erc4626);
- [ABDKMath64x64](https://ethereum.org/en/developers/docs/standards/tokens/erc-4626/) token: [72 properties](PROPERTIES.md#abdkmath64x64).

The goals of these properties are to:

- Detect vulnerabilities
- Ensure adherence to relevant standards
- Provide educational guidance for writing symbolic properties

The properties can be used through symbolic tests with [Ethereum's hevm](https://github.com/ethereum/hevm).

## Testing the properties with symbolic testing

1. Install [Foundry](https://book.getfoundry.sh/getting-started/installation);
2. Install [Ethereum's hevm](https://github.com/ethereum/hevm#installation);
3. Download this repo and copy the example of interest into the Foundry's folder `src` ([ERC20](https://github.com/lindy-labs/solidity_properties/tree/main/hevm/Examples/ERC20Examples/Openzeppelin), [ERC721](https://github.com/lindy-labs/solidity_properties/tree/main/hevm/Examples/ERC721Examples/NFT-Marketplace), or [ERC1155](https://github.com/lindy-labs/solidity_properties/tree/main/hevm/Examples/ERC1155Examples/Openzeppelin)) and corresponding properties into Foundry's folder `test` ([ERC20](https://github.com/lindy-labs/solidity_properties/tree/main/Properties/ERC20SymbolicProperties.sol), [ERC721](https://github.com/lindy-labs/solidity_properties/tree/main/Properties/ERC721SymbolicProperties.sol), or [ERC1155](https://github.com/lindy-labs/solidity_properties/tree/main/Properties/ERC1155SymbolicProperties.sol)).
 
### Run

Run hevm:

- Just execute: `hevm test`

#### Example: Output for a compliant token

If the token under test is compliant and no properties will fail during symbolic testing, the hevm output should be similar to the screen below:

``` JavaScript
$ hevm test
Exploring contract
Simplifying expression
Explored contract (31 branches)
Checking for reachability of 4 potential property violation(s)
[PASS] prove_IncreaseAllowance(address,address,uint256)
...
```

#### Example: Output for a non-compliant token

For this example, the ExampleToken's approval function was modified to perform no action:

```
function approve(address spender, uint256 amount) public virtual override(ERC20) returns (bool) {
  // do nothing
  return true;
}
```

In this case, the hevm output should be similar to the screen below, notice that all functions that rely on `approve()` to work correctly will have their assertions broken, and will report the situation.

``` JavaScript
$ hevm test
Exploring contract
Simplifying expression
Explored contract (7 branches)
Checking for reachability of 2 potential property violation(s)
[FAIL] prove_Approve(address,address,uint256)
...
Failure: prove_Approve(address,address,uint256)

  Counterexample:
  
    result:   Revert: 0x4e487b710000000000000000000000000000000000000000000000000000000000000001
    calldata: prove_Approve(0x0000000001010000000000000000000000000000,0x0000000000000000000000000000000080000000,115792089237316195423570985008687907853269984665640564039457584007913129639935)
...  
```

# How to contribute to this repo?

Contributions are welcome! Any question, suggestion or participation, please contact us: <info@lindylabs.net>.
