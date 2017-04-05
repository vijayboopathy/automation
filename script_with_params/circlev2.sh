#!/bin/bash

echo "Usage: $0 [-v <github/bitbucket>] [-u <username>] [-p <project name>] [-t <API token>] [-d <deployment dir>]"

usage() { echo "Usage: $0 [-v <github/bitbucket>] [-u <username>] [-p <project name>] [-t <API token>] [-d <deployment dir>]" 1>&2; exit 1; }

while getopts ":v:u:p:t:d:" o; do
    case "${o}" in
        v)
            v=${OPTARG}
            ((v == "github" || v == "bitbucket" )) || usage
            ;;
        u)
            u=${OPTARG}
            ;;
        p)
            p=${OPTARG}
            ;;
        t)
            t=${OPTARG}
            ;;
        d)
            d=${OPTARG}
            ;;
    esac
done

uri=https://circleci.com/api/v1.1/project

base_uri=$uri/${v}/${u}/${p}/latest/artifacts?circle-token=${t}

# Define get_art function. Delete residue files at the end

function get_art
{
echo "Downloading Artifact..."
echo $base_uri
sleep 3;
cd ${d}
curl $base_uri | grep -o 'https://[^"]*' > artifacts.txt
xargs <artifacts.txt  wget
rm -f artifacts.txt
}


get_art
