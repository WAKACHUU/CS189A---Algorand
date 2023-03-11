<template>
    <el-card class="nft-card" :body-style="{ padding: '0px', height: '590px', width: '386px' }">
        <img
        :src="props.NFTInfo.imgSrc"
        class="image"
        />
        <div style="padding: 29px">
        <span class="nft-title">{{props.NFTInfo.name}}</span>
        <div class="bottom">
            <time class="course">{{ props.NFTInfo.course }}</time>
            <div>
            <StarLevel :star-level="props.NFTInfo.starLevel"></StarLevel>
            </div>
        </div>
        </div>
    </el-card>
  </template>
  
  <script lang="ts" setup>
  import { ref, defineProps } from 'vue'
  import  StarLevel  from '@/components/StarLevel.vue'
  
  const props = defineProps({
    NFTInfo: {
      type: Object,
      required: true
    }
  })

  
  </script>
  
  <style lang="less" scoped>
  .nft-card {
    width: 386px;
    height: 590px;
  }
  .nft-title {
    font-size: 24px;
    font-family: Futura;
    color: #2DB6BC;
    line-height: 34px;
  }
  .course {
    font-size: 14px;
    color: #999;
  }
  
  .bottom {
    margin-top: 13px;
    line-height: 12px;
    align-items: center;
  }
  
  .button {
    padding: 0;
    min-height: auto;
  }
  
  .image {
    width: 100%;
    display: block;
  }
  </style>
  