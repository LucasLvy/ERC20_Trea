# Trealos

Trealos (TRL) est un token créé par Quentin Gibon et Lucas LEVY. Le smart contrat de ce token est accessible sur le testnet ropsten à l’adresse `0xE91Ce607D4CEF15aB3Efc2E578bEB961Cc6e7Db3` (https://ropsten.etherscan.io/address/0xE91Ce607D4CEF15aB3Efc2E578bEB961Cc6e7Db3).

## Utilisation
Pour recevoir des tokens, veuillez envoyer des ethers à l’adresse du contrat. Vous recevrez un nombre de TRL (si vous avez été préalablement ajouté dans la white list par l'admin du contrat) déterminé par la somme d'Eth envoyée puis multipliée par le tier auquel vous appartenez. Plus la somme d'Ether envoyée est importante plus vous monterez dans les tiers et plus vous recevrez donc de de TRL (le tier 3 reçoit 3x plus de TRL que le tiers 1). 

## Détail des fonctions
### Constructor
Le constructeur initialise les décimales du TRL, la quantité max qui sera mintée (quantité max de tokens disponibles) et met l'adresse qui déploie le contrat comme admin.

### isWhiteListed
C'est un modifier qui vérifie si l'adresse qui envoie utilise une fonction est whitelisté. Ce modifier est utilisé pour la fonction fallback afin que les ethers soient renvoyés à la personne si elle n'est pas whitelisté. Possibilité d'arnaquer les donnateurs non whitelistés en utilisant ce modifier seulement pour la fonction getToken.

### fallback
Cette fonction recoit les ethers et appelle la fonction getToken afin d'envoyer les TRL à l'adresse qui a envoyé de l'Eth.

### adminAddUser
Permet à l'admin de whitelister des adresses d'utilisateurs.

### changeTiers
Change de tier une adresse.

### checkTiers
Vérifie la somme d'Eth qu'un adresse envoie + qu'elle a déjà envoyée et la change de tier si nécessaire. Les tiers sont atteints par paliers d'ethers envoyés.

### airdrop
Sélectionne une adresse au hasard (sauf celle de l'admin) parmi celles présentes dans la white list, et envoie 100 tokens à cette adresse. Cette fonction ne peut être appelée que par l'admin du contrat.

### randMod
Génère un nombre aléatoire en compilant plusieurs infos en même temps dont le timestamp du block et réalise un modulo sur le resultat pour avoir un chiffre compris dans l'interval [1 ; max choisi]. Attention néanmoins cette technique de génération aléatoire n'est pas très sécurisée.

### uint2str
Convertit les uints en string.

## Déploiement
Le smart contract a été déployé sur le testnet Ropsten en utilisant infura.
Pour le déployer il suffit de créer un fichier .env dans le même dossier que truffle-config.js. Ce fichier .env doit contenir les variables INFURA_PROJECT_ID=""
et DEV_MNEMONIC="". La première étant l'id du projet infura et la deuxième est la seed mnemonic de l'adresse qui déploiera le contrat. Pour le déployer il suffira de lancer la commande "npx truffle migrate --network ropsten". Pour le redéployer après modification il faut utiliser la commande "truffle deploy --network ropsten --reset"
