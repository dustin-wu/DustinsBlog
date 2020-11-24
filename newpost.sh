echo "Enter the title of your blogpost:"
read title
echo "Enter the file name of the thumbnail image of your blogpost:"
read thumbnail
echo "Enter the body text of your blogpost:"
read blogbody
mysql -u root -p -e "INSERT INTO dustinsblog.blogpost(title, thumbnail, blog_body) VALUES('$title', '$thumbnail', '$blogbody');"
echo "Article inserted, remember to insert your thumbnail image file into the /public/images directory"