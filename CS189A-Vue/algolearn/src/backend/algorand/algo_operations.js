import algosdk from 'algosdk'
// import { WalletConnectSession } from './wallets/walletconnect'
// import { AlgoSignerSession } from './wallets/algosigner'
// import Buffer from 'buffer'


class AlgoOperations{
    // algodclient = new algosdk.Algodv2('', 'https://testnet-api.algonode.cloud', '')
    constructor()
    {
        this.algo_client = new algosdk.Algodv2('', 'https://testnet-api.algonode.cloud', '')
        this.assets=[]; 
    }

    // const note = undefined;
        // arbitrary data to be stored in the transaction; here, none is stored
        // Asset creation specific parameters
        // The following parameters are asset specific
        // Throughout the example these will be re-used. 
        // We will also change the manager later in the example
        // Whether user accounts will need to be unfrozen before transacting    
        // const defaultFrozen = false;
        // integer number of decimals for asset unit calculation
        // let decimals = 0;
        // total number of this asset available for circulation   
        // const totalIssuance = 1000;
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
        // let manager = account1.addr;
        // Specified address is considered the asset reserve
        // (it has no special privileges, this is only informational)
        // let reserve = account1.addr;
        // Specified address can freeze or unfreeze user asset holdings 
        // let freeze = account1.addr;
        // Specified address can revoke user asset holdings and send 
        // them to other addresses    
        // let clawback = account1.addr;
    async create_asset(seed,unitName,assetName)
    {
        const params = await this.algo_client.getTransactionParams().do();
        // comment out the next two lines to use suggested fee
        params.fee = 1000;
        params.flatFee = true;

        const algoAccount = algosdk.mnemonicToSecretKey(seed);
        this.get_algo_info(algoAccount);

        const decimals=1;
        const txn=algosdk.makeAssetCreateTxnWithSuggestedParamsFromObject({
            from: algoAccount.addr,
            note: undefined,
            totalIssuance: 2000,
            decimals: decimals,
            defaultFrozen: false,
            manager: algoAccount.addr,
            reserve: algoAccount.addr,
            freeze: algoAccount.addr,
            clawback: algoAccount.addr,
            unitName: unitName,
            assetName: assetName,
            total: 2000,
            // assetURL: assetURL,
            // assetMetadataHash: assetMetadataHash,
            suggestedParams: params
        })

        const signedTxn=txn.signTxn(algoAccount.sk);
        const { txId } = await this.algo_client.sendRawTransaction(signedTxn).do()
        console.log(txId)

        // wait for transaction to be confirmed
        await algosdk.waitForConfirmation(this.algo_client, txId, 4);
        console.log("Asset Creation Transaction " + txId + " confirmed.");
    
        this.get_algo_info(algoAccount);
    }


    // async modify_asset(account1,account2,assetID)
    // {
    //     params = await algodclient.getTransactionParams().do();
    //     // comment out the next two lines to use suggested fee
    //     // params.fee = 1000;
    //     // params.flatFee = true;
    //     // Asset configuration specific parameters
    //     // all other values are the same so we leave 
    //     // them set.
    //     // specified address can change reserve, freeze, clawback, and manager
    //     manager = account1.addr;
    //     let reserve = account1.addr;
    //     // Specified address can freeze or unfreeze user asset holdings 
    //     let freeze = account1.addr;
    //     // Specified address can revoke user asset holdings and send 
    //     // them to other addresses    
    //     let clawback = account1.addr;
    //     let note = undefined;

    //     // Note that the change has to come from the existing manager
    //     let ctxn = algosdk.makeAssetConfigTxnWithSuggestedParams(
    //         account2.addr, 
    //         note, 
    //         assetID, 
    //         manager, 
    //         reserve, 
    //         freeze, 
    //         clawback, 
    //         params);

    //     // This transaction must be signed by the current manager
    //     rawSignedTxn = ctxn.signTxn(account2.sk)
    //     let ctx = (await this.algodclient.sendRawTransaction(rawSignedTxn).do());
    //     // Wait for confirmation
    //     let confirmedTxn = await algosdk.waitForConfirmation(algodclient, ctx.txId, 4);
    //     //Get the completed Transaction
    //     console.log("Transaction " + ctx.txId + " confirmed in round " + confirmedTxn["confirmed-round"]);

    //     // Get the asset information for the newly changed asset
    //     // use indexer or utiltiy function for Account info
    //     // The manager should now be the same as the creator
    //     await printCreatedAsset(algodclient, account1.addr, assetID);
    // }

