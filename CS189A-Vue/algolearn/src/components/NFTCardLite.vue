<template>
    <div class="nft-card-lite">
        <div class="nft-img">
            <el-image style="width: 231px; height: 240px" :src="nft.image"></el-image>
        </div>
        <div class="nft-info">
            <span style="font-size: 24px; font-family: Futura; ">
                {{ nft.name }}
            </span>
        </div>
    </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue'

const nft = {
    name: 'NFT 1',
    course: 'CS189A',
    image: 'http://img01.yohoboys.com/contentimg/2018/11/22/13/0187be5a52edcdc999f749b9e24c7815fb.jpg'
}


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
