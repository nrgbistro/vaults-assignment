const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Vault 1", () => {
	let vault1;
	let owner;
	let account1;
	let exToken;

	beforeEach(async () => {
		const Vault1 = await ethers.getContractFactory("Vault1");
		const Token = await ethers.getContractFactory("ExampleToken");
		const accounts = await ethers.getSigners();

		owner = accounts[0];
		account1 = accounts[1];

		vault1 = await Vault1.deploy();
		exToken = await Token.deploy(1000);

		await vault1.deployed();
		await exToken.deployed();
	});

	describe("deposit", function () {
		it("should emit deposited event when funds are deposited", async function () {
			await exToken.approve(vault1, 10);
			expect(
				vault1
					.connect(owner)
					.deposit(5)
					.to.emit(vault1, "Deposited")
					.withArgs(5)
			);
		});
	});
});
