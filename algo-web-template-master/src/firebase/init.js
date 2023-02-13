// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import { getFirestore } from "firebase/firestore";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDIJrC7qO3JoxZ7aJfsgegmxSqNEqT7n64",
  authDomain: "cs189algo.firebaseapp.com",
  databaseURL: "https://cs189algo-default-rtdb.firebaseio.com",
  projectId: "cs189algo",
  storageBucket: "cs189algo.appspot.com",
  messagingSenderId: "390074138238",
  appId: "1:390074138238:web:dd8e07fea2f8276c28622f",
  measurementId: "G-HJBZRVJ852"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

// init firestore service
const db = getFirestore()
export default db