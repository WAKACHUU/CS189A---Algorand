<template>
  <el-avatar size="large" shape="circle">
    <img src="@/assets/logo.png">
  </el-avatar>
  <div>
    <span>{{ username }} |</span>
    <span>{{ algoAcc }} | </span>
    <span>{{ useremail }}</span>
  </div>
  <div>
  </div>
  <el-tabs v-model="activeName" class="demo-tabs">
    <el-tab-pane label="My Wallet" name="mywallet">
      <el-table :data="tableData" style="width: 100%">
        <el-table-column label="Collection" width="210">
          <template #default="scope">
            <div style="display: flex; align-items: center">
              <el-avatar><img src="@/assets/logo.png"></el-avatar>
              <span style="margin-left: 10px">{{ scope.row.badgeName }}</span>
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="value" label="Value" width="100" />
        <el-table-column>
            <template #default="scope">
                <el-button type="text" @click="scope.row.isStarred = !scope.row.isStarred">
                    <el-icon>
                        <template v-if="scope.row.isStarred">
                            <StarFilled />
                        </template>
                        <template v-else>
                            <Star />
                        </template>
                    </el-icon>
                </el-button>
            </template>
        </el-table-column>
      </el-table>
    </el-tab-pane>
    <el-tab-pane label="Collection" name="collection">Collection</el-tab-pane>
    <el-tab-pane label="Create NFT" name="transfer">
      <ProfTransfer />
    </el-tab-pane>
  </el-tabs>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { Star, StarFilled } from '@element-plus/icons-vue'
import ProfTransfer from '@/components/ProfTransfer.vue'

const username = ref('username')
const algoAcc = ref('algoacc')
const useremail = ref('user@email.com')

// tab controller
const activeName = ref('mywallet')

const tableData = [
  {
    badgeName: 'lecture1 most active',
    value: '2.207',
    isStarred: true
  },
  {
    badgeName: 'lecture1 most active',
    value: '2.207',
    isStarred: true
  },
  {
    badgeName: 'lecture1 most active',
    value: '2.207',
    isStarred: true
  }
]

</script>

<style lang="less" scoped>
</style>
