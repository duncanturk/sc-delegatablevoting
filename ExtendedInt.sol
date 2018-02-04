pragma solidity ^0.4.19;

library ExtendedInt {
    function abs(int _self) public pure returns(uint){
        if(_self>=0)
            return uint(_self);
        return uint(_self * -1);
    }
}
