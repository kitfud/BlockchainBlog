//SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "./Blog.sol";

contract BlogFactory is Blog {
    contractTemplate[] public blogFactoryArray;

    struct contractTemplate {
        string topic;
        Blog content;
    }

    uint256 index;

    mapping(uint256 => string) public indexToTopic;
    mapping(string => uint256) public topicToIndex;

    constructor() public {
        index = 0;
    }

    function createNewBlogContract(string memory _topic) public {
        Blog _blog = new Blog();
        contractTemplate memory newblog = contractTemplate(_topic, _blog);
        blogFactoryArray.push(newblog);
        indexToTopic[index] = _topic;
        topicToIndex[_topic] = index;
        index++;
    }

    function numberOfEntries() public view returns (uint256) {
        return blogFactoryArray.length;
    }

    function writeEntry(
        uint256 _contentIndex,
        string memory _title,
        string memory _content
    ) public {
        contractTemplate memory currentEntry = blogFactoryArray[_contentIndex];
        Blog currentBlog = currentEntry.content;
        Blog(address(currentBlog)).addEntry(_title, _content);
    }

    function getTopic(uint256 _index) public view returns (string memory) {
        return indexToTopic[_index];
    }

    function getContent(uint256 _factoryIndex, uint256 _postIndex)
        public
        view
        returns (string memory)
    {
        contractTemplate memory currentEntry = blogFactoryArray[_factoryIndex];
        Blog currentblog = currentEntry.content;
        return Blog(address(currentblog)).readContentByNumber(_postIndex);
    }

    function getTitle(uint256 _factoryIndex, uint256 _postIndex)
        public
        view
        returns (string memory)
    {
        contractTemplate memory currentEntry = blogFactoryArray[_factoryIndex];
        Blog currentblog = currentEntry.content;
        return Blog(address(currentblog)).readTitleByNumber(_postIndex);
    }

    function getTotalEntries(uint256 _factoryIndex)
        public
        view
        returns (uint256)
    {
        contractTemplate memory currentEntry = blogFactoryArray[_factoryIndex];
        Blog currentblog = currentEntry.content;
        return Blog(address(currentblog)).totalEntries();
    }
}
