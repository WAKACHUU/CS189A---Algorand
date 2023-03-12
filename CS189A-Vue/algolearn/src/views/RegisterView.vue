<!-- eslint-disable @typescript-eslint/no-var-requires -->
<!-- eslint-disable @typescript-eslint/no-var-requires -->
<template>
    <div class="dialog">
        <div class="RegisterPage">
            <h1>Register</h1>
            <el-form :model="form">
              <el-form-item label="Email">
                  <el-input type="text" id="email" v-model="form.email" @blur="inputBlur('email',form.email)"></el-input>
                  <p>{{form.emailError}}</p>
              </el-form-item>
                <el-form-item label="Username">
                    <el-input type="text" id="username" v-model="form.username" @blur="inputBlur('username',form.username)"></el-input>
                    <p>{{form.usernameError}}</p>
                </el-form-item>
                <el-form-item label="Sign Up As">
                  <el-radio-group v-model="form.role">
                    <el-radio :label="1">Professor</el-radio>  
                    <el-radio :label="0">Student</el-radio>  
                  </el-radio-group>
                </el-form-item>
                <el-form-item label="Password">
                    <el-input type="password" id="password" v-model="form.password" @blur="inputBlur('password',form.password)"></el-input>
                    <p>{{form.passwordError}}</p>
                </el-form-item>
                <el-form-item label="Confirm Password">
                    <el-input type="comfirmPassword" id="comfirmPassword" v-model="form.confirmPassword" @blur="inputBlur('confirmPassword',form.confirmPassword)"></el-input>
                    <p>{{form.confirmPasswordError}}</p>
                </el-form-item>
                <el-button type="primary" @click="submitForm()" v-bind:disabled="form.beDisabled">Register</el-button>
            </el-form>
        </div>
    </div>
</template>

<script lang="ts" setup>
import {ref} from 'vue'
import {useStore} from 'vuex';  
const store=useStore()


const form = ref({
  email: '',
  username: '',
  password: '',
  confirmPassword: '',
  role: '',
  usernameError: '',
  emailError: '',
  passwordError: '',
  confirmPasswordError: '',
  beDisabled: true
})

const inputBlur = (errorItem : string, inputContent : string) => {
  if (errorItem === 'username') {
    if (inputContent === '') {
      form.value.usernameError = 'Username cannot be empty'
    } else {
      form.value.usernameError = ''
    }
  } 
  else if (errorItem === 'email') {
    if (inputContent === '') {
      form.value.emailError = 'Email address cannot be empty'
    } else {
      form.value.emailError = ''
    }
  } else if (errorItem === 'password') {
    if (inputContent === '') {
      form.value.passwordError = 'Password cannot be empty'
    } else {
      form.value.passwordError = ''
    }
  }
  else if (errorItem === 'confirmPassword') {
    if (inputContent === '') {
      form.value.confirmPasswordError = 'Please confirm your password'
    }
    else if(inputContent !== form.value.password){
      form.value.confirmPasswordError = 'Password does not match'
    }
    else {
      form.value.confirmPasswordError = ''
    }
  }
  // 对于按钮的状态进行修改
  if (form.value.email !== '' && form.value.username !== '' && form.value.password !== '' && form.value.confirmPassword !== '') {
    form.value.beDisabled = false
  } else {
    form.value.beDisabled = true
  }
}

const submitForm = () => {
  if (form.value.confirmPasswordError == 'Password does not match'){
     console.log("Password does not match")
  
    }
  else{  
    console.log(form.value)
    var Register_message;

    // if student
    if(form.value.role=="0")
    {
      Register_message=store.state.FirebaseOps.sign_up(form.value.username,form.value.email,form.value.password,form.value.confirmPassword)
    }
    // if professor
    else{
      Register_message=store.state.FirebaseOps.prof_sign_up(form.value.username,form.value.email,form.value.password,form.value.confirmPassword)
    }
    // const Register_message=store.state.FirebaseOps.sign_up(form.value.username,form.value.email,form.value.password,form.value.confirmPassword)
    // console.log(Register_message)
    Register_message.then((value: unknown)=>{
      if(value==1){
        console.log("Register success")
      }else if(value==0){
        console.log("Email already exist")
      }
      else if (value==-1)
      {
        console.log("Email does not end with @ucsb.edu")
      }
      else if (value==-2)
      {
        console.log("Email already exists")
      }
      else if (value==-3)
      {
        console.log("Password is too short")
      }
      else if (value==-4)
      {
        console.log("Email is not valid")
      }
    })
}
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
    .RegisterPage{
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
    .RegisterPage p{
        color: red;
        text-align: left;
    }
</style>
