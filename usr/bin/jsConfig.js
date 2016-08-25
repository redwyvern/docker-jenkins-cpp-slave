#!/usr/bin/node

if(process.argv.length < 4) {
    console.log("SYNTAX: bowerUpdate.js BOWER_JSON_FILE PATH [VALUE_TO_SET]");
    return;
}

var fileName = process.argv[2];
var jsonPath = process.argv[3];
if(process.argv.length === 5) {
    var jsonValue = process.argv[4];
}

var fs = require('fs');
var jsonObject = JSON.parse(fs.readFileSync(fileName, 'utf8'));

if(jsonValue !== undefined) {
    eval('jsonObject.' + jsonPath + ' = jsonValue');
    fs.writeFile(fileName, JSON.stringify(jsonObject, null, 2) , 'utf-8');
    return;
}

console.log(eval('jsonObject.' + jsonPath));


