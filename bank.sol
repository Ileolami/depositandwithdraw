// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DepositAndWithdraw {
    ERC20 public token;
    mapping(address => uint) public balances;

    constructor(address _tokenAddress) {
        token = ERC20(_tokenAddress);
    }

    // Event to announce a successful deposit
    event Deposit(address indexed account, uint amount);

    // Event to announce a successful withdrawal
    event Withdrawal(address indexed account, uint amount);

    // Function to deposit tokens, payable to accept Ether along with token deposit
    function deposit(address _userAddress, uint _amount) public payable {
        // Ensure the correct amount of Ether is sent
        require(msg.value >= 0.01 ether, "Minimum 0.01 Ether required for deposit");

        // Transfer the tokens to this contract
        require(token.transferFrom(_userAddress, address(this), _amount));

        // Update the balance for the user
        balances[_userAddress] += _amount;

        // Emit an event to announce the successful deposit
        emit Deposit(_userAddress, _amount);
    }

    // Function to withdraw tokens after waiting for 70 blocks
    function withdraw() public view {
        // Ensure 70 blocks have passed
        require(block.number >= 70, "Wait for 70 blocks before withdrawing");
    }
}


