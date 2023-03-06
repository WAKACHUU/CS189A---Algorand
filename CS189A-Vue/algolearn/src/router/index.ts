import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import AboutView from '../views/AboutView.vue'
import LoginView from '../views/LoginView.vue'
import RegisterView from '../views/RegisterView.vue'
import CourseView from '../views/CourseView.vue'
import CourseDetailView from '../views/CourseDetailView.vue'
import AccountView from '../views/AccountView.vue'
import SingleCourse from '../views/SingleCourse.vue'
// import LoginView from '../views/LoginView.vue'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/',
    name: 'Home',
    component: HomeView
  },
  {
    path: '/about',
    name: 'about',
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: AboutView
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
    path: '/account',
    name: 'account',
    component: AccountView
  },
  {
    path: '/singlecourse',
    name: 'singlecourse',
    component: SingleCourse
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

export default router
