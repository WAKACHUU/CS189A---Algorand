<template>
 <NFTCard :NFTInfo="NFTInfo"></NFTCard>
</template>

<script lang="ts" setup>    
import NFTCard from '@/components/NFTCard.vue'
import { ref } from 'vue'

const NFTInfo = ref({
    name: ref("NFT 1"),
    course: ref("CS189A"),
    comment: ref("This is a comment"),
    starLevel: ref(2),
    imgSrc: ref("https://shadow.elemecdn.com/app/element/hamburger.9cf7b091-55e9-11e9-a976-7f4d0b07eef6.png")
})
</script>

<style lang="less" scoped>

</style>
