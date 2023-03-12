import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import AboutView from '../views/AboutView.vue'
import LoginView from '../views/LoginView.vue'
import RegisterView from '../views/RegisterView.vue'
import CourseView from '../views/CourseView.vue'
import CourseDetailView from '../views/CourseDetailView.vue'
import AccountView from '../views/AccountView.vue'
import SingleCourse from '../views/SingleCourse.vue'
import NFTDetailView from '../views/NFTDetailView.vue'
import TransferView from '../views/TransferView.vue'
// import LoginView from '../views/LoginView.vue'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    name: 'Home',
    component: HomeView
  },
  {
    path: '/login',
    name: 'login',
    component: LoginView
  },
  {
    path: '/register',
    name: 'register',
    component:  RegisterView
  },
  //course list
  {
    path: '/course',
    name: 'course',
    component: CourseView,
  },
  // course detail
  {
    path: '/course/:courseId',
    name: 'course-detail',
    component: CourseDetailView
  },
  {
    path: '/course/:courseId/:nftId',
    name: 'course-detail-nft',
    component: NFTDetailView,
  },
  {
    path: '/course/:courseId/:nftId/transfer',
    name: 'course-detail-nft-transfer',
    component: TransferView,
  },
  {
    path: '/account',
    name: 'account',
    component: AccountView
  },
  // {
  //   path: '/singlecourse',
  //   name: 'singlecourse',
  //   component: SingleCourse
  // }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
