import { where, query, collection, getDocs } from "firebase/firestore"
import { getAuth, signInWithEmailAndPassword, createUserWithEmailAndPassword } from "firebase/auth";
import { doc, setDoc, Timestamp } from "firebase/firestore";

const auth = getAuth();
// sign in function
// return 1 if successfully signed in
// return 0 if the password is invalid
// return -1 if the email is not registered
export async function sign_in(db,email,password)  {
    // fetch the user from the database with the given email
    const q = query(collection(db, "login"), where("email", "==", email));
    const querySnapshot = await getDocs(q);
    console.log(querySnapshot.size);
    // if the user exists, check if the password matches
    if (querySnapshot.size > 0) {
        try {
            // if the email exist, try to use firebase authentication to sign in
            await signInWithEmailAndPassword(auth,email, password);
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
// return -4 if the email is in use or invalid
export async function sign_up(db,name,email,password,confirm_password) {
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
            await createUserWithEmailAndPassword(auth,email, password);
            const docData = {
                name: name,
                email: email,
                timestamp: Timestamp.now(),
            };
            await setDoc(doc(db, "login",email), docData);

            console.log("Successfully signed up!");
            return 1;
        }
        catch(error){
            if (error.code === 'auth/weak-password') {
                console.log('The password is too weak.');
                return -3;
            } else {
                console.log(error);
                return -4;
            }
        }
    }
}


export async function sign_out() {
    try{
        await auth.signOut();
        console.log("Successfully signed out!");
        return 1;
    }
    catch(error){
        console.log(error);
        return 0;
    }

}




// export default {sign_in, sign_up}
