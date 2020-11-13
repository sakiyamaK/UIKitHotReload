const fs = require('fs');
const admin = require("firebase-admin");
const { database } = require('firebase-admin');

// JSONのパスを取得する
if (process.argv.length < 5) {
    console.log('error');
    process.exit(0);
}

//set path/to/servicekey.json
const service_key =  process.argv[3]
//set databse_url
const database_url =  process.argv[4]

const path = process.argv[2];
const arr = path.split("/").reverse();

//viewsとファイル名.jsonを取得する
if (arr.length < 2) {
    console.log('error');
    process.exit(0);
}
let doc_name = arr[0].split(".")[0]
let col_name = arr[1]

//jsonをパースする
let raw_data = fs.readFileSync(path);
let json_data = JSON.parse(raw_data);


//firebase-adminの設定
const serviceAccount = require(service_key);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: database_url
});

//firestoreを取得
const db = admin.firestore();

//更新
db.collection(col_name).doc(doc_name).set(json_data).then(function (docRef) {
  console.log("Document written with ID: ", docRef.id);
}, function(err){
    console.log(err);
});


