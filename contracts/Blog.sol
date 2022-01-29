//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Blog is Ownable {
    uint256 public entries;

    struct Entry {
        uint256 entryId;
        string title;
        string content;
    }

    Entry[] public entrylibrary;
    mapping(uint256 => string) public entryNumberToContent;
    mapping(uint256 => string) public entryNumberToTitle;

    constructor() public {
        entries = 0;
    }

    function addEntry(string memory _title, string memory _content)
        public
        onlyOwner
    {
        Entry memory blogpost = Entry(entries, _title, _content);
        entrylibrary.push(blogpost);
        entryNumberToContent[entries] = _content;
        entryNumberToTitle[entries] = _title;
        entries++;
    }

    function editEntry(
        uint256 entryNumber,
        string memory _title,
        string memory _content
    ) public onlyOwner {
        require(
            entryNumber <= entrylibrary.length,
            "Selected Index is out of range. Choose a valid index to edit"
        );
        Entry memory editedblogpost = Entry(entryNumber, _title, _content);
        entrylibrary[entryNumber] = editedblogpost;

        entryNumberToContent[entryNumber] = _content;
        entryNumberToTitle[entryNumber] = _title;
    }

    function totalEntries() public view returns (uint256) {
        return entrylibrary.length;
    }

    function readContentByNumber(uint256 entryNumber)
        public
        view
        returns (string memory)
    {
        return entryNumberToContent[entryNumber];
    }

    function readTitleByNumber(uint256 entryNumber)
        public
        view
        returns (string memory)
    {
        return entryNumberToTitle[entryNumber];
    }

    function compareStringsbyBytes(string memory s1, string memory s2)
        public
        pure
        returns (bool)
    {
        return
            keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }

    function IndexByEntryTitle(string memory _title)
        public
        view
        returns (uint256)
    {
        uint256 returnVal;
        bool valueChange = false;
        uint256 length = entrylibrary.length;
        uint256 j;

        for (j = 0; j < length; j++) {
            if (compareStringsbyBytes(entrylibrary[j].title, _title)) {
                returnVal = j;
                valueChange = true;
            }
        }
        require(valueChange == true, "Title not found");
        return returnVal;
    }
}
