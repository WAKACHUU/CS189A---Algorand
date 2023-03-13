<template>
    <div class="course-area">
        <div>
            <span class="text-span">User Overview</span>
        </div>
    
        <div class="profile">
            <el-image style="width: 219px; height: 219px" :src="profilePicSrc" fit="fill" />
            <div class="user-info">
                <div>
                    <span class="text-span">Welcome, </span>
                    <span class="text-span">{{ username }}</span>
                </div>
                <div style="height: 24px;"></div>
                <div>
                    <span class="text-span-small">{{ userEmail }}</span>
                </div>
            </div>
        </div>
        <div class="my-courses">
            <span class="text-span">My Courses > {{ courseId }} </span>
            <el-scrollbar max-height="1000px" wrap-style="margin-top: 75px">
                <el-row>
                    <el-col v-for="(item, idx) in NFTs" :key="idx" :span="12">
                        <NFTCardLite :nftInfo="item" @click.stop="onClickCard(item.id)"/>
                    </el-col>
                </el-row>
            </el-scrollbar>
        </div>
    
    </div>
    
    </template>
    
    <script lang="ts" setup>
    import { ref } from 'vue'
    import { useRouter } from 'vue-router'
    import NFTCardLite from '@/components/NFTCardLite.vue'
    import { useStore } from 'vuex'
import algosdk from 'algosdk';

    const router = useRouter()
    const store = useStore()
    const thisUser = store.state.FirebaseOps.user
    const courseId  = router.currentRoute.value.params.courseId
    
    const profilePicSrc = ref('http://img01.yohoboys.com/contentimg/2018/11/22/13/0187be5a52edcdc999f749b9e24c7815fb.jpg')

    const username = ref(thisUser.user_collection.name)
    const userEmail = ref(thisUser.user_collection.email)
    
    // all course info here
    // const courseInfo = ref([
    //   {
    //     courseId: 'CS189A',
    //     courseName: 'Capstone Project',
    //     courseNum: 7
    //   }
    // ])

    // all NFT info here
    const NFTs = ref([])
    
    const currentUser = store.state.FirebaseOps.user
    const thisAlgo=store.state.AlgoOps
    var seed=currentUser.user_collection.passphrase
    thisAlgo.get_algo_info(algosdk.mnemonicToSecretKey(seed)).then((asset_lit:any)=>{
    // print the length of asset list
    // console.log(asset_lit.length)
    for (let i = 0; i < asset_lit.length; i++)
    {
        let asset_id=asset_lit[i]['asset-id']
        // currentUser.read_assets_by_id(asset_id.toString()).then((asset_data:any)=>{
        //     console.log(asset_data)
            // console.log(asset_id)
            thisAlgo.get_asset_info(asset_id).then((asset_info:any)=>{
            // console.log(asset_info)
            // console.log(asset_info.params)
                if(asset_info.params['unit-name']==courseId){
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
                }
            })
        // })

       
    }
    })


    const onClickCard = (nftId: string) => {
        console.log("NFTS", NFTs.value)
        console.log("nftId??", nftId)
        router.push({ path: `/course/${courseId}/${nftId}` })
        // console.log(router)
    }
    </script>

    <style lang="less" scoped>
    .course-area {
        margin: 172px 101px 0px 101px;
    }
    .home-view {
      padding: 25px
    }
    .text-span {
        font-size: 36px;
        font-family: Futura;
        line-height: 43px;
    }
    .text-span-small {
        font-size: 21px;
        font-family: Futura;
        line-height: 43px;
    }
    .profile {
        margin-top: 11px;
        width: 100%;
        display: flex;
        flex-direction: row;
    }
    .user-info {
        margin-left: 48px;
        display: flex;
        flex-direction: column;
    }
    
    .my-courses {
        margin-top: 88px;
        width: 100%;
    }
    .el-col {
        display: flex;
        justify-content: center;
        height: 363px;
    }
    </style>
    