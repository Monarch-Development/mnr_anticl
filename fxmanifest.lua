fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'mnr_anticl'
description 'Anti Combat-Log script'
author 'IlMelons & Rico'
version '1.0.0'
repository 'https://www.github.com/Monarch-Development/mnr_anticl'

ox_lib 'locale'

files {
    'locales/*.json',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config/*.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}