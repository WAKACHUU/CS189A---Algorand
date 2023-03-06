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
    </div>
  </el-scrollbar>

</template>

<script lang="ts" setup>
import CourseCard from '@/components/CourseCard.vue'
import { ref } from 'vue'
import { useStore } from 'vuex'
const store = useStore()
const thisUser = store.state.FirebaseOps.user
const algo_address = thisUser.user_collection.address
const secret_key = thisUser.user_collection.passphrase
console.log(algo_address)
const thisAsset = store.state.AssetOps
thisAsset.fund_account(algo_address, secret_key)
console.log(thisAsset)
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
