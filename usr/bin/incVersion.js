#!/usr/bin/node

if(process.argv.length != 3) {
    console.log("SYNTAX: incVersion.js SEM_VER_VERSION");
    return;
}

var version = process.argv[2];

var isValidVersion = /^(\d+\.){0,2}(\d+)$/.test(version);

if(!isValidVersion) {
    console.error("'" + version + "' is not a valid semver version string");
    return;
}

var tokens = version.split(".");
if(tokens.length < 3) {

    for(i = tokens.length; i < 3; i++) {
        tokens.push(0);
    }
    version = tokens.join(".");
    console.log(version);
    return;
}
tokens[2] = Number(tokens[2]) + 1;
version = tokens.join(".");
console.log(version);


