const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Vault 1", () => {
	let vault1;
	let owner;
	let account1;
	let exToken;

	beforeEach(async () => {
		const accounts = await ethers.getSigners();
		owner = accounts[0];
		account1 = accounts[1];

		const Vault1 = await ethers.getContractFactory("Vault1");
		vault1 = await Vault1.deploy();
		await vault1.deployed();

		const Token = await ethers.getContractFactory("ExampleToken");
		exToken = await Token.deploy(1000);
		await exToken.deployed();
	});

	describe("deposit", function () {
		it("should emit deposited event when funds are deposited", async function () {
			console.log(vault1);

			await exToken.approve(vault1, 10);

			console.log("FLAG");

			expect(vault1.connect(owner).deposit(5))
				.to.emit(vault1, "Deposited")
				.withArgs(5);
		});
	});
});
