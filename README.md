# Dustin's Blog

Dustin's Blog is a platform I built to express my opinions/insights onto whatever I feel like writing about.

## Setup

After downloading the zip, run setup.sh, entering in your root passwoord when prompted, to install all of the requirements and create the database. The script relies on [npm](https://www.npmjs.com/get-npm) to install the requirements, so install it if you haven't already.
```bash
./setup.sh
```

## Usage

Before running the website, you'll need to edit the .env file created by setup.sh so that website can access the database. When you first open it, the file should contain the one line 
```bash
DB_PASS=[Your root password]
```
Fill in [Your root password]. 

The website currently runs on localhost port 3000. To run it, call the npm start script
```bash
npm start
```
and then open http://localhost:3000 on a web browser.

## Features

The website has three main features: storing/opening blog posts, "heart"-ing and commenting on posts, and sending inquiries through a form. 

To insert a new blog post into the database, run newpost.sh
```bash
./newpost.sh
```
And fill in the contents of the blog post when prompted.

To view inquiries sent through the website form, run viewinquiries.sh
```bash
./viewinquiries.sh
```

## Repository Structure

The repository file contains: 
* index.js, the main driver of the website
* dustinsblogdata.sql, the uploaded database of the website
* setup.sh, newpost.sh, and viewinquiries.sh, the shell scripts described above
* .gitignore, and README.md, standard Git auxillary files
* package.json and package-lock.json, containing all of the project's dependencies
* public, containing the CSS and the images used in the website
* views, containing the handlebars files that make up the website

## Project Contributors
* Dustin Wu (dustin_wu@brown.edu)
* That's it! (This was a solo track project) 

