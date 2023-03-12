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
            <div style="margin-top: 50px">
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
    letter-spacing: 4px;
    text-transform: uppercase;
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

  .el-card.is-always-shadow {
    /* offset-x | offset-y | blur-radius | spread-radius | color */
    box-shadow: 1px 8px 8px 2px RGBA(0, 0, 0, 0.5);
  }
  </style>
  