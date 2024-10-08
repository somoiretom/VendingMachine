// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VendingMachine {
    // Defining the product categories DRINKS = 0 and FOODS = 1
    enum Category { DRINKS, FOODS }

    // Product struct
    struct Product {
        string name;
        uint256 price;
        uint256 stock;
        string image;
        Category category;
    }

    // Mapping to store products by ID
    mapping(uint256 => Product) public products;
    uint256 public productCount;

    // Array to store product IDs for retrieval
    uint256[] public productIds;

    // Owner of the vending machine account owner
    address public owner;

    event ProductAdded(uint256 productId, string name, uint256 price, uint256 stock);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");_;
    }

    constructor() {
        owner = msg.sender;
    }

    // Function to add a new product or update stock
    function setProduct(string memory _name, uint256 _price, uint256 _stock, string memory _image, Category _category) public onlyOwner {
        products[productCount] = Product(_name, _price, _stock, _image, _category);
        productIds.push(productCount); // Add product ID to array for retrieval
        emit ProductAdded(productCount, _name, _price, _stock);
        productCount++;
    }

    // Function to get details of a specific product by ID
    function getProduct(uint256 _productId) public view returns (string memory name, uint256 price, uint256 stock, string memory image, Category category) {
        require(_productId < productCount, "Product does not exist");
        Product storage product = products[_productId];
        return (product.name, product.price, product.stock, product.image, product.category);
    }

    // Function to get all products
    function getAllProducts() public view returns (Product[] memory) {
        Product[] memory allProducts = new Product[](productCount);
        for (uint256 i = 0; i < productCount; i++) {
            allProducts[i] = products[productIds[i]];
        }
        return allProducts;
    }
}