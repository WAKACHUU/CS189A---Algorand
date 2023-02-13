import { where, query, collection, getDocs } from "firebase/firestore"
import db from './firebase/init.js'


// sign in function
// return 1 if successfully signed in
// return 0 if the password is invalid
// return -1 if the email is not registered
async function sign_in(email,password) {
    // fetch the user from the database with the given email
    const q = query(collection(db, "login"), where("email", "==", email));
    const querySnapshot = await getDocs(q);
    // if the user exists, check if the password matches
    if (querySnapshot.size > 0) {
        try {
            // if the email exist, try to use firebase authentication to sign in
            await firebase.auth().signInWithEmailAndPassword(email, password);
            console.log("Successfully signed in!");
            return 1;

          } catch (error) {
            console.error("The password is invalid.", error);
            return 0;
          }
    } else 
    {
        console.error("The email is not registered");
        return -1;
    }
}


// sign up function
// return 1 if successfully signed up
// return 0 if the email is already registered
// return -1 if the email address does not end with @ucsb.edu
// return -2 if the password and confirm password do not match
// return -3 if the password is too weak
async function sign_up(name,email,password,confirm_password) {
    // fetch the user from the database with the given email
    const q = query(collection(db, "login"), where("email", "==", email));
    const querySnapshot = await getDocs(q);
    // if the user exists, check if the password matches
    if (querySnapshot.size > 0) {
        console.error("The email is already registered");
        return 0;
    } 
    // if the email address does not end with @ucsb.edu, return -2
    else if(!email.endsWith("@ucsb.edu"))
    {
        console.error("The email address must end with @ucsb.edu");
        return -1;
    }
    else if(password!= confirm_password)
    {
        console.error("The password and confirm password do not match");
        return -2;
    }
    else
    {   
        try{
            // if the email does not exist, try to use firebase authentication to sign up
            await firebase.auth().createUserWithEmailAndPassword(email, password);
            collection(db, "login").add({name: name, email: email})

            console.log("Successfully signed up!");
            return 1;
        }
        catch(error){
            if (error.code === 'auth/weak-password') {
                console.log('The password is too weak.');
                return -3;
            } else {
              console.log(error);
            }
        }
    }
}

export default {sign_in, sign_up}
