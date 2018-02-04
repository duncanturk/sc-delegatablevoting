pragma solidity ^0.4.19;

contract DelegatableVoting{
    mapping (address => uint) private remainingTokens;
    mapping (address => bool) private claimedTokens;

    uint private pro;
    uint private con;

    uint private tokensPerAddress;

    modifier claimed(){
        require(claimedTokens[msg.sender]);
        _;
    }

    modifier notClaimed(){
        require(!claimedTokens[msg.sender]);
        _;
    }

    function DelegatableVoting(uint _tokensPerAddress) public {
        tokensPerAddress = _tokensPerAddress;
    }

    function claimTokens() public notClaimed {
        claimedTokens[msg.sender] = true;
        remainingTokens[msg.sender] = tokensPerAddress;
    }

    function voteCon(uint amount) public claimed {
        require(amount<=remainingTokens[msg.sender]);
        require(amount>0);

        con += amount;
        remainingTokens[msg.sender]-=amount;
    }

    function votePro(uint amount) public claimed {
        require(amount<=remainingTokens[msg.sender]);
        require(amount>0);

        pro += amount;
        remainingTokens[msg.sender]-=amount;
    }

    function getPro() public view returns(uint){
        return pro;
    }

    function getCon() public view returns(uint){
        return con;
    }
}
