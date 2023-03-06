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
        <span class="text-span">My Courses</span>
        <el-scrollbar max-height="1000px" wrap-style="margin-top: 75px">
            <CourseCard v-for="ci in courseInfo" :key="ci.courseId" :courseInfo="ci" />
        </el-scrollbar>
    </div>

</div>

</template>

<script lang="ts" setup>
import CourseCard from '@/components/CourseCard.vue'
import { ref } from 'vue'

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

</style>
