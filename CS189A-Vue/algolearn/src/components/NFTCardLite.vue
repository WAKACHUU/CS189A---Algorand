<template>
    <div class="nft-card-lite">
        <div class="nft-img">
            <el-image style="width: 231px; height: 240px" :src="props.nftInfo.imgSrc"></el-image>
        </div>
        <div class="nft-info">
            <div style="width:100%;">
                <span style="font-size: 14px; font-family: Futura; color: #999; text-transform: uppercase; letter-spacing: 4px;">
                    {{ props.nftInfo.genre }}
                </span>
            </div>
            <div style="width:100%; margin-top: 16px;">
                <span style="font-size: 30px; font-family: Futura; ">
                    {{ props.nftInfo.name }}
                </span>
            </div>
            <div style="width:100%; margin-top: 74px">
                <StarLevel :starLevel="props.nftInfo.starLevel"></StarLevel>
            </div>

        </div>
    </div>
</template>

<script lang="ts" setup>
import { ref, defineProps } from 'vue'
import StarLevel from '@/components/StarLevel.vue'

const props = defineProps({
    nftInfo: {
        type: Object,
        required: true
    }
})


</script>

<style lang="less" scoped>
.nft-card-lite {
    width: 540px;
    height: 288px;
    border: 1px solid var(--el-border-color);
}
.nft-img {
    width: 231px;
    height: 240px;
    float: left;
    margin: 24px 0px 24px 24px;
}
.nft-info {
    width: 231px;
    height: 240px;
    float: right;
    margin: 24px 24px 24px 0px;
    //border: 1px solid var(--el-border-color);
}
</style>
