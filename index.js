const express = require('express');
const session = require('express-session');
const app = express();
const port = 3000;
const mysql = require('mysql');
const bodyParser = require('body-parser');

// set up dotenv
require('dotenv').config()

// set up handlebars templating engine
const handlebars = require('express-handlebars');
app.set('view engine', 'hbs');
app.engine('hbs', handlebars({
  layoutsDir: __dirname + '/views/layouts',
  partialsDir: __dirname + '/views/partials',
  extname: 'hbs'
}));

// set up access to the public directory
app.use(express.static('public'));

// set up the body parser for making post requests
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));

// set up our database
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: process.env.DB_PASS,
  database: 'dustinsblog',
  multipleStatements: true
});

app.post('/blogpost/:id/hearted', (req, res) => {
  const blogpost_id = req.params.id;
  pool.getConnection(function (err, connection) {
    if (err) throw err;
    // if we don't error, incrememnt the heart count in the blogpost
    connection.query({
      sql: `UPDATE blogpost SET heart_count = heart_count + 1 WHERE id = ?`,
      values: [blogpost_id]
    }, function (err, result) {
      if (err) {
        console.error(err)
        res.send('Could not add heart to blogpost')
        return
      }
      // redirect user back to the blogpost after processing
      res.redirect('/blogpost/'.concat(blogpost_id))
      connection.release();
    });
  });
});

app.post('/blogpost/:id/commentted', (req, res) => {
  const blogpost_id = req.params.id;
  const comment_user = req.body.comment_user;
  const comment_body = req.body.comment_body;
  pool.getConnection(function (err, connection) {
    if (err) throw err;
    // if we don't error, insert the new comment into the comments table and increment the comment count in the blogpost
    connection.query({
      sql: `INSERT INTO comment (comment_user, comment_body, blogpost_id)
      VALUES(?, ?, ?); UPDATE blogpost SET comment_count = comment_count + 1 WHERE id = ?`,
      values: [comment_user, comment_body, blogpost_id, blogpost_id]
    }, function (err, result) {
      if (err) {
        console.error(err)
        res.send('Could not insert comment into database')
        return
      }
      // redirect user back to blogpost after processing
      res.redirect('/blogpost/'.concat(blogpost_id))
      connection.release();
    });
  });
});

app.post('/contact/', (req, res) => {
  const inquiry_email = req.body.inquiry_email;
  const inquiry_message = req.body.inquiry_message;
  pool.getConnection(function (err, connection) {
    if (err) throw err;
    // if we don't error, insert the inquiry into the inquiry table
    connection.query({
      sql: `INSERT INTO inquiry (inquiry_email, inquiry_message) VALUES(?, ?)`,
      values: [inquiry_email, inquiry_message],
    },
    function (err, result) {
      if (err) {
        console.error(err);
        res.send('Could not send inquiry to database');
        return
      }
      // redirect user to updated contact page so they know that their inquiry went through
      res.redirect('/contact/?submitted=true');
      connection.release();
    });
  });
});

app.get('/', (req, res) => {
  pool.getConnection(function (err, connection) {
    if (err) throw err;
    // if we don't error, collect all blogposts and extract the month and day from each date
    connection.query({
      sql: `SELECT *, MONTHNAME(post_date) AS post_month, DAY(post_date) AS post_day FROM blogpost`,
    }, function (err, result) {
      if (err) {
        console.error(err);
        res.send('An error has occurred');
        return
      }
      // populate the blogposts object with the collected blogposts
      const blogposts = {};
      for (let i = 0; i < result.length; i++) {
        blogposts[i] = {
          blog_link: '/blogpost/'.concat(result[i].id),
          title: result[i].title,
          thumbnail_path: result[i].thumbnail_path,
          content: result[i].content,
          post_month: result[i].post_month,
          post_day: result[i].post_day,
          heart_count: result[i].heart_count,
          comment_count: result[i].comment_count
        }
      }
      top_post = null;
      // if we have at least one blogpost, make the first blogpost the featured post
      // and remove it from the blogposts object
      if (result.length > 0) {
        top_post = blogposts[0];
        delete blogposts[0];
      }
      res.locals = {
        top_post: top_post,
        blogposts: blogposts
      };
      res.render('home', {layout: 'main'});
      connection.release();
    });
  });
});

app.get('/blogpost/:id', (req, res) => {
  const blogpost_id = req.params.id;
  pool.getConnection(function (err, connection) {
    if (err) throw err;
    // if we didn't error, select the blogpost with the specified id, the month and day that it was posted
    // and all comments associated with it
    connection.query({
      sql: `SELECT *, MONTHNAME(post_date) AS post_month, DAY(post_date) AS post_day 
      FROM blogpost LEFT JOIN comment ON blogpost.id = comment.blogpost_id WHERE blogpost.id = ?;`,
      values: [blogpost_id],
    }, function (err, result) {
      if (err) {
        console.error(err);
        res.send('Could not render blog post');
        return
      }

      let blogpost = null;

      for (let i = 0; i < result.length; i++) {
        // if the blog post has already been processed, append the comment to the accumulating list of comments
        if (blogpost) {
          blogpost.comments.push({
            comment_user: result[i].comment_user,
            comment_body: result[i].comment_body
          });
        }
        // otherwise, process the post by initializing it for the first time 
        else {
          blogpost = {
            id: blogpost_id,
            title: result[0].title,
            thumbnail_path: result[0].thumbnail_path,
            blog_body: result[0].blog_body,
            post_month: result[0].post_month,
            post_day: result[0].post_day,
            heart_count: result[0].heart_count,
            comment_count: result[0].comment_count,
            comments: result[i].blogpost_id ? [{
              comment_user: result[i].comment_user,
              comment_body: result[i].comment_body}] : []
          }
        }
      }
      res.locals = blogpost;
      res.render('blogpost', {layout: 'main'});
      connection.release();
    });
  });
});

app.get('/contact/', (req, res) => {
  const submitted = req.query.submitted;
  if (submitted == 'true') {
    res.render('contact', {layout: 'main', submitted: true});
  } else {
    res.render('contact', {layout: 'main', submitted: false});
  }
});

app.get('/about/', (req, res) => {
  res.render('about', {layout: 'main'});
});

app.listen(port, () => {
  console.log(`Dustin's Blog listening at http://localhost:${port}`);
});