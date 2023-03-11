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
        <el-scrollbar max-height="1000px" wrap-style="margin-top: 75px" @click="onClickCard">
            <CourseCard v-for="ci in courseInfo" :key="ci.courseId" :courseInfo="ci" @click.stop="onClickCard(ci.courseId)" />
        </el-scrollbar>
    </div>

</div>

</template>

<script lang="ts" setup>
import CourseCard from '@/components/CourseCard.vue'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useStore } from 'vuex'
import { getDoc } from "firebase/firestore";


const store = useStore()
const router = useRouter()

const currentUser = store.state.FirebaseOps.user

const username = ref(currentUser.user_collection.name)
const profilePicSrc = ref('http://img01.yohoboys.com/contentimg/2018/11/22/13/0187be5a52edcdc999f749b9e24c7815fb.jpg')
const userEmail = ref(currentUser.user_collection.email)

// all course info here
const courseInfo = ref([
  {
    courseId: 'CS189A',
    courseName: 'Capstone Project',
    courseNum: 7
  }
])

// for (let i = 0; i < currentUser.user_collection.courses.length; i++) {
//   // const course = currentUser.user_collection.courses[i]
//   // console.log("course: ", course)
//   const courses = await getDoc(currentUser.user_collection.courses[i]).then((doc) => {
//     if (doc.exists()) {
//       console.log("Document data:", doc.data());
//     } else {
//       // doc.data() will be undefined in this case
//       console.log("No such document!");
//     }
//   }).catch((error) => {
//     console.log("Error getting document:", error);
//   });
// }
for (let i = 0; i < currentUser.user_collection.courses.length; i++) {
  const courses = currentUser.read_class(i).then((doc : any) => {
    if (doc != undefined) {
      console.log("Document data:", doc);
    } else {
      // doc.data() will be undefined in this case
      console.log("No such document!");
    }
  }).catch((error : any) => {
    console.log("Error getting document:", error);
  }
  );
}

// console.log("course: ", course)


const onClickCard = (courseId: string) => {
  router.push({ path: `/course/${courseId}` })
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

</style>
