const algosdk = require('algosdk');

export function generateAlgorandKeyPair() {
    let account = algosdk.generateAccount();
    let passphrase = algosdk.secretKeyToMnemonic(account.sk);
    console.log( "My address: " + account.addr );
    console.log( "My passphrase: " + passphrase );
    return [account.addr, passphrase];
}

export function importAlgorandKeyPair(seed) {
    passphrase=seed.split(", ").join(" ")
    let account = algosdk.mnemonicToSecretKey(passphrase);
    console.log( "My address: " + account.addr );
    console.log( "My passphrase: " + passphrase );
    return [account.addr, passphrase];
}