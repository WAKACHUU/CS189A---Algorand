<template>
  <el-avatar :size="414" class="top-avatar" shape="circle">
    <img src="@/assets/logo.png">
  </el-avatar>
  <div class="gray-back">
    <div class="content-account">
      <div style="background-color: white; height: calc(100vh - 480px)">
        <div class="account-basic">
          <el-row>
              <span class="account-username">{{ username }} </span>
          </el-row>
          <el-row>
            <span class="account-algoacc">{{ algoAcc }} </span>
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
        >
          <!-- my wallet -->
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

            </el-table>
          </el-tab-pane>
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
              <div class="nft-cards">
                <el-row>
                  <el-col
                    v-for="(item, index) in NFTs"
                    :key="index"
                    :span="8"
                  >
                    <NFTCard :NFTInfo="item"></NFTCard>
                  </el-col>
                </el-row>          
              </div>
            </div>
          </el-tab-pane>
          <el-tab-pane label="Create NFT" name="transfer">
            <ProfTransfer />
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

const store = useStore()
const thisUser = store.state.FirebaseOps.user

const username = ref(thisUser.user_collection.name)
const algoAcc = ref(thisUser.user_collection.address)
const useremail = ref(thisUser.user_collection.email)

// tab controller
const activeName = ref('mywallet')

const inputFilter = ref('')
const NFTs = ref([
  {
      name: ref("NFT 1"),
      course: ref("CS189A"),
      comment: ref("This is a comment"),
      genre: ref("Lecture 1"),
      starLevel: ref(2),
      imgSrc: ref("https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png")
  },
  {
    name: ref("NFT 1"),
    course: ref("CS189A"),
    comment: ref("This is a comment"),
    genre: ref("Lecture 1"),
    starLevel: ref(2),
    imgSrc: ref("https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png")
  },
  {
    name: ref("NFT 1"),
    course: ref("CS189A"),
    comment: ref("This is a comment"),
    genre: ref("Challenge"),
    starLevel: ref(2),
    imgSrc: ref("https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png")
  }
])

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
}
</style>
