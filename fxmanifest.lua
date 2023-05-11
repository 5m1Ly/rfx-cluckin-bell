fx_version 'cerulean'
game 'gta5'

name 'Clucking Bell'
description 'The Clucking Bell is a fast food restaurant chain in the GTA HD Universe. It is a parody of KFC. This resource allows players to contribute to the supply chain of the Clucking Bell.'
author 'Hayo Bouma <hbouma@gmail.com>'
version '0.0.0'

shared_scripts {
    'config/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

client_scripts {}

lua54 'yes'
