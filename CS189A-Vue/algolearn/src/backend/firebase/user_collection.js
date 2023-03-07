import { getDoc,doc,setDoc} from "firebase/firestore";

import {db} from "./init.js";

// utilize the user collection service to create or update a user list in the database

class UserCollection
{
    constructor()
    {
        //construct the default user collection data
        this.user_collection={
            name:"",
            email:"",
            address:"",
            passphrase: "",
            timestamp: "",
            role:0,
            courses: []
        };
    }

    async update()
    {
        //update the user collection data
        const docRef =doc(db,"login",this.user_collection.email);
        await setDoc(docRef, this.user_collection);
    }

    // async create()
    // {
    //     this.user_collection.timestamp=Timestamp.now();
    //     //create the user collection data
    //     await this.user_collection_service.create(this.user_collection);
    // }

    async read()
    {
        //read the user collection data
        const docRef =doc(db,"login",this.user_collection.email);
        const docSnap = await getDoc(docRef);
        if(docSnap.data()==undefined)
        {
            return 0;
        }
        else
        {
            this.user_collection=docSnap.data();
            return 1;
        }
    }
    
    async delete()
    {
        //delete the user collection data
        const docRef =doc(db,"login",this.user_collection.email);
        await deleteDoc(docRef);
    }
}

export default UserCollection;