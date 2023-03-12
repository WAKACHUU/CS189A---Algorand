<template>
    <div class="star-level">
        <el-icon v-for="(item, index) in props.starLevel" :key="index" :size="34">
            <StarFilled />
        </el-icon>
        <el-icon v-for="(item, index) in 5 - props.starLevel" :key="index" :size="34">
            <Star />
        </el-icon>
    </div>
</template>

<script lang="ts" setup>
import { ref, defineProps } from 'vue'
import { Star, StarFilled } from '@element-plus/icons-vue';

const props = defineProps({
    starLevel: {
        type: Number,
        required: true
    }
})

</script>

<style lang="less" scoped>
.star-level {
    width: 220px;
}
.el-icon {
    height: 34px!important;
    width: 34px!important;
}
svg {
    height: 34px!important;
    width: 34px!important;
    color: #F2CB51;
}
</style>