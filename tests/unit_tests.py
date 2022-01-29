from scripts.deploy import deployBlog
from scripts.helpful_scripts import get_account
from brownie import Blog
import pytest


def testIndexByEntryTitle():
    account = get_account()
    contract = Blog.deploy({"from": account})
    contract.addEntry("Kit", "hello", {"from": account})
    numberEntries = contract.totalEntries()
    assert numberEntries == 1
    indexPos = contract.IndexByEntryTitle("Kit")
    assert indexPos == 0
