import algosdk from 'algosdk'
// import { WalletConnectSession } from './wallets/walletconnect'
// import { AlgoSignerSession } from './wallets/algosigner'
// import Buffer from 'buffer'


class AlgoOperations{
    // algodclient = new algosdk.Algodv2('', 'https://testnet-api.algonode.cloud', '')
    constructor()
    {
        this.algo_client = new algosdk.Algodv2('', 'https://testnet-api.algonode.cloud', '')
    }

    async create_asset(account1,decimals,totalIssuance,unitName,assetName)
    {
        let params = await this.algo_client.getTransactionParams().do();
        // comment out the next two lines to use suggested fee
        // params.fee = 1000;
        // params.flatFee = true;
        let note = undefined; // arbitrary data to be stored in the transaction; here, none is stored
        // Asset creation specific parameters
        // The following parameters are asset specific
        // Throughout the example these will be re-used. 
        // We will also change the manager later in the example
        let addr = account1.addr;
        // Whether user accounts will need to be unfrozen before transacting    
        let defaultFrozen = false;
        // integer number of decimals for asset unit calculation
        // let decimals = 0;
        // total number of this asset available for circulation   
        // let totalIssuance = 1000;
        // Used to display asset units to user    
        // let unitName = "LATINUM";
        // Friendly name of the asset    
        // let assetName = "latinum";

        // Optional string pointing to a URL relating to the asset
        // let assetURL = "http://someurl";

        // Optional hash commitment of some sort relating to the asset. 32 character length.
        // let assetMetadataHash = "16efaa3924a6fd9d3a4824799a4ac65d";

        // The following parameters are the only ones
        // that can be changed, and they have to be changed
        // by the current manager
        // Specified address can change reserve, freeze, clawback, and manager
        let manager = account1.addr;
        // Specified address is considered the asset reserve
        // (it has no special privileges, this is only informational)
        let reserve = account1.addr;
        // Specified address can freeze or unfreeze user asset holdings 
        let freeze = account1.addr;
        // Specified address can revoke user asset holdings and send 
        // them to other addresses    
        let clawback = account1.addr;

        // signing and sending "txn" allows "addr" to create an asset
        let txn = algosdk.makeAssetCreateTxnWithSuggestedParams(
            addr, 
            note,
            totalIssuance, 
            decimals, 
            defaultFrozen, 
            manager, 
            reserve, 
            freeze,
            clawback, 
            unitName, 
            assetName, 
            // assetURL, 
            // assetMetadataHash, 
            params);

        let rawSignedTxn = txn.signTxn(account1.sk)
        let tx = (await this.algo_client.sendRawTransaction(rawSignedTxn).do());

        let assetID = null;
        // wait for transaction to be confirmed
        const ptx = await algosdk.waitForConfirmation(algodclient, tx.txId, 4);
        // Get the new asset's information from the creator account
        assetID = ptx["asset-index"];
        //Get the completed Transaction
        console.log("Transaction " + tx.txId + " confirmed in round " + ptx["confirmed-round"]);
    }


    async modify_asset(account1,account2,assetID)
    {
        params = await algodclient.getTransactionParams().do();
        // comment out the next two lines to use suggested fee
        // params.fee = 1000;
        // params.flatFee = true;
        // Asset configuration specific parameters
        // all other values are the same so we leave 
        // them set.
        // specified address can change reserve, freeze, clawback, and manager
        manager = account1.addr;
        let reserve = account1.addr;
        // Specified address can freeze or unfreeze user asset holdings 
        let freeze = account1.addr;
        // Specified address can revoke user asset holdings and send 
        // them to other addresses    
        let clawback = account1.addr;
        let note = undefined;

        // Note that the change has to come from the existing manager
        let ctxn = algosdk.makeAssetConfigTxnWithSuggestedParams(
            account2.addr, 
            note, 
            assetID, 
            manager, 
            reserve, 
            freeze, 
            clawback, 
            params);

        // This transaction must be signed by the current manager
        rawSignedTxn = ctxn.signTxn(account2.sk)
        let ctx = (await this.algodclient.sendRawTransaction(rawSignedTxn).do());
        // Wait for confirmation
        let confirmedTxn = await algosdk.waitForConfirmation(algodclient, ctx.txId, 4);
        //Get the completed Transaction
        console.log("Transaction " + ctx.txId + " confirmed in round " + confirmedTxn["confirmed-round"]);

        // Get the asset information for the newly changed asset
        // use indexer or utiltiy function for Account info
        // The manager should now be the same as the creator
        await printCreatedAsset(algodclient, account1.addr, assetID);
    }

