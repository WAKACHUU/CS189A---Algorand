<template>
<div>
  <span>User Overview</span>
  <div class="profile-pic">
    <img src="@/assets/logo.png">
  </div>
  <div>
    <span>Welcome, </span>
    <span>{{ username }}</span>
  </div>
  <div style="height: 50px"></div>
  <span>My Courses</span>
  <el-scrollbar>
    <div class="home">
        <CourseCard courseName="CS189A" :courseNum="7"/>
    </div>
  </el-scrollbar>
</div>

</template>

<script lang="ts" setup>
import CourseCard from '@/components/CourseCard.vue'
import { ref } from 'vue'

const username = ref('username')

const courseInfo = ref([
  {
    courseName: 'CS189A',
    courseNum: 7
  }
])
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