    // opt in to asset
    async opt_in_asset(seed,assetID)
    {
        // Opting in to transact with the new asset
        // Allow accounts that want recieve the new asset
        // Have to opt in. To do this they send an asset transfer
        // of the new asset to themseleves 
        // In this example we are setting up the 3rd recovered account to 
        // receive the new asset
        // let note=undefined;
        // First update changing transaction parameters
        // We will account for changing transaction parameters
        // before every transaction in this example
        const params = await this.algo_client.getTransactionParams().do();
        params.fee = 1000;
        params.flatFee = true;

        const algoAccount = algosdk.mnemonicToSecretKey(seed);
        this.get_algo_info(algoAccount);

        const amount = 0;

        const txn=algosdk.makeAssetTransferTxnWithSuggestedParamsFromObject({
            from: algoAccount.addr,
            to: algoAccount.addr,
            amount: amount,
            note: undefined,
            assetIndex: assetID,
            suggestedParams: params,
            revocationTarget: undefined,
            closeRemainderTo: undefined
        })
        
        const signedTxn=txn.signTxn(algoAccount.sk);
        const { txId } = await this.algo_client.sendRawTransaction(signedTxn).do()
        console.log(txId)

        await algosdk.waitForConfirmation(this.algo_client, txId, 4);
        console.log("Asset Receive Transaction " + txId + " confirmed.");

        this.get_algo_info(algoAccount);
    }



    async transfer_asset(seed_from,account_to,assetID)
    {
        // Transfer New Asset:
        // Now that account3 can recieve the new tokens 
        // we can tranfer tokens in from the creator
        // to account3
        // First update changing transaction parameters
        // We will account for changing transaction parameters
        // before every transaction in this example

        const params = await this.algo_client.getTransactionParams().do();
        //comment out the next two lines to use suggested fee
        params.fee = 1000;
        params.flatFee = true;

        const algoAccount = algosdk.mnemonicToSecretKey(seed_from);
        this.get_algo_info(algoAccount);

        //Amount of the asset to transfer
        const amount = 10;

        const txn=algosdk.makeAssetTransferTxnWithSuggestedParamsFromObject({
            from: algoAccount.addr,
            to: account_to,
            amount: amount,
            note: undefined,
            assetIndex: assetID,
            suggestedParams: params,
            revocationTarget: undefined,
            closeRemainderTo: undefined

        })

        const signedTxn=txn.signTxn(algoAccount.sk);
        const { txId } = await this.algo_client.sendRawTransaction(signedTxn).do()
        console.log(txId)

        await algosdk.waitForConfirmation(this.algo_client, txId, 4);
        console.log("Asset Transfer Transaction " + txId + " confirmed.");

        this.get_algo_info(algoAccount);
    }

    async get_algo_info(account)
    {
        // Get the account information for the new account
        let accountInfo = await this.algo_client.accountInformation(account.addr).do();
        // the list of dictionaries of assets
        const account_asset=accountInfo.assets;
        console.log("This is the account assets",account_asset)
        console.log("Account balance: %d microAlgos", accountInfo.amount);
        console.log("Account = " + account.addr);
        console.log("Account info",accountInfo);
    }

    // make payment method
    async make_payment(seed,address_to,amount)
    {
        console.log(seed);
        //Get the relevant params from the algod
        const params = await this.algo_client.getTransactionParams().do();
        params.fee = 1000;
        params.flatFee = true;

        // get the algo account from the seed
        const algoAccount = algosdk.mnemonicToSecretKey(seed);
        this.get_algo_info(algoAccount);
        const payment=algosdk.makePaymentTxnWithSuggestedParamsFromObject({
            "from":algoAccount.addr,
            "to":address_to,
            "amount":amount,
            "suggestedParams":params
        });
        
        const signedTxn=payment.signTxn(algoAccount.sk);
        const { txId } = await this.algo_client.sendRawTransaction(signedTxn).do()
        console.log(txId)

        await algosdk.waitForConfirmation(this.algo_client, txId, 4)
        console.log("transaction successful");

        // get the account info
        this.get_algo_info(algoAccount);
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

    async get_asset_info(assetID)
    {
        const assetInfo = await this.algo_client.getAssetByID(assetID).do();
        console.log('This is the asset info',assetInfo);
    }
}
export default AlgoOperations;