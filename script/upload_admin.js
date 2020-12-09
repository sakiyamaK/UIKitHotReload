const fs = require('fs');
const admin = require("firebase-admin");
const { database } = require('firebase-admin');
 
// JSONのパスを取得する
if (process.argv.length < 5) {
    console.log('error 1');
    process.exit(0);
}

//set path/to/servicekey.json
const service_key = process.argv[3]
//set databse_url
const database_url = process.argv[4]

const path = process.argv[2];
const arr = path.split("/").reverse();
const exts = path.split(".").reverse();

//viewsとファイル名.(json/yaml/yml)を取得する
if (arr.length < 2 || exts.length < 2) {
    console.log('error 2');
    process.exit(0);
}
let doc_name = arr[0].split(".")[0]
let col_name = arr[1]

//ファイル拡張子
let ext = exts[0]
var set_data = null;
if (ext == "json") {
  let raw_data = fs.readFileSync(path);
  set_data = JSON.parse(raw_data);
} else if (ext == "yaml" || ext === "yml"){
  const yaml = require('js-yaml');
  let raw_data = fs.readFileSync(path);
  set_data = yaml.safeLoad(raw_data);
} else {
    console.log('error 3');
    process.exit(0);
}

//firebase-adminの設定
const serviceAccount = require(service_key);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: database_url
});

//firestoreを取得
const db = admin.firestore();

//更新
db.collection(col_name).doc(doc_name).set(set_data).then(function (docRef) {
  console.log("Document written with ID: ", docRef.id);
}, function(err){
    console.log(err);
});


