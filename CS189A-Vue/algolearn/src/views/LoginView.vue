<!-- eslint-disable @typescript-eslint/no-var-requires -->
<!-- eslint-disable @typescript-eslint/no-var-requires -->
<template>
    <div class="dialog">
      <div style="position: fixed; top:20px; left:20px;">
        <el-image style="width:273px;height:74px;" src="https://www.algorand.com/assets/media-kit/logos/full/png/algorand_full_logo_black.png"></el-image>
      </div>
      <div>
        <div style="width: 100%; display:flex; justify-content: center;">
            <span style="font-size: 72px; font-family: Futura; margin-bottom: 30px;;">Welcome to AlgoLearn</span>
        </div>
        <el-card class="login-card">
          <el-form :model="form" label-width="100px" size="large">
              <el-form-item label="Account">
                  <el-input 
                    type="text" 
                    id="user" 
                    v-model="form.user" 
                    @blur="inputBlur('user',form.user)"
                    :input-style="{ height: '56px', fontFamily: 'Futura', fontSize: '24px'}"
                  ></el-input>
                  <p>{{form.userError}}</p>
              </el-form-item>
              <el-form-item label="Password">
                  <el-input 
                    type="password" 
                    id="password" 
                    v-model="form.password" 
                    @blur="inputBlur('password',form.password)"
                    :input-style="{ height: '56px', fontFamily: 'Futura', fontSize: '24px'}"
                  ></el-input>
                  <p>{{form.passwordError}}</p>
              </el-form-item>
              <div style="width: 100%; display: flex; justify-content: center;">
                <el-button type="primary" class="create-button" @click="submitForm()" v-bind:disabled="form.beDisabled">Login</el-button>               
              </div>     
              <div style="width: 100%; display: flex; justify-content: center;">
                <el-button class="register-link" link type="primary" @click="goToRegister()">No account? Register here!</el-button>
              </div>                  
          </el-form>
        </el-card>
      </div>
    </div>
</template>

<script lang="ts" setup>
import { ref} from 'vue'
import {useStore} from 'vuex';
import { useRouter } from 'vue-router'
const router = useRouter()
const store = useStore()


const form = ref({
  user: '',
  password: '',
  userError: '',
  passwordError: '',
  beDisabled: true
})

const inputBlur = (errorItem : string, inputContent : string) => {
  if (errorItem === 'user') {
    if (inputContent === '') {
      form.value.userError = 'User name cannot be empty'
    } else {
      form.value.userError = ''
    }
  } else if (errorItem === 'password') {
    if (inputContent === '') {
      form.value.passwordError = 'Password cannot be empty'
    } else {
      form.value.passwordError = ''
    }
  }
  // 对于按钮的状态进行修改
  if (form.value.user !== '' && form.value.password !== '') {
    form.value.beDisabled = false
  } else {
    form.value.beDisabled = true
  }
}

const submitForm = () => { 
  const login_message=store.state.FirebaseOps.sign_in(form.value.user,form.value.password)
  // console.log(login_message)
  login_message.then((value: unknown)=>{
    if(value==1){
      console.log("login success")
      // 跳转到主页
      router.push({path: '/'})

    }else if(value==0){
      console.log("Email not exist or Password error")
    }
  })
}

const goToRegister = () => {
  router.push({path: '/register'})
}

</script>

<style lang="less" scoped>
.login-card {
  margin: auto;
  width: 800px;
  height: 520px;
  padding-top: 100px;
}

.el-button.create-button {
    width: 200px;
    height: 80px;
    font-size: 30px;
    font-family: Futura;
    background-color: #2DB6BC;
}

.el-button.create-button:focus {
    border-color: #abe1e4;
    background-color: #abe1e4;
}
.register-link {
    font-size: 16px;
    font-family: Futura;
}
.dialog{
    width: 100%;
    height: 100vh;
    background: white;
    display: flex;
    justify-content: center;
    align-items: center;
}
.loginPage{
    width: 100%;
    min-height: 300px;
    padding: 30px 20px 20px;
    box-sizing: border-box;
    background-color: #fff;
}

p{
    color: red;
    text-align: left;
    margin: 0;
}

/deep/ .el-form-item__label {
  font-size: 24px!important;
  font-family: Futura;
  margin: 10px;
}

/deep/ .el-form-item__content {
  width: 580px!important;
}

.el-form-item.el-form-item--large {
  margin-bottom: 70px;
}
    
</style>
