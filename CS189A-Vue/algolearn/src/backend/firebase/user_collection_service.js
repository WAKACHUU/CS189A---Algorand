import { db} from "./init.js";
import { collection, deleteDoc } from "firebase/firestore"
import { doc, setDoc, getDoc } from "firebase/firestore";
class UserCollectionService {
    constructor() {
        this.collection = collection(db,"login");
    }

    // async create(data) {
    //     const docRef = await this.collection.add(user);

    //     return docRef.id;
    // }

    async read(data) {
        const docRef =doc(db,"login",data.email);
        const docSnap = await getDoc(docRef);
        // console.log(docSnap.data());
        return docSnap.data();
    }

    async update(data) {
        const docRef =doc(db,"login",data.email);
        await setDoc(docRef, data);
    }

    async delete(data) {
        const docRef =doc(db,"login",data.email);
        await deleteDoc(docRef);
    }
}


export default UserCollectionService;