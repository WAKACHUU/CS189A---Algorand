import UserCollectionService from "./user_collection_service";
// import { doc, setDoc, Timestamp } from "firebase/firestore";

// import {db} from "./init.js";

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
        };
        this.user_collection_service = new UserCollectionService();
    }

    async update()
    {
        //update the user collection data
        await this.user_collection_service.update(this.user_collection);
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
        const data=this.user_collection_service.read(this.user_collection);
        data.then((value) => {
            if(value==undefined)
            {
                // throw new Error("The email is not registered");
                return 0;
            }
            this.user_collection=value;
            return 1;
        });
    }
    
    async delete()
    {
        //delete the user collection data
        await this.user_collection_service.delete(this.user_collection);
    }

    

}

export default UserCollection;