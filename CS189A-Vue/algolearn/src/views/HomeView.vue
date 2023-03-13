<template>
  <el-scrollbar>
    <span>User Overview</span>
    <div class="profile-pic">
      <img src="@/assets/logo.png">
    </div>
    <div>
      <span>Welcome, </span>
      <span>{{ username }}</span>
    </div>
    <span></span>
    <div class="home">
      <CourseCard courseName="CS189A" :courseNum="7"/>
      <el-button @click="onClick()" >Fund</el-button>
      <el-button @click="onPress()" >Payment</el-button>
      <el-button @click="onCreate()" >Create</el-button>
      <el-button @click="onReceive()" >Opt In</el-button>
      <el-button @click="onTransfer()" >Transfer</el-button>
      <el-button @click="onGetinfo()" >Get Info</el-button> 
      <el-button @click="getIPFS()" >Get IPFS</el-button>  
    </div>
  </el-scrollbar>

</template>

<script lang="ts" setup>
import CourseCard from '@/components/CourseCard.vue'
import { add } from 'lodash';
import { ref } from 'vue'
import { useStore } from 'vuex'
import algosdk from 'algosdk'
// import the ipfs.js functions
import { scenario1,createNftScenario1,convertByte32ToIpfsCidV0,convertIpfsCidV0ToByte32 } from '@/backend/algorand/ipfs.js' 
const store = useStore()

const thisUser = store.state.FirebaseOps.user
const thisAlgo=store.state.AlgoOps
const seed = thisUser.user_collection.passphrase
const address=thisUser.user_collection.address


const onClick = () => {
  console.log("??")
  try{
    thisAlgo.fund_account(seed)
  }
  catch(e){
    console.error(e)
  }

}

const onPress = () => {
  console.log("!!")
  try{
    const account_to="HZ57J3K46JIJXILONBBZOHX6BKPXEM2VVXNRFSUED6DKFD5ZD24PMJ3MVA"
    thisAlgo.make_payment(seed,account_to,1000000)
  }
  catch(e){
    console.error(e)
  }

}

const onCreate=()=>{
  console.log("//")
  try{
    thisAlgo.create_asset(seed,"YIJIECAI","yijiecai")
  }
  catch(e){
    console.error(e)
  }
}

const onReceive=()=>{
  console.log("..")
  try{
    const account_seed="cancel auto fetch nest bench tomorrow cost bless position worry flavor client drastic pole describe steel napkin oyster call rebel valve can secret abstract shield"
    thisAlgo.opt_in_asset(account_seed,162926582)
  }
  catch(e){
    console.error(e)
  }
}

const onTransfer=()=>{
  console.log("==")
  try{
    const account_to="VPIYMTDRYEGAV2NZBMQAW3BEELWRPHEWY2566ZMUEA2GB7IJIKSVCQH3WA"
    thisAlgo.transfer_asset(seed,account_to,162926582)
  }
  catch(e){
    console.error(e)
  }
}

const onGetinfo=()=>{
  console.log("==")
  try{
    
    // const algoAccount = algosdk.mnemonicToSecretKey(seed);
    // thisAlgo.get_algo_info(algoAccount)
    thisAlgo.get_asset_info(162926582)
  }
  catch(e){
    console.error(e)
  }
}

const getIPFS=()=>{
  console.log("==")
  try{
    createNftScenario1()
  }
  catch(e){
    console.error(e)
  }
}

const username = ref('username')
</script>

<style lang="less" scoped>
.home-view {
  padding: 25px
}
.profile-pic {

}
.home {
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
