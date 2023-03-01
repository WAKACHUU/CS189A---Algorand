<!-- eslint-disable @typescript-eslint/no-var-requires -->
<!-- eslint-disable @typescript-eslint/no-var-requires -->
<template>
    <div class="dialog">
        <div class="loginPage">
            <h1>Login</h1>
            <el-form :model="form">
                <el-form-item label="user">
                    <el-input type="text" id="user" v-model="form.user" @blur="inputBlur('user',form.user)"></el-input>
                    <p>{{form.userError}}</p>
                </el-form-item>
                <el-form-item label="password">
                    <el-input type="password" id="password" v-model="form.password" @blur="inputBlur('password',form.password)"></el-input>
                    <p>{{form.passwordError}}</p>
                </el-form-item>
                <el-button type="primary" @click="submitForm()" v-bind:disabled="form.beDisabled">Login</el-button>
            </el-form>
        </div>
    </div>
</template>

<script lang="ts" setup>
import { ref} from 'vue'
import {useStore} from 'vuex';
const store=useStore()


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
    }else if(value==0){
      console.log("Email not exist or Password error")
    }
  })
}

</script>

<style scoped>
    html,body{
        margin: 0;
        padding: 0;
        position: relative;
    }
    .dialog{
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,.8);
    }
    .loginPage{
        position: absolute;
        top: 50%;
        left: 50%;
        margin-left: -175px;
        width: 350px;
        min-height: 300px;
        padding: 30px 20px 20px;
        border-radius: 8px;
        box-sizing: border-box;
        background-color: #fff;
    }
    .loginPage p{
        color: red;
        text-align: left;
    }
</style>
