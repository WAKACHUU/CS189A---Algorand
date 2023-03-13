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
                        <NFTCardLite :nftInfo="item" @click.stop="onClickCard(idx)"/>
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

    const router = useRouter()
    const courseId  = router.currentRoute.value.params.courseId
    console.log()
    
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

    // all NFT info here
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

    const onClickCard = (idx: number) => {
        const nftId = idx
        router.push({ path: `/course/${courseId}/${nftId}` })
        console.log(router)
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
    