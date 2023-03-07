import { createStore } from 'vuex'
import FirebaseOperations from '@/backend/firebase/firebase_operations.js'
import AlgoOperations from '@/backend/algorand/algo_operations.js'

export default createStore({
  
  state: {
    FirebaseOps: new FirebaseOperations(),
    AlgoOps: new AlgoOperations()
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
