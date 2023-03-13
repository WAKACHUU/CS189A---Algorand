<template>
    <el-card class="create-card">
        <el-form :model="nftForm" label-width="200px" size="large">
            <el-form-item label="NFT Name">
                <el-input 
                  maxlength="200"
                  v-model="nftForm.name"
                  placeholder="Enter the name of NFT here" 
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
            <el-form-item label="Label">
              <el-input 
                  v-model="nftForm.genre" 
                  max-length="500" 
                  type="text" 
                  placeholder="Enter a label for your NFT here"
                  :input-style="{ height: '56px', fontFamily: 'Futura', fontSize: '24px'}"
              />
            </el-form-item>
            <el-form-item label="Comment">
                <el-input 
                  v-model="nftForm.comment" 
                  max-length="500" 
                  type="textarea" 
                  placeholder="Comment for your students here"
                  :input-style="{ height: '110px', fontFamily: 'Futura', fontSize: '24px'}"
                />
            </el-form-item>
            <!-- Badge Image Upload -->
            <el-form-item label="Badge Image">
              <el-input 
                  v-model="nftForm.imgSrc" 
                  max-length="500" 
                  type="text" 
                  placeholder="Enter an image Url here"
                  :input-style="{ height: '56px', fontFamily: 'Futura', fontSize: '24px'}"
              />
            </el-form-item>
            <el-form-item>
                <div style="margin-left: 15px">
                  <el-button type="primary" class="create-button" @click="onSubmit">Create</el-button>
                </div>
            </el-form-item>
        </el-form>
    </el-card>
</template>

<script lang="ts" setup>
import { ref, reactive } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import type { UploadProps, UploadUserFile } from 'element-plus'

const store = useStore()
const router = useRouter()

const thisUser = store.state.FirebaseOps.user
const thisAlgo=store.state.AlgoOps
const seed = thisUser.user_collection.passphrase
const address=thisUser.user_collection.address

const fileList = ref<UploadUserFile[]>([])

const handleRemove: UploadProps['onRemove'] = (uploadFile, uploadFiles) => {
  console.log(uploadFile, uploadFiles)
}

const handlePreview: UploadProps['onPreview'] = (file) => {
  console.log(file)
}
const options = ref([
])

console.log(thisUser.user_collection.courses.length)

for (let i = 0; i < thisUser.user_collection.courses.length; i++) {
    console.log(thisUser.user_collection.courses[i])

    thisUser.read_class(i).then((doc : any) => {
      if (doc == undefined) {
        console.log(1)
        options.value.push({
          value:"No course Enrolled",
          label:"No course Enrolled"
        })
      }
      else{
        options.value.push({
          value:doc.courseId,
          label:doc.courseId
        })
      }
  }).catch((error : any) => {
    console.log("Error getting document:", error);
  }
  );
}




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
  genre: '',
  course: '',
  comment: '',
  imgSrc: '',
})

const onSubmit = () => {
  console.log("//")
  try{
    thisAlgo.create_asset(seed,nftForm.course,nftForm.name,nftForm.imgSrc,nftForm.comment,nftForm.genre,nftForm.starLevel)
  }
  catch(e){
    console.error(e)
  }
}

</script>

<style lang="less" scoped>
.el-button.create-button {
    width: 200px;
    height: 80px;
    font-size: 30px;
    font-family: Futura;
}

.el-button.create-button:focus {
    border-color: #abe1e4;
    background-color: #abe1e4;
}

.create-card {
  width: 94.7%; 
  height: 650px;
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
