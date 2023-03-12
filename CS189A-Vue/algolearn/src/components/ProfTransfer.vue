<template>
    <el-card class="create-card">
        <el-form :model="nftForm" label-width="200px" size="large">
            <el-form-item label="NFT Name">
                <el-input 
                  maxlength="200"
                  v-model="nftForm.name" 
                  :input-style="{ height: '56px', fontFamily: 'Futura', fontSize: '24px'}"
                />
            </el-form-item>
            <el-form-item label="Course">
                <el-select v-model="nftForm.course" placeholder="Select a course">
                    <el-option v-for="option in options" :key="option.label" :label="option.label" :value="option.value" />
                </el-select>
            </el-form-item>
            <el-form-item label="Level">
                <el-select v-model="nftForm.starLevel" placeholder="Select a level for your NFT">
                    <el-option v-for="option in starLevelOptions" :key="option.label" :label="option.label" :value="option.value" />
                </el-select>
            </el-form-item>
            <el-form-item label="Comment">
                <el-input 
                  v-model="nftForm.comment" 
                  max-length="500" 
                  type="textarea" 
                  :input-style="{ height: '110px', fontFamily: 'Futura', fontSize: '24px'}"
                />
            </el-form-item>
            <!-- Badge Image Upload -->
            <el-form-item label="Badge Image">
                <el-upload
                    v-model:file-list="fileList"
                    class="upload-demo"
                    action="https://run.mocky.io/v3/9d059bf9-4660-45f2-925d-ce80ad6c4d15"
                    :on-preview="handlePreview"
                    :on-remove="handleRemove"
                    list-type="picture"
                >
                    <el-button type="primary">Click to upload</el-button>
                    <template #tip>
                    <div class="el-upload__tip">
                        jpg/png files with a size less than 500KB.
                    </div>
                    </template>
                </el-upload>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="onSubmit">Create</el-button>
                <el-button>Cancel</el-button>
            </el-form-item>
        </el-form>
    </el-card>
</template>

<script lang="ts" setup>
import { ref, reactive } from 'vue'
import type { UploadProps, UploadUserFile } from 'element-plus'

const fileList = ref<UploadUserFile[]>([])

const handleRemove: UploadProps['onRemove'] = (uploadFile, uploadFiles) => {
  console.log(uploadFile, uploadFiles)
}

const handlePreview: UploadProps['onPreview'] = (file) => {
  console.log(file)
}
const options = [
  {
    value: 'zone1',
    label: 'Zone 1'
  },
  {
    value: 'zone2',
    label: 'Zone 2'
  }
]

const starLevelOptions = ref([
  {
    value: '1',
    label: '1'
  },
  {
    value: '2',
    label: '2'
  },
  {
    value: '3',
    label: '3'
  },
  {
    value: '4',
    label: '4'
  },
  {
    value: '5',
    label: '5'
  }
])

// do not use same name with ref
const nftForm = reactive({
  name: '',
  starLevel: 0,
  course: '',
  comment: ''
})

const onSubmit = () => {
  console.log('submit!')
}
</script>

<style lang="less" scoped>
.create-card {
  width: 94.7%; 
}
/deep/ .el-form-item__label {
  font-size: 24px!important;
  font-family: Futura;
  margin: 10px;
}
.avatar-uploader .avatar {
  width: 178px;
  height: 178px;
  display: block;
}

.el-select.el-select--large  {
  width: 500px!important;
  
  /deep/ .el-input.el-input--large {
    font-size: 24px!important;
    height: 56px!important;
  }
}
</style>

<style lang="less">
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  text-align: center;
}

</style>