    async receive_asset(account_from,account_to,assetID)
    {
        // Opting in to transact with the new asset
        // Allow accounts that want recieve the new asset
        // Have to opt in. To do this they send an asset transfer
        // of the new asset to themseleves 
        // In this example we are setting up the 3rd recovered account to 
        // receive the new asset
        let note=undefined;
        // First update changing transaction parameters
        // We will account for changing transaction parameters
        // before every transaction in this example
        params = await this.algodclient.getTransactionParams().do();
        //comment out the next two lines to use suggested fee
        // params.fee = 1000;
        // params.flatFee = true;

        let sender = account_from.addr;
        let recipient = account_to.addr;
        // We set revocationTarget to undefined as 
        // This is not a clawback operation
        let revocationTarget = undefined;
        // CloseReaminerTo is set to undefined as
        // we are not closing out an asset
        let closeRemainderTo = undefined;
        // We are sending 0 assets
        amount = 0;
        // signing and sending "txn" allows sender to begin accepting asset specified by creator and index
        let opttxn = algosdk.makeAssetTransferTxnWithSuggestedParams(
            sender, 
            recipient, 
            closeRemainderTo, 
            revocationTarget,
            amount, 
            note, 
            assetID, 
            params);

        // Must be signed by the account wishing to opt in to the asset    
        rawSignedTxn = opttxn.signTxn(account_from.sk);
        let opttx = (await this.algodclient.sendRawTransaction(rawSignedTxn).do());
        // Wait for confirmation
        confirmedTxn = await algosdk.waitForConfirmation(algodclient, opttx.txId, 4);
        //Get the completed Transaction
        console.log("Transaction " + opttx.txId + " confirmed in round " + confirmedTxn["confirmed-round"]);

        //You should now see the new asset listed in the account information
        console.log("Account 3 = " + account_from.addr);
        await printAssetHolding(algodclient, account_from.addr, assetID);
    }

    async transfer_asset(account_from,account_to,assetID)
    {
        // Transfer New Asset:
        // Now that account3 can recieve the new tokens 
        // we can tranfer tokens in from the creator
        // to account3
        // First update changing transaction parameters
        // We will account for changing transaction parameters
        // before every transaction in this example

        params = await algodclient.getTransactionParams().do();
        //comment out the next two lines to use suggested fee
        // params.fee = 1000;
        // params.flatFee = true;

        sender = account_from.addr;
        recipient = account_to.addr;
        note = undefined;
        revocationTarget = undefined;
        closeRemainderTo = undefined;
        //Amount of the asset to transfer
        amount = 10;

        // signing and sending "txn" will send "amount" assets from "sender" to "recipient"
        let xtxn = algosdk.makeAssetTransferTxnWithSuggestedParams(
            sender, 
            recipient, 
            closeRemainderTo, 
            revocationTarget,
            amount,  
            note, 
            assetID, 
            params);
        // Must be signed by the account sending the asset  
        rawSignedTxn = xtxn.signTxn(account_from.sk)
        let xtx = (await algodclient.sendRawTransaction(rawSignedTxn).do());

        // Wait for confirmation
        confirmedTxn = await algosdk.waitForConfirmation(algodclient, xtx.txId, 4);
        //Get the completed Transaction
        console.log("Transaction " + xtx.txId + " confirmed in round " + confirmedTxn["confirmed-round"]);

        // You should now see the 10 assets listed in the account information
        console.log("Account 3 = " + account_to.addr);
        await printAssetHolding(algodclient, account_to.addr, assetID);
    }

    async get_algo_info(account)
    {
        // Get the account information for the new account
        let accountInfo = await algod_client.accountInformation(account.addr).do();
        console.log("Account balance: %d microAlgos", accountInfo.amount);
        console.log("Account = " + account.addr);
        console.log("Account info",accountInfo);
    }

    // make payment method
    async make_payment(seed,address_to)
    {
        console.log(seed);
        //Get the relevant params from the algod
        const params = await this.algo_client.getTransactionParams().do();
        params.fee = 1000;
        params.flatFee = true;

        // get the algo account from the seed
        const algoAccount = algosdk.mnemonicToSecretKey(seed);

        const payment=algosdk.makePaymentTxnWithSuggestedParamsFromObject({
            "from":algoAccount.addr,
            "to":address_to,
            "amount":1000000,
            "suggestedParams":params
        });
        
        const signedTxn=payment.signTxn(algoAccount.sk);
        const { txId } = await this.algo_client.sendRawTransaction(signedTxn).do()
        console.log(txId)

        await algosdk.waitForConfirmation(this.algo_client, txId, 4)
        console.log("transaction successful");
        //document.getElementById('status').innerHTML = 'SDK Status: Working!';
    }


    async fund_account(seed)
    {
        console.log(seed);
        const myAccount = algosdk.mnemonicToSecretKey(seed);
        const netAddr='https://dispenser.testnet.aws.algodev.network?account=' + myAccount.addr;
        console.log(netAddr);
        var strWindowFeatures = "location=yes,height=570,width=520,scrollbars=yes,status=yes";
        window.open(netAddr, "_blank", strWindowFeatures);
    }
}
export default AlgoOperations;