import { createStore } from 'vuex'
import FirebaseOperations from '@/backend/firebase/firebase_operations.js'

export default createStore({
  
  state: {
    FirebaseOps: new FirebaseOperations()
  },
  getters: {
  },
  mutations: {
  },
  actions: {
  },
  modules: {
  }
})
