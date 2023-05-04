//SPDX-License-Identifier: MIT

pragma solidity ^0.8.11 ; 

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Pasha is ERC1155 , AccessControl {

    event Mint (
        address indexed to,
        uint id,
        uint amount
    );

    string public name = "Football";
    string public symbol = "PP10";

    uint public totalTokens;

    bytes32 public constant CREATOR_ROLE = keccak256("CREATOR_ROLE"); 

    constructor() ERC1155 ("xxx culka/{id}.json") {
        _grantRole(DEFAULT_ADMIN_ROLE,msg.sender);
        _grantRole(CREATOR_ROLE, msg.sender);
        
    }

    function mint(address _to,uint _id, uint _amount, bytes memory _data) public onlyRole(CREATOR_ROLE){
        _mint(_to, _id, _amount, _data);
        emit Mint(_to,_id,_amount);

    }

    function mintBatch(address _to, uint[] memory _id, uint[] memory _amount, bytes memory _data) public onlyRole(CREATOR_ROLE){
       _mintBatch(_to, _id, _amount, _data);
        for (uint i = 0; i < _id.length; i++) {
            emit Mint(_to, _id[i], _amount[i]);
        }
    }

    function addCreatorRole() public onlyRole(DEFAULT_ADMIN_ROLE){
        grantRole(CREATOR_ROLE, msg.sender);
    }

    function uri(uint256 _id) public pure override returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "xxxculka/",
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