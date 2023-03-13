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
          <el-form :model="form">
            <el-form-item label="Email">
                <el-input type="text" id="email" 
                  v-model="form.email" 
                  @blur="inputBlur('email',form.email)"
                  :input-style="{ height: '56px', fontFamily: 'Futura', fontSize: '24px'}"
                ></el-input>
                <p>{{form.emailError}}</p>
            </el-form-item>
              <el-form-item label="Username">
                  <el-input type="text" id="username" 
                    v-model="form.username" 
                    @blur="inputBlur('username',form.username)"
                    :input-style="{ height: '56px', fontFamily: 'Futura', fontSize: '24px'}"
                  ></el-input>
                  <p>{{form.usernameError}}</p>
              </el-form-item>
              <el-form-item label="Sign Up As">
                <el-radio-group v-model="form.role">
                  <el-radio :label="1">Professor</el-radio>  
                  <el-radio :label="0">Student</el-radio>  
                </el-radio-group>
              </el-form-item>
              <el-form-item label="Password">
                  <el-input 
                    type="password" id="password" 
                    v-model="form.password" 
                    @blur="inputBlur('password',form.password)"
                    :input-style="{ height: '56px', fontFamily: 'Futura', fontSize: '24px'}"
                  ></el-input>
                  <p>{{form.passwordError}}</p>
              </el-form-item>
              <el-form-item label="Confirm Password">
                  <el-input type="password" id="comfirmPassword" 
                    v-model="form.confirmPassword" 
                    @blur="inputBlur('confirmPassword',form.confirmPassword)"
                    :input-style="{ height: '56px', fontFamily: 'Futura', fontSize: '24px'}"
                  ></el-input>
                  <p>{{form.confirmPasswordError}}</p>
              </el-form-item>
              <div style="width: 100%; display: flex; justify-content: center;">
                <el-button class="create-button" type="primary" @click="submitForm()" v-bind:disabled="form.beDisabled">Register</el-button>
              </div>           
          </el-form>
        </el-card>
      </div>
    </div>
</template>

<script lang="ts" setup>
import {ref} from 'vue'
import {useStore} from 'vuex';  
import {useRouter} from 'vue-router'

const store=useStore()
const router=useRouter()

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
      router.push('/login')
    }
    // if professor
    else{
      Register_message=store.state.FirebaseOps.prof_sign_up(form.value.username,form.value.email,form.value.password,form.value.confirmPassword)
      router.push('/login')
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

<style lang="less" scoped>
.login-card {
  margin: auto;
  width: 800px;
  height: 660px;
  padding-top: 80px;
}

/deep/ .el-radio__label {
  font-size: 24px;
  font-family: Futura;
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
