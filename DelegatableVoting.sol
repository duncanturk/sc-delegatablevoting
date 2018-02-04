pragma solidity ^0.4.19;

import 'ExtendedInt.sol';

contract DelegatableVoting{
    using ExtendedInt for int;

    mapping (address => uint) private remainingTokens;
    mapping (address => bool) private claimedTokens;

    mapping (uint => int) private votesPerOption;
    string[] private options;

    bool private started;

    uint private tokensPerAddress;

    modifier claimed(){
        require(claimedTokens[msg.sender]);
        _;
    }

    modifier notClaimed(){
        require(!claimedTokens[msg.sender]);
        _;
    }

    modifier hasNotStared(){
        require(!started);
        _;
    }

    modifier hasStared(){
        require(started);
        _;
    }

    function DelegatableVoting(uint _tokensPerAddress) public {
        tokensPerAddress = _tokensPerAddress;
        started = false;
    }

    function claimTokens() public notClaimed {
        claimedTokens[msg.sender] = true;
        remainingTokens[msg.sender] = tokensPerAddress;
    }

    function vote(uint option, int amount) public claimed hasStared{
        require(amount.abs() <= remainingTokens[msg.sender]);
        require(options.length > option);

        votesPerOption[option] += amount;
        remainingTokens[msg.sender] -= amount.abs();
    }

    function addOption(string option) public hasNotStared {
        options.push(option);
    }

    function start(string option) public hasNotStared {
        started = true;
    }
}
