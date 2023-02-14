import algosdk from 'algosdk'
import { MyAlgoSession } from './wallets/myalgo'
import { WalletConnectSession } from './wallets/walletconnect'
import { AlgoSignerSession } from './wallets/algosigner'
import Utils from './utils'
import db from './firebase/init'
import {sign_in,sign_up,sign_out} from './firebase/operations'

try {

  // specific use of the firebase database
  console.log(db)
  const login_message=sign_in(db,'abc@ucsb.edu','abcabc')
  // get the return value from the promise
  login_message.then((value) => {
    console.log('return value',value)
  })

  const signout_message=sign_out()
  signout_message.then((value) => {
    console.log('return value',value)
  })



  // const signup_message=sign_up(db,'XichenHe','abc@ucsb.edu','abcabc','abcabc')
  // signup_message.then((value) => {
  //   console.log('return value',value)
  // })


  // const MyAlgo  = new MyAlgoSession()
  // MyAlgo.getAccounts()
  // // @ts-ignore
  // const account = algosdk.generateAccount()
  
  // console.log(account)
  // console.log(`Generated Algorand account: ${account.addr}`)
  // document.getElementById('status').innerHTML = 'SDK Status: Working!'
} catch (e) {
  console.error(e)
  document.getElementById('status').innerHTML = `SDK Status: Error - ${e.message}`
}
