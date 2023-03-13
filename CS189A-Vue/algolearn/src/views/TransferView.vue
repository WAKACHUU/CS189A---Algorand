<template>
    <el-avatar :size="414" class="top-avatar" shape="circle">
      <img src="http://img01.yohoboys.com/contentimg/2018/11/22/13/0187be5a52edcdc999f749b9e24c7815fb.jpg">
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
          >
            <el-tab-pane label="Transaction" name="transaction">
              <div class="collection-div">
                <div class="nft-cards">
                    <!-- <NFTCard :NFTInfo="nftInfo"></NFTCard>         -->
                </div>
                <div style="width: 800px; display: flex; align-items: center;">
                    <div style="width: 50px; height: 100%; vertical-align: middle;"></div>
                    <div style="height: 306px;">
                        <div style="width: 100%;">
                            <span style="font-family: Futura; font-size: 36px;">Send To: </span>
                        </div>
                        <div style="width: 100%;  margin-top: 30px;">
                            <el-select
                                v-model="selectedStudents"
                                multiple
                                collapse-tags
                                collapse-tags-tooltip
                                placeholder="Select"
                                style="width: 750px; height: 100px"
                                :popper-append-to-body="false"
                                popper-class="select-popper"
                                filterable
                                >
                                <el-option
                                    v-for="(item, idx) in studentNames"
                                    :key="idx"
                                    :label="item.label"
                                    :value="item.value"
                                >
                                </el-option>
                            </el-select>
                        </div>
                        <div style="width: 100%;">
                            <el-button type="primary" @click="onClickSend()">Send</el-button> 
                        </div>
                    </div>                                      
                </div>

              </div>
            </el-tab-pane>
          </el-tabs>
        </div>
      </div>
    </div>
  
</template>
  
<script lang="ts" setup>
  import { ref } from 'vue'
  import { useStore } from 'vuex'
  import { Filter } from '@element-plus/icons-vue'
  import { useRouter } from 'vue-router'
  import NFTCard from '@/components/NFTCard.vue'
  import {db} from "./init.js";

  const store = useStore();
  const thisUser = store.state.FirebaseOps.user

  const username = ref(thisUser.user_collection.name)
  const algoAcc = ref(thisUser.user_collection.address)
  const useremail = ref(thisUser.user_collection.email)
  
  // tab controller
  const activeName = ref('transaction')

  const router = useRouter()
  const courseId  = router.currentRoute.value.params.courseId
  const nftId = router.currentRoute.value.params.nftId.toString()

  const thisAlgo=store.state.AlgoOps
  const seed = thisUser.user_collection.passphrase

  // const toForm = ref('')

  const studentNames = ref([])
  
  const nftInfo = ref({});
  const asset_info=thisAlgo.get_asset_info(nftId)
  asset_info.then((asset_info:any)=>{
      console.log(asset_info)
      console.log(asset_info.params)
      nftInfo.value={
          id:nftId,
          name:asset_info.params.name,
          course:asset_info.params['unit-name'],
          comment: asset_info.params.total,
          genre: ref("Lecture 1"),
          starLevel: ref(2),
          imgSrc: ref("https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png")
      }
      console.log('This is the nftInfo',nftInfo)

      // set the students enrolled in this course
      const student_enrolled=thisUser.read_class_by_name("CS189A")
      student_enrolled.then((student_enrolled:any)=>{
        let emails=student_enrolled.enrolledEmail
        for (let i=0;i<emails.length;i++){
          let info=thisUser.read_address_by_email(emails[i])
          info.then((info:any)=>{
            console.log(info)
            studentNames.value.push({
                value: {address: info.address, name: info.name, passphrase: info.passphrase},
                label: info.name}
            )
          })
        }
      })
  })


  // select logic
  const selectedStudents = ref([])
  // console.log('Selected Students',selectedStudents.value)

const onClickSend = () => {
  console.log("send?")
  // console.log('Selected Students',selectedStudents.value) 
  for (let i=0;i<selectedStudents.value.length;i++){
    let students_seeds=selectedStudents.value[i]['passphrase']
    let address_to=selectedStudents.value[i]['address']
    console.log("ID",students_seeds)
    console.log("address",address_to)
    thisAlgo.opt_in_asset(students_seeds,parseInt(nftId)).then(()=>{
      console.log(2)
      thisAlgo.transfer_asset(seed,address_to,parseInt(nftId)).then(()=>{
        console.log(1)
      })
    })
    // thisAlgo.transfer_asset(seed,address_to,parseInt(nftId))
  }



}
  

function doc(db: any, arg1: string, email: any) {
throw new Error('Function not implemented.')
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
    display: flex;
  }
  .search {
    width: 100%;
    display: flex;
    justify-content: center;
    margin-top: 72px;
  }
  .nft-cards {
    padding: 103px 0px 0px;
    margin-left: 50px;
    height: 600px;
  }

  /deep/ .el-input__wrapper {
    height: 50px;
    font-size: 20px;
  }
  
  .select-popper {
    width: 750px;
    height: 100px;
    font-size: 20px;
  }

  /deep/ .el-select__tags {
    top: 25%!important;
  }

  .el-button--primary {
    width: 200px;
    height: 70px;
    font-size: 30px;
    font-family: Futura;
    font-weight: bold;
  }
</style>

<style lang="less">
</style>