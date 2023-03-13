<template>
  <el-avatar :size="414" class="top-avatar" shape="circle">
    <img src="http://img01.yohoboys.com/contentimg/2018/11/22/13/0187be5a52edcdc999f749b9e24c7815fb.jpg">
  </el-avatar>
  <div class="gray-back">
    <div class="content-account">
      <div style="background-color: white; height: calc(100vh - 480px)">
        <div class="account-basic">
          <el-row>
            <div style="display: flex">              
              <span class="account-username">{{ username }} </span>
            </div>
          </el-row>
          <el-row>
            <span class="account-algoacc">{{ algoAcc }} </span>
            <el-button type="primary" @click="onClickFundAccount()">Fund Account</el-button>
          </el-row>
          <el-row>
            <span class="account-algoacc">{{ useremail }}</span>
          </el-row>
        </div>
        <!-- tabs -->
        <el-tabs 
          v-model="activeName" 
          class="account-tabs"
          :stretch="true"
          @tab-click="onTabClick"
        >
          <!-- my wallet
          <el-tab-pane label="My Wallet" name="mywallet">
            <el-table :data="NFTs" style="width: 100%">
              <el-table-column label="Collection" width="210">
                <template #default="scope">
                  <div style="display: flex; align-items: center">
                    <el-avatar><img src="@/assets/logo.png"></el-avatar>
                    <span style="margin-left: 10px">{{ scope.row.name }}</span>
                  </div>
                </template>
              </el-table-column>
              <el-table-column prop="course" label="Course" width="100" />
              <el-table-column label="Star Level" width="400">
                  <template #default="scope">
                    <StarLevel :starLevel="scope.row.starLevel"></StarLevel>
                  </template>
              </el-table-column>
              <el-table-column label="Tran">

              </el-table-column>
            </el-table>
          </el-tab-pane> -->
          <!-- collection -->
          <el-tab-pane label="Collection" name="collection">
            <div class="collection-div">
              <div class="search">
                <el-input 
                  v-model="inputFilter" 
                  placeholder="Please input"
                  :prefix-icon="Filter"
                  input-style="width: 1072px; height: 76px; font-size: 24px; font-family: Futura;"
                ></el-input>         
              </div>
              <el-button plain @click="onRefresh()">Refresh</el-button> 
              <div class="nft-cards">
                <el-row>
                  <el-col
                    v-for="(item, index) in NFTs"
                    :key="index"
                    :span="8"
                  >
                    <NFTCard :NFTInfo="item" @click.stop="onClickCard(item.course, item.id)"></NFTCard>
                  </el-col>
                </el-row>          
              </div>
            </div>
          </el-tab-pane>
          <el-tab-pane label="Create NFT" name="transfer">
            <div style="width: 100%; height: 660px; display: flex; justify-content: center; align-items: center; padding-top: 120px">
              <ProfTransfer />
            </div>
          </el-tab-pane>
        </el-tabs>
      </div>
    </div>
  </div>

</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { Star, StarFilled, Filter } from '@element-plus/icons-vue'
import ProfTransfer from '@/components/ProfTransfer.vue'
import NFTCard from '@/components/NFTCard.vue'
import StarLevel from '@/components/StarLevel.vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import algosdk from 'algosdk'

const router = useRouter();
const store = useStore()
const thisUser = store.state.FirebaseOps.user

const username = ref(thisUser.user_collection.name)
const algoAcc = ref(thisUser.user_collection.address)
const useremail = ref(thisUser.user_collection.email)

// tab controller
const activeName = ref('collection')

const inputFilter = ref('')
var NFTs = ref([
])


const currentUser = store.state.FirebaseOps.user

const thisAlgo=store.state.AlgoOps
var seed=currentUser.user_collection.passphrase
thisAlgo.get_algo_info(algosdk.mnemonicToSecretKey(seed)).then((asset_lit:any)=>{
  // print the length of asset list
  // console.log(asset_lit.length)
  for (let i = 0; i < asset_lit.length; i++)
  {
    let asset_id=asset_lit[i]['asset-id']
    // console.log(asset_id)
    thisAlgo.get_asset_info(asset_id).then((asset_info:any)=>{
      console.log(asset_info)
      // console.log(asset_info.params)
      currentUser.read_assets_by_id(asset_id.toString()).then((asset_data:any)=>{
          console.log(asset_data)
          if(asset_data!=undefined)
          {
              let attributes={
                  id:asset_id,
                  name:asset_info.params.name,
                  course:asset_info.params['unit-name'],
                  comment: asset_data.comment,
                  genre: asset_data.genre,
                  starLevel: parseInt(asset_data.starlevel),
                  imgSrc: ref(asset_info.params.url)
              }   
              NFTs.value.push(attributes)
          }
      })
                
    })
  }
})

// console.log(thisAlgo.get_account_assets())

// tab controller

const onRefresh = () => {
  console.log("refresh")
  NFTs = ref([])
  thisAlgo.get_algo_info(algosdk.mnemonicToSecretKey(seed)).then((asset_lit:any)=>{
    // print the length of asset list
    // console.log(asset_lit.length)
    for (let i = 0; i < asset_lit.length; i++)
    {
      let asset_id=asset_lit[i]['asset-id']
      // console.log(asset_id)
      thisAlgo.get_asset_info(asset_id).then((asset_info:any)=>{
        console.log(asset_info)
        // console.log(asset_info.params)
        currentUser.read_assets_by_id(asset_id.toString()).then((asset_data:any)=>{
            console.log(asset_data)
            if(asset_data!=undefined)
            {
                let attributes={
                    id:asset_id,
                    name:asset_info.params.name,
                    course:asset_info.params['unit-name'],
                    comment: asset_data.comment,
                    genre: asset_data.genre,
                    starLevel: parseInt(asset_data.starlevel),
                    imgSrc: ref(asset_info.params.url)
                }   
                NFTs.value.push(attributes)
            }
        })
                  
      })
    }
  })
}

const onClickCard = (courseId : string, nftId : number) => {
  router.push({path: `/course/${courseId}/${nftId}`})
}

// fund account
const onClickFundAccount = () => {
  console.log("fund?")
  try{
    thisAlgo.fund_account(seed)
  }
  catch(e){
    console.error(e)
  }

}

const onTabClick = (pane, ev) => {
  if (pane="Collection") {
    console.log("collection！！！！")
  }
}

</script>

<style lang="less" scoped>
.gray-back {
  background-color: #F5F5F5;
  height: 100vh;
}
.content-account {
  padding: 480px 20px 0px;
  
  // position: absolute;
}
.top-avatar {
  margin: 169px 0 0 103px;
  position: absolute;
  z-index: 1000;
}

.account-basic {
  padding-top: 120px;
  padding-left: 106px;
}
.account-username {
  font-size: 48px; 
  font-family: Futura; 
  font-weight: bold; 
  width: 100%;
  
}

.account-algoacc {
  font-size: 21px; 
  font-family: Futura; 
  width: 100%;
  line-height: 26px;
}

.account-tabs {
  margin: 156px 40px 0;

}


/deep/ .el-tabs__item {
  font-size: 36px;
  font-family: Futura;
  font-weight: bold;
  height: 50px;
  text-align: center;
}

.collection-div {
  width: 100%;
  height: 100%;
}
.search {
  width: 100%;
  display: flex;
  justify-content: center;
  margin-top: 72px;
}
.nft-cards {
  padding: 103px 0px 0px;
}
.el-col {
  display: flex;
  justify-content: center;
  height: 600px;
  margin-bottom: 20px;
}
</style>
