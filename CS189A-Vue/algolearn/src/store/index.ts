import { createStore } from 'vuex'
import FirebaseOperations from '@/backend/firebase/firebase_operations.js'
import AssetOperations from '@/backend/algorand/asset_operations.js'

export default createStore({
  
  state: {
    FirebaseOps: new FirebaseOperations(),
    AssetOps: new AssetOperations()
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
