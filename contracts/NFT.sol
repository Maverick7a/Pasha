//SPDX-License-Identifier: MIT

pragma solidity ^0.8.11 ; 

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Pasha is ERC1155 , AccessControl {

    string public name = "Football";
    string public symbol = "PP10";

    uint public totalTokens;

    bytes32 public constant CREATOR_ROLE = keccak256("CREATOR_ROLE"); 

    constructor() ERC1155 ("https://gateway.pinata.cloud/ipfs/QmX4Pkv1PEajT5U79g2wQgbhvtpMK5iAoKgk99udNkdXtU/{id}.json") {
        _grantRole(DEFAULT_ADMIN_ROLE,msg.sender);
        _grantRole(CREATOR_ROLE, msg.sender);
        mint(msg.sender, "0x0");
    }

    function mint(address _to, bytes memory _data) public onlyRole(CREATOR_ROLE){
        require(totalTokens <1, "Only 1 token can be minted");
        _mint (_to, 1, 1, _data);
        totalTokens+=1;

    }

    function addCreatorRole() public onlyRole(DEFAULT_ADMIN_ROLE){
        grantRole(CREATOR_ROLE, msg.sender);
    }

    function uri(uint256 _id) public pure override returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "https://gateway.pinata.cloud/ipfs/QmX4Pkv1PEajT5U79g2wQgbhvtpMK5iAoKgk99udNkdXtU/",
                    Strings.toString(_id),
                    ".json"
                    
                )
            );
    }

    function supportsInterface(bytes4 interfaceId) 
    public 
    view 
    override(AccessControl,ERC1155) 
    returns (bool) {
        return
            interfaceId == type(IAccessControl).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}