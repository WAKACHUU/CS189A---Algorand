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
          >
            <!-- collection -->
            <el-tab-pane label="Transaction" name="transaction">
              <div class="collection-div">
                <div class="nft-cards">
                    <NFTCard :NFTInfo="nftInfo"></NFTCard>        
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
                            <el-button type="primary" >Send</el-button> 
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
  import { Filter } from '@element-plus/icons-vue'
  import { useRouter } from 'vue-router'
  import NFTCard from '@/components/NFTCard.vue'

  
  const username = ref('username')
  const algoAcc = ref('algoacc')
  const useremail = ref('user@email.com')
  
  // tab controller
  const activeName = ref('transaction')

  const router = useRouter()
  const courseId  = router.currentRoute.value.params.courseId
  const nftId = router.currentRoute.value.params.nftId.toString()

  const toForm = ref('')
  
  const NFTs = ref([
    {
        id: ref("1"),
        name: ref("NFT 1"),
        course: ref("CS189A"),
        comment: ref("This is a comment"),
        genre: ref("Lecture 1"),
        starLevel: ref(2),
        imgSrc: ref("https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png")
    },
    {
      id: ref("2"),
      name: ref("NFT 1"),
      course: ref("CS189A"),
      comment: ref("This is a comment"),
      genre: ref("Lecture 1"),
      starLevel: ref(2),
      imgSrc: ref("https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png")
    },
    {
      id: ref("3"),
      name: ref("NFT 1"),
      course: ref("CS189A"),
      comment: ref("This is a comment"),
      genre: ref("Challenge"),
      starLevel: ref(2),
      imgSrc: ref("https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png")
    }
  ])

  const nftInfo = ref(NFTs.value[parseInt(nftId)]) 


  // select logic
  const selectedStudents = ref([])
  const studentNames = [
  {
    value: 'Option1',
    label: 'Option1',
  },
  {
    value: 'Option2',
    label: 'Option2',
  },
  {
    value: 'Option3',
    label: 'Option3',
  },
  {
    value: 'Option4',
    label: 'Option4',
  },
  {
    value: 'Option5',
    label: 'Option5',
  },
]
  
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