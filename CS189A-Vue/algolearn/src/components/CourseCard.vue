<template>

<el-card class="course-card" :body-style="{ padding: '0px', height: '219px' }">
  <div class="course-top">
    <div class="course-top-text">
      <span style="font-size: 36px; font-family: Futura; line-height: 39px;">{{ props.courseInfo.courseId }}</span>
      <span style="font-size: 16px; font-family: Futura; line-height: 39px;">{{ props.courseInfo.courseName }}</span>
    </div>
  </div>
  <div class="course-bottom">
      
  </div>
</el-card>

</template>

<script lang="ts" setup>
import { defineProps } from 'vue'

const props = defineProps({
  courseInfo: {
    type: Object,
    default: () => {
      return {
        courseId: 'COURSE 000',
        courseName: 'Course name',
        courseNum: 0
      }
    }
  }
})
</script>

<style lang="less" scoped>
.course-card {
    width: 589px;
}

.course-bottom {
  height: 62px;
  padding: 0px 58px;
  background-color: #2DB6BC;
  display: flex;
  align-items: center;
}

.button {
  padding: 0px;
  width: 100%;
  display: flex;
  justify-content: flex-start;
}

.course-top {
  height: 157px;
//   display: block;
}

.course-top-text {
  margin: 32px 0 0 58px;
  display: flex;
  flex-direction: column;
}

.course-name {
    margin: 10px 10px 0px;
    width: 100%;
    padding: 0px;
    display: flex;
    justify-content: flex-start;
}
</style>
