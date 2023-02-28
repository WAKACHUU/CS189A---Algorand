<template>

<el-card class="course-card" :body-style="{ padding: '0px', height: '120px' }">
  <div class="course-top">
    <el-button text class="course-name">{{props.courseName}}</el-button>
  </div>
  <div class="course-bottom">
      <el-button text class="button">{{props.courseNum}}</el-button>
  </div>
</el-card>

</template>

<script lang="ts" setup>
import { defineProps } from 'vue'

const props = defineProps({
  courseName: String,
  courseNum: Number
})
</script>

<style lang="less" scoped>
.course-card {
    width: 45%;
    height: 120px;
}
.time {
  font-size: 12px;
  color: #999;
}

.course-bottom {
  padding: 0px 10px;
  background-color: #2DB6BC;
}

.button {
  padding: 0px;
  width: 100%;
  display: flex;
  justify-content: flex-start;
}

.course-top {
  height: 76px;
  padding: 10px 10px 0px;
//   display: block;
}

.course-name {
    width: 100%;
    padding: 0px;
    display: flex;
    justify-content: flex-start;
}
</style>
