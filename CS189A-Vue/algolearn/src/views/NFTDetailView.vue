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
                
                <div style="width: calc(100% - 650px); margin-left: 60px">
                    <span style="font-size: 50px; font-family: Futura; font-weight: bold;"> {{ nftInfo.name }} </span>  
                    <div style="margin-top: 50px">
                        <StarLevel :starLevel="nftInfo.starLevel" /> 
                    </div> 
                    <div style="margin-top: 100px">
                        <span style="font-size: 24px; font-family: Futura;">
                            {{ nftInfo.comment }}
                        </span>
                    </div>
                    <!-- button for transfer -->
                    <div style="margin-top: 218px">
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
    import StarLevel from '@/components/StarLevel.vue'

    const router = useRouter()
    const courseId  = router.currentRoute.value.params.courseId
    const nftId = router.currentRoute.value.params.nftId.toString()
    
    const username = ref('username')
    const profilePicSrc = ref('http://img01.yohoboys.com/contentimg/2018/11/22/13/0187be5a52edcdc999f749b9e24c7815fb.jpg')
    const userEmail = ref('user@ucsb.edu')
    
    
    // all course info here
    const courseInfo = ref([
      {
        courseId: 'CS189A',
        courseName: 'Capstone Project',
        courseNum: 7
      }
    ])

    const NFTs = ref([
    {
        id: ref("1"),
        name: ref("NFT 1"),
        course: ref("CS189A"),
        comment: ref("This is a comment. This is a comment. This is a comment. This is a comment."),
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

    const onClickTransfer = () => {
        router.push({path: `/course/${courseId}/${nftId}/transfer`})
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
    