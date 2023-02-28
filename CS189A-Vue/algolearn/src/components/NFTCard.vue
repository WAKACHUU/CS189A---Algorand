<template>

<el-card class="nft-card" :body-style="{ padding: '0px', height: '120px' }">
    <div class="">
        <img src="@/assets/logo.png">
    </div>
    <div class="card-right">
        <div>
            <span>lecture1 attendance</span>
        </div>
        <div>

        </div>
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
.nft-card {
    width: 45%;
    height: 288px;
    display: flex;
    justify-content: flex-start;
}
.card-right {

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
