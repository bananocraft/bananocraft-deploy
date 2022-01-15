<?php

$autoRefreshInSeconds = 5;

// Name of your node (default: your hostname)
$nanoNodeName = 'BananoCraft';

// a welcome message shown on top
$welcomeMsg = 'Banano rocks! On Minecraft!';

// coinmarketcap widget
// market data base and second currency e.g. USD, EUR, BTC, ETH
$cmcBaseCurrency = 'USD';
$cmcSecondaryCurrency = 'BTC';

// other widget panels (TRUE / FALSE)
$cmcTicker = TRUE;
$cmcRank = TRUE;
$cmcMarketcap = TRUE;
$cmcVolume = TRUE;
$cmcStatsticker = TRUE;

// choice of Banano block explorer ('nanode', 'nanoexplorer', 'nano')
// $blockExplorer = 'nanode';

// ----------- Banano Node Variables -----------

// ip address for RPC (default: [::1])
$nanoNodeRPCIP   = 'bananonode';

// ip address for RPC (default: 7072)
$nanoNodeRPCPort = '7072';

// account of this node
$nanoNodeAccount = 'ban_381jstcyodrkpdpkywzezjwwhhqoquinoxrg7haf8c8chmqhpb699a1ub55c';

// donation account for maintaining this node
// $nanoDonationAccount = 'ban_381jstcyodrkpdpkywzezjwwhhqoquinoxrg7haf8c8chmqhpb699a1ub55c';

// number of decimal places to display Banano balances, i.e.
// $nanoNumDecimalPlaces = 2;

// ----------- Monitoring -----------

// Uptimerobot.com API key for external monitoring
// Tutorial: https://github.com/nanotools/nanoNodeMonitor/wiki/Uptimerobot-Node-Monitoring
// $uptimerobotApiKey = '';

// ----------- Social -----------

// Add your social accounts
// Tutorial: https://github.com/nanotools/nanoNodeMonitor/wiki/Social-Accounts
// $socials['reddit'] = 'https://www.reddit.com/user/NANOFAN1337/';