<template>
  <div>
    <div class="main-content">
      <router-view/>
    </div>
  <!-- bottom navigation bar -->
  <div v-if="showBottomBar" class="bottom-nav">
    <!-- <router-link to="/" class="nav-item">
      <div style="justify-content: center;">
        <div style="width: 100%; display: flex; justify-content: center;">
          <el-icon><House /></el-icon>          
        </div>
        <div class="btm-nav-text">
          <span>Home</span>
        </div>
      </div>
    </router-link> -->
    <router-link to="/course" class="nav-item">
      <div style="justify-content: center;">
        <div style="width: 100%; display: flex; justify-content: center;">
          <el-icon><School /></el-icon>          
        </div>
        <div class="btm-nav-text">
          <span>Courses</span>
        </div>
      </div>
    </router-link>
    <router-link to="/account" class="nav-item">
      <div style="justify-content: center;">
        <div style="width: 100%; display: flex; justify-content: center;">
          <el-icon><User /></el-icon>          
        </div>
        <div class="btm-nav-text">
          <span>Me</span>
        </div>
      </div>
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
import { ref, watch } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'


const store = useStore()
const router = useRouter()
const currentRoute = ref(router.currentRoute.value.fullPath)
console.log(currentRoute)

const showBottomBar = ref(store.state.FirebaseOps.SignInState)

watch(() => store.state.FirebaseOps.SignInState, (newVal) => {
  showBottomBar.value = newVal
  console.log(showBottomBar.value)
})

watch(() => router.currentRoute.value.fullPath, (newVal) => {
  currentRoute.value = newVal
  if (newVal == '/login' || newVal == '/register') {
    showBottomBar.value = false
  } else {
    showBottomBar.value = true
  }
})
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
.el-icon {
  width: 5em;
  height: 5em;
  color: #fff;
  padding-left: 8px;
}

.el-icon svg {
  width: 100%;
  height: 100%;
}

a {
  text-decoration: none;
}
.router-link-active {
  text-decoration: none;
}

.bottom-nav {
  position: fixed;
  bottom: 0;
  width: 100%;
  height: 150px;
  background-color: #2DB6BC;
  border-top: 1px solid #eee;
  z-index: 100;
  box-shadow: 0px -2px 10px rgba(0, 0, 0, 0.1);

  display: flex;
  justify-content: space-around;
  align-items: center;
}

.btm-nav-text {
  font-size: 32px;
  font-family: Futura;
  line-height: 39px;
  color: white;
  text-decoration: none!important;
  display: flex;
  justify-content: center;
}

</style>
