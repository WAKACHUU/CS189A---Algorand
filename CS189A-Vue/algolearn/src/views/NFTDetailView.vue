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
            <span class="text-span">My Courses > {{ courseId }} > {{ nftInfo.name }}</span>
            <el-scrollbar 
                class="scrollbar" 
                max-height="1000px" 
                wrap-style="margin-top: 75px; width: 100%;"
                view-style="display: flex;"
            >
                <div>
                    <el-image style="width: 640px; height: 640px" :src="nftInfo.imgSrc"></el-image>
                </div>
                
                <div style="width: calc(100% - 650px); height: 640px; margin-left: 60px">
                    <span style="font-size: 50px; font-family: Futura; font-weight: bold;"> {{ nftInfo.name }} </span>  
                    <div style="margin-top: 50px">
                        <StarLevel :starLevel="nftInfo.starLevel" /> 
                    </div> 
                    <div style="margin-top: 50px">
                        <el-tag class="ml-2" type="info">{{ nftInfo.genre }}</el-tag>
                    </div>
                    <div style="margin-top: 100px">
                        <span style="font-size: 24px; font-family: Futura;">
                            {{ nftInfo.comment }}
                        </span>
                    </div>
                    <!-- button for transfer -->
                    <div style="position: absolute; bottom: 0">
                        <el-button type="primary" @click="onClickTransfer()">Transfer</el-button>
                    </div>
                </div>
            </el-scrollbar>
        </div>
    
    </div>
    
</template>
    
<script lang="ts" setup>
    import { ref } from 'vue'
    import { useRouter } from 'vue-router'
    import { useStore } from 'vuex'
    import StarLevel from '@/components/StarLevel.vue'
    import algosdk from 'algosdk';
    const store = useStore()

    const router = useRouter()

    const courseId  = router.currentRoute.value.params.courseId
    const nftId = router.currentRoute.value.params.nftId.toString()

    const thisUser = store.state.FirebaseOps.user
    
    const profilePicSrc = ref('http://img01.yohoboys.com/contentimg/2018/11/22/13/0187be5a52edcdc999f749b9e24c7815fb.jpg')
    const username = ref(thisUser.user_collection.name)
    const userEmail = ref(thisUser.user_collection.email)

    
    const currentUser = store.state.FirebaseOps.user

    const thisAlgo=store.state.AlgoOps
    // const attributes = ref({});
    const nftInfo = ref({});
    const asset_info=thisAlgo.get_asset_info(nftId)
    asset_info.then((asset_info:any)=>{
        console.log(asset_info)
        console.log(asset_info.params)
        // let Note=asset_info.params.note
        // Note=algosdk.decodeObj(Note)
        // console.log("This is the Note",Note)

        if(asset_info.params['unit-name']==courseId){
                    currentUser.read_assets_by_id(nftId.toString()).then((asset_data:any)=>{
                        console.log(asset_data)
                        if(asset_data!=undefined)
                        {
                            nftInfo.value={
                                id:nftId,
                                name:asset_info.params.name,
                                course:asset_info.params['unit-name'],
                                comment: asset_data.comment,
                                genre: asset_data.genre,
                                starLevel: parseInt(asset_data.starlevel),
                                imgSrc: ref(asset_info.params.url)
                            }   
                            
                        }
                    })
                }
        console.log('This is the nftInfo',nftInfo)
    })
    // console.log('NFT values',NFTs.value)

    const onClickTransfer = () => {
        router.push({path: `/course/${courseId}/${nftId}/transfer`})
    }

</script>
    
<style lang="less" scoped>
    .el-tag {
        height: 36px;
        font-size: 20px;
        letter-spacing: 4px;
        text-transform: uppercase;
    }
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

    .scrollbar {
        width: 100%;
    }

    .el-button {
        width: 261px;
        height: 100px;
        font-size: 36px;
        font-family: Futura;
    }
    
    .el-button:focus {
        border-color: #abe1e4;
        background-color: #abe1e4;
    }

</style>
    