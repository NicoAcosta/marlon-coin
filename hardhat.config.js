require('@nomiclabs/hardhat-waffle')
require('@nomiclabs/hardhat-etherscan')
const networks = require('./networks')
const secret = require('./secret')

task('deploy', 'Deploy contract', async (taskArgs, hre) => {
	const Token = await hre.ethers.getContractFactory('MarlonCoin')
	const token = await Token.deploy()

	await token.deployed()
	;[deployer, ...addrs] = await ethers.getSigners()

	console.log('MarlonCoin deployed to:', token.address)
	console.log('Deployed by:', deployer.address)
})

module.exports = {
	solidity: '0.8.3',
	networks: {
		rinkeby: {
			url: networks.rinkeby.node_url,
			accounts: [secret.private_key],
		},
	},
	etherscan: {
		apiKey: secret.etherscan_api_key,
	},
	compilers: [{version: '0.8.4'}, {version: '0.8.11'}, {vesion: '0.8.3'}],
}
