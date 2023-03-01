<template>
  <div>
    <div class="main-content">
      <router-view/>
    </div>
  <!-- bottom navigation bar -->
  <div class="bottom-nav">
    <router-link to="/" class="nav-item">
      <el-icon><House /></el-icon>
      <span>首页</span>
    </router-link>
    <router-link to="/course" class="nav-item">
      <el-icon><School /></el-icon>
      <span>课程</span>
    </router-link>
    <router-link to="/account" class="nav-item">
      <el-icon><User /></el-icon>
      <span>我的</span>
    </router-link>
  </div>
  <!-- <nav>
    <router-link to="/">Home</router-link> |
    <router-link to="/about">About</router-link> |
    <router-link to="/login">Login</router-link>
  </nav> -->
  </div>
</template>

<script lang="ts" setup>
import { House, School, User } from '@element-plus/icons-vue'
// import { ref } from 'vue'

</script>

<style lang="less" >
body {
  margin: 0;
}

#app {
  width: 100vw;
  height: calc(100vh - 50px);
}
</style>

<style lang="less" scoped>
.main-content {
  width: 100%;
  height: 100%;
  position: relative;
}

.bottom-nav {
  position: fixed;
  bottom: 0;
  width: 100%;
  height: 50px;
  background-color: #fff;
  border-top: 1px solid #eee;
  z-index: 100;
}

</style>
