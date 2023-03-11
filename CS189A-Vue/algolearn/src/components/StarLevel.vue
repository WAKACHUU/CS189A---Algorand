<template>
    <div class="star-level">
        <el-icon class="el-icon" :size="34">
            <StarFilled v-for="(item, index) in props.starLevel" :key="index"/>
            <Star v-for="(item, index) in 5 - props.starLevel" :key="index"/>
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
    font-size: 34px;
}
.el-icon {
    height: 3em;
    width: 3em;
    color: #F2CB51;
}
</style>