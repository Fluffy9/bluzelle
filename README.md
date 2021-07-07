# bluzelle-action

A Github Action for Bluzelle Web Hosting

## Why?

Host your blog or any other website on Bluzelle. This allows for censorship resistant web hosting. A Github Action in particular functions as a plugin for the many [Static Site Generators (SSG)](https://jamstack.org/generators/) that use github for source control. Hugo is the focus of these examples but Jekyll and any other SSG could be used. 

You can push new posts to your blog on github, and have that trigger this action which will update your website on Bluzelle in seconds. Everything is perfectly up to date, and censorship resistant. 

## How? 

There are an unlimited amount of ways you can configure your build. Different triggers, run it on a schedule, etc. Check out the docs for the (details)[https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions]

### Instructions

1. Have a blog in a github repository. I made an example repo for Hugo [here](https://github.com/Fluffy9/hugo-demo)
2. Click the "Actions" tab on your github repository at the top of the website
![actions-tab](https://docs.github.com/assets/images/help/repository/actions-tab.png)
4. Click "Set up a workflow yourself" and copy and paste the example shown below into the text box.

```
# Generate a hugo static website and upload it to bluzelle
name: Hugo-Bluzelle

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Website
      uses: actions/checkout@v2
      with:
        fetch-depth: 0
        path: site
    
    - name: Hugo
      uses: klakegg/actions-hugo@1.0.0
      with: 
        source: ./site

    - name: Bluzelle
      uses: fluffy9/bluzelle-action@v1
      with: 
        UUID: 'website'
        mnemonic: ${{ secrets.MNEMONIC }}
```
```
# Generate a Jekyll static website and upload it to bluzelle
# Note that the Jekyll build outputs to the _site folder. An extra step is needed to make a ./site/public directory and move the finished files there

name: Jekyll-Bluzelle

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Website
      uses: actions/checkout@v2
      with:
        fetch-depth: 0
    
    - name: Jekyll
      uses: jerryjvl/jekyll-build-action@v1
    
    - run: |
        mkdir ./site
        mkdir ./site/public
        cp -r _site/. ./site/public
    
    - name: Bluzelle
      uses: fluffy9/bluzelle-action@v1
      with: 
        UUID: 'website'
        mnemonic: ${{ secrets.MNEMONIC }}
```


6. You may use parameters to change the UUID of your site, or the wallet mnemonic to your own. 
7. For security purposes, you may want to add your mnemonic as a repository secret (as shown in the example). If not, you can either fill in your seed for this field or remove the field to use the default seed. More information on encrypted secrets [here](https://docs.github.com/en/actions/reference/encrypted-secrets)
![repository secrets](https://docs.github.com/assets/images/help/settings/actions-org-secrets-list.png)
9. Commit your new workflow and you're done. Your files should upload on the next push.
10. Your website will be available at https://client.sentry.testnet.private.bluzelle.com:1317/crud/raw/[UUID]/[file]. If you've not set any settings, it will be available at https://client.sentry.testnet.private.bluzelle.com:1317/crud/raw/my-sitex/index.html using the default parameters


> ## IMPORTANT NOTE: Regardless of the SSG you use, your build must output the final HTML files into a folder at ./site/public. You may also add extra steps to the workflow to make sure that those files end up there. This is what will be uploaded. 

### Working Example

Having difficulties? Fork this repo to for a working hugo site and workflow. 
https://github.com/Fluffy9/hugo-demo

## Issues 

Bluzelle website endpoint does not seem to work well with folders. If your website contains HTML files nested in folders, it will still upload but the webserver will not serve them for whatever reason
