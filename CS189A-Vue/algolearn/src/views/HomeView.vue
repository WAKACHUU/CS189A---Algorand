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
      <el-button @click="onReceive()" >Receive</el-button>
      <el-button @click="onTransfer()" >Transfer</el-button> 
    </div>
  </el-scrollbar>

</template>

<script lang="ts" setup>
import CourseCard from '@/components/CourseCard.vue'
import { ref } from 'vue'
import { useStore } from 'vuex'
const store = useStore()

const thisUser = store.state.FirebaseOps.user
const thisAlgo=store.state.AlgoOps
const seed = thisUser.user_collection.passphrase

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
    thisAlgo.create_asset(seed,10, "LATINUM","latinum")
  }
  catch(e){
    console.error(e)
  }
}

const onReceive=()=>{
  console.log("..")
  try{
    thisAlgo.receive_asset(seed,"XMOY5PUCIZWGRJQML27EWJSL4AFG2TNAQZKRWUKSBZLORPYLB2XWIIXXZI",162444558)
  }
  catch(e){
    console.error(e)
  }
}

const onTransfer=()=>{
  console.log("==")
  try{
    const account_to="HZ57J3K46JIJXILONBBZOHX6BKPXEM2VVXNRFSUED6DKFD5ZD24PMJ3MVA"
    thisAlgo.transfer_asset(seed,account_to,162444558)
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
