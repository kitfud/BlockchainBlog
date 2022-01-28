from brownie import Blog, BlogFactory, network, config
from scripts.helpful_scripts import get_account


def deployBlog():
    account = get_account()
    Blog.deploy(
        {"from": account},
        publish_source=config["networks"][network.show_active()]["verify"],
    )
    print("blog has been deployed")


def deployBlogFactory():
    account = get_account()
    BlogFactory.deploy(
        {"from": account},
        publish_source=config["networks"][network.show_active()]["verify"],
    )
    print("blog factory has been deployed")


def main():
    deployBlog()
    deployBlogFactory()
