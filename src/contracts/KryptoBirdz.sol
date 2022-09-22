// SPDX-License=Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector {
    string[] public kryptoBirdz;

    constructor() ERC721Connector('KrptoBird', 'KBIRDZ') {}

    mapping(string => bool) _kryptoBirdzExists;
    function mint(string memory _kryptoBird) public {
        require(!_kryptoBirdzExists[_kryptoBird], 'Error - krytoBird already exist');
        // uint _id = kryptoBirdz.push(_kryptoBird);
        kryptoBirdz.push(_kryptoBird);
        uint256 _id = kryptoBirdz.length - 1;

        _mint(msg.sender, _id);

        _kryptoBirdzExists[_kryptoBird] = true;
    } 
}