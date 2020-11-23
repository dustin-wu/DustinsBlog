-- MySQL dump 10.13  Distrib 8.0.22, for osx10.15 (x86_64)
--
-- Host: localhost    Database: dustinsblog
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blogpost`
--

DROP TABLE IF EXISTS `blogpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogpost` (
  `id` int NOT NULL AUTO_INCREMENT,
  `blog_body` text NOT NULL,
  `title` text NOT NULL,
  `thumbnail_path` text NOT NULL,
  `heart_count` int NOT NULL DEFAULT '0',
  `comment_count` int NOT NULL DEFAULT '0',
  `post_date` date DEFAULT (curdate()),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogpost`
--

LOCK TABLES `blogpost` WRITE;
/*!40000 ALTER TABLE `blogpost` DISABLE KEYS */;
INSERT INTO `blogpost` VALUES (1,'Debugging your code can be hard. Like, really hard. Harder than writing the code itself, even. But holding a stethoscope to your computers monitor certainly wont get you anywhere.','How to debug your code','/images/placeholder1.jpg',8,3,'2020-11-21'),(2,'Distractions mean that you aren’t writing code, so you want to minimize distractions. What is a distraction to you? Maybe you need to lock yourself out of accessing websites like Youtube or Facebook. Maybe you need to surround yourself with peers that can hold you accountable. Maybe you work best alone and in the zone. The point is, you should put work into discovering what environment works best for you.','Why workplace environment is the most important thing for a developer','/images/placeholder2.jpg',3,2,'2020-11-21'),(3,'Working on code as a team adds a lot of complications. Differing opinions on style and/or on problem-solving approach can cause arguments and setbacks. And sometimes you really just need some alone time to figure out how to implement that one feature. Then again, almost every single piece of ambitious software has a team, not just an individual, behind it.','Group projects','/images/placeholder3.jpg',4,3,'2020-11-21'),(4,'Confusion is frustrating. It makes you wonder why you decided to get into programming; “Was I in it for the clout all along?”, and “What life choices led me to this moment?” are questions you might ask yourself. Confusion is scary; it makes you question if you’re inadequate and if you’re less capable peers/coworkers. Confusion is stressful, as one issue completely prevents you from making progress towards the imminent deadline. So how do you deal with it? It’s simple; just realize that everyone is confused. All the time. It isn’t just you.','How to deal with confusion','/images/placeholder4.jpg',0,0,'2020-11-21'),(5,'Just look at the above stock photo image. Who wants to read such cluttered code? Could anyone even begin to interpret it? I mean why would you not use spaces and indents, so you can shrink down the file size by a couple of bytes. If you coded like this and I was your boss, I would fire you. In fact, I bet that any boss would fire you. Please add spaces and indents to your code.','Why you need to use spaces and indents','/images/placeholder5.jpg',3,3,'2020-11-21');
/*!40000 ALTER TABLE `blogpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment_body` text NOT NULL,
  `blogpost_id` int NOT NULL,
  `comment_user` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `blogpost_id` (`blogpost_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`blogpost_id`) REFERENCES `blogpost` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (16,'Amazing Work',1,'John'),(17,'Love this, hearted.',1,'Erica'),(18,'Agreed, spacing is important.',5,'Mark'),(19,'P.S. love your writing style, it\'s amazing.',5,'Mark'),(20,'Currently working on a group project, what can I do to get my ideas heard?',3,'Kim'),(21,'@Kim: Great question! Frankly I struggle with that myself, but what I find helpful is being forward rather than reserved if you think that you have something worthwhile.',3,'Dustin'),(22,'Agreed, I always have a social media tab and I can\'t say that it hasn\'t been hurting my productivity.',2,'Jack'),(23,'@Jack I totally get where you\'re coming from, I need to figure out how to block myself out from all these apps until I\'ve gotten everything done.',2,'Jill'),(24,'Yeah I don\'t get why we still have stock images with non-spaced code. ',5,'Joan'),(25,'I struggle with group projects; collaboration is something I really need to get better at.',3,'Robert'),(26,'Agreed, I tried the stethoscope thing and it did not work.',1,'Robert');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inquiry`
--

DROP TABLE IF EXISTS `inquiry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inquiry` (
  `id` int NOT NULL AUTO_INCREMENT,
  `inquiry_email` text NOT NULL,
  `inquiry_message` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inquiry`
--

LOCK TABLES `inquiry` WRITE;
/*!40000 ALTER TABLE `inquiry` DISABLE KEYS */;
INSERT INTO `inquiry` VALUES (8,'test','testing'),(9,'test2@foo.bar','this is a second test just to confirm that things are working.'),(10,'test@test.com','Test inquiry here, idk what else to say.'),(11,'likehtehundrethtest@gmail.com','Hello, again.'),(12,'adsf','daf'),(13,'dashes','safasdf'),(14,'test1111','1111');
/*!40000 ALTER TABLE `inquiry` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-22 18:23:01
