#!/bin/sh -l

mv ./site/public /bluzelle-upload/site
cd /bluzelle-upload
npm run upload-files
