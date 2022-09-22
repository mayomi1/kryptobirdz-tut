// SPDX-License=Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';
import "./interfaces/IERCEnumerable.sol";

contract ERC721Enumerable is IERC721Enumerable, ERC721 {

    constructor() {
        _registerInterface(bytes4(keccak256('totalSupply(bytes4)')^keccak256('tokenByIndex(bytes4)')^keccak256('tokenOfOwnerByIndex(bytes4)')));
    }

    uint256[] private _allTokens;

    mapping(uint256 => uint256) private _allTokensIndex;

    mapping(address => uint256[]) private _ownedTokens;

    mapping(uint256 => uint256) private _ownerTokensIndex;

    function totalSupply() public view returns (uint256) {
        return _allTokens.length;
    }


    function _mint(address to, uint256 tokenId) internal override(ERC721) {
        super._mint(to, tokenId);

        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId]= _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokens[to].push(tokenId);
        _ownerTokensIndex[tokenId] = _ownedTokens[to].length;
    }

    function tokenByIndex(uint index) public view returns (uint256) {
        require(index < totalSupply(), 'global index is out of bounds');
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint index) public view returns(uint256) {
        require(index < balanceOf(owner), 'owner index out of bounds');
        return _ownedTokens[owner][index];
    }
}
