# Dustin's Blog

Dustin's Blog is a platform I built to express my opinions/insights onto whatever I feel like writing about.

## Installation

After downloading the zip, use the package manager [npm](https://www.npmjs.com/get-npm) to install all of the requirements.
```bash
npm ci
```

## Usage

To load in the database, create a new database called dustinsblog, entering in your root password when prompted.
```bash
mysql -u root -p
CREATE DATABASE dustinsblog;
quit;
```
Next, dump the provided contents into it:
```bash
mysql -u root -p dustinsblog < dustinsblogdata.sql
```
Before running the website, you'll need to insert a .env file into the root directory so that the website can access the database. The file should contain the one line 
```bash
DB_PASS=[Your root password]
```

The website currently runs on localhost port 3000. To run it, call the npm start script
```bash
npm start
```
and then open http://localhost:3000 on a web browser.

## Features

The website has three main features: storing/opening blog posts, "heart"-ing and commenting on posts, and sending inquiries through a form. To insert a new blog post into the database, run the following commands
```bash
mysql -u root -p
USE dustinsblog;
INSERT INTO blogpost(title, thumbnail, blog_body) VALUES([your title], [name of thumbnail file], [your blog body])
```
where the file with [name of thumbnail file] is stored in /public/images.

## Repository Structure

The repository file contains: 
* index.js, the main driver of the website
* dustinsblogdata.sql, the uploaded database of the website
* .gitignore, and README.md, standard Git auxillary files
* package.json and package-lock.json, containing all of the project's dependencies
* public, containing the CSS and the images used in the website
* views, containing the html files for each of the website's pages

## Project Contributors
* Dustin Wu (dustin_wu@brown.edu)
* That's it! (This was a solo track project) 

