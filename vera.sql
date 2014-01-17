/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `captcha`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `captcha` (
  `id` int(11) NOT NULL,
  `account` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account` (`account`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `tld` varchar(10) NOT NULL DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  UNIQUE KEY `tld` (`tld`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` VALUES ('ac','Ascension Island');
INSERT INTO `countries` VALUES ('ad','Andorra');
INSERT INTO `countries` VALUES ('ae','United Arab Emirates');
INSERT INTO `countries` VALUES ('af','Afghanistan');
INSERT INTO `countries` VALUES ('ag','Antigua and Barbuda');
INSERT INTO `countries` VALUES ('ai','Anguilla');
INSERT INTO `countries` VALUES ('al','Albania');
INSERT INTO `countries` VALUES ('am','Armenia');
INSERT INTO `countries` VALUES ('an','Netherlands Antilles');
INSERT INTO `countries` VALUES ('ao','Angola');
INSERT INTO `countries` VALUES ('aq','Antarctica');
INSERT INTO `countries` VALUES ('ar','Argentina');
INSERT INTO `countries` VALUES ('as','American Samoa');
INSERT INTO `countries` VALUES ('at','Austria');
INSERT INTO `countries` VALUES ('au','Australia');
INSERT INTO `countries` VALUES ('aw','Aruba');
INSERT INTO `countries` VALUES ('ax','Aland Islands');
INSERT INTO `countries` VALUES ('az','Azerbaijan');
INSERT INTO `countries` VALUES ('ba','Bosnia and Herzegovina');
INSERT INTO `countries` VALUES ('bb','Barbados');
INSERT INTO `countries` VALUES ('bd','Bangladesh');
INSERT INTO `countries` VALUES ('be','Belgium');
INSERT INTO `countries` VALUES ('bf','Burkina Faso');
INSERT INTO `countries` VALUES ('bg','Bulgaria');
INSERT INTO `countries` VALUES ('bh','Bahrain');
INSERT INTO `countries` VALUES ('bi','Burundi');
INSERT INTO `countries` VALUES ('bj','Benin');
INSERT INTO `countries` VALUES ('bm','Bermuda');
INSERT INTO `countries` VALUES ('bn','Brunei Darussalam');
INSERT INTO `countries` VALUES ('bo','Bolivia');
INSERT INTO `countries` VALUES ('br','Brazil');
INSERT INTO `countries` VALUES ('bs','Bahamas');
INSERT INTO `countries` VALUES ('bt','Bhutan');
INSERT INTO `countries` VALUES ('bv','Bouvet Island');
INSERT INTO `countries` VALUES ('bw','Botswana');
INSERT INTO `countries` VALUES ('by','Belarus');
INSERT INTO `countries` VALUES ('bz','Belize');
INSERT INTO `countries` VALUES ('ca','Canada');
INSERT INTO `countries` VALUES ('cc','Cocos (Keeling) Islands');
INSERT INTO `countries` VALUES ('cd','Congo, The Democratic Republic of the');
INSERT INTO `countries` VALUES ('cf','Central African Republic');
INSERT INTO `countries` VALUES ('cg','Congo, Republic of');
INSERT INTO `countries` VALUES ('ch','Switzerland');
INSERT INTO `countries` VALUES ('ci','Cote d\'Ivoire');
INSERT INTO `countries` VALUES ('ck','Cook Islands');
INSERT INTO `countries` VALUES ('cl','Chile');
INSERT INTO `countries` VALUES ('cm','Cameroon');
INSERT INTO `countries` VALUES ('cn','China');
INSERT INTO `countries` VALUES ('co','Colombia');
INSERT INTO `countries` VALUES ('cr','Costa Rica');
INSERT INTO `countries` VALUES ('cs','Serbia and Montenegro');
INSERT INTO `countries` VALUES ('cu','Cuba');
INSERT INTO `countries` VALUES ('cv','Cape Verde');
INSERT INTO `countries` VALUES ('cx','Christmas Island');
INSERT INTO `countries` VALUES ('cy','Cyprus');
INSERT INTO `countries` VALUES ('cz','Czech Republic');
INSERT INTO `countries` VALUES ('de','Germany');
INSERT INTO `countries` VALUES ('dj','Djibouti');
INSERT INTO `countries` VALUES ('dk','Denmark');
INSERT INTO `countries` VALUES ('dm','Dominica');
INSERT INTO `countries` VALUES ('do','Dominican Republic');
INSERT INTO `countries` VALUES ('dz','Algeria');
INSERT INTO `countries` VALUES ('ec','Ecuador');
INSERT INTO `countries` VALUES ('ee','Estonia');
INSERT INTO `countries` VALUES ('eg','Egypt');
INSERT INTO `countries` VALUES ('eh','Western Sahara');
INSERT INTO `countries` VALUES ('er','Eritrea');
INSERT INTO `countries` VALUES ('es','Spain');
INSERT INTO `countries` VALUES ('et','Ethiopia');
INSERT INTO `countries` VALUES ('fi','Finland');
INSERT INTO `countries` VALUES ('fj','Fiji');
INSERT INTO `countries` VALUES ('fk','Falkland Islands (Malvinas)');
INSERT INTO `countries` VALUES ('fm','Micronesia, Federal State of');
INSERT INTO `countries` VALUES ('fo','Faroe Islands');
INSERT INTO `countries` VALUES ('fr','France');
INSERT INTO `countries` VALUES ('ga','Gabon');
INSERT INTO `countries` VALUES ('gb','United Kingdom');
INSERT INTO `countries` VALUES ('gd','Grenada');
INSERT INTO `countries` VALUES ('ge','Georgia');
INSERT INTO `countries` VALUES ('gf','French Guiana');
INSERT INTO `countries` VALUES ('gg','Guernsey');
INSERT INTO `countries` VALUES ('gh','Ghana');
INSERT INTO `countries` VALUES ('gi','Gibraltar');
INSERT INTO `countries` VALUES ('gl','Greenland');
INSERT INTO `countries` VALUES ('gm','Gambia');
INSERT INTO `countries` VALUES ('gn','Guinea');
INSERT INTO `countries` VALUES ('gp','Guadeloupe');
INSERT INTO `countries` VALUES ('gq','Equatorial Guinea');
INSERT INTO `countries` VALUES ('gr','Greece');
INSERT INTO `countries` VALUES ('gs','South Georgia and the South Sandwich Islands');
INSERT INTO `countries` VALUES ('gt','Guatemala');
INSERT INTO `countries` VALUES ('gu','Guam');
INSERT INTO `countries` VALUES ('gw','Guinea-Bissau');
INSERT INTO `countries` VALUES ('gy','Guyana');
INSERT INTO `countries` VALUES ('hk','Hong Kong');
INSERT INTO `countries` VALUES ('hm','Heard and McDonald Islands');
INSERT INTO `countries` VALUES ('hn','Honduras');
INSERT INTO `countries` VALUES ('hr','Croatia/Hrvatska');
INSERT INTO `countries` VALUES ('ht','Haiti');
INSERT INTO `countries` VALUES ('hu','Hungary');
INSERT INTO `countries` VALUES ('id','Indonesia');
INSERT INTO `countries` VALUES ('ie','Ireland');
INSERT INTO `countries` VALUES ('il','Israel');
INSERT INTO `countries` VALUES ('im','Isle of Man');
INSERT INTO `countries` VALUES ('in','India');
INSERT INTO `countries` VALUES ('io','British Indian Ocean Territory');
INSERT INTO `countries` VALUES ('iq','Iraq');
INSERT INTO `countries` VALUES ('ir','Iran, Islamic Republic of');
INSERT INTO `countries` VALUES ('is','Iceland');
INSERT INTO `countries` VALUES ('it','Italy');
INSERT INTO `countries` VALUES ('je','Jersey');
INSERT INTO `countries` VALUES ('jm','Jamaica');
INSERT INTO `countries` VALUES ('jo','Jordan');
INSERT INTO `countries` VALUES ('jp','Japan');
INSERT INTO `countries` VALUES ('ke','Kenya');
INSERT INTO `countries` VALUES ('kg','Kyrgyzstan');
INSERT INTO `countries` VALUES ('kh','Cambodia');
INSERT INTO `countries` VALUES ('ki','Kiribati');
INSERT INTO `countries` VALUES ('km','Comoros');
INSERT INTO `countries` VALUES ('kn','Saint Kitts and Nevis');
INSERT INTO `countries` VALUES ('kp','Korea, Democratic People\'s Republic');
INSERT INTO `countries` VALUES ('kr','Korea, Republic of');
INSERT INTO `countries` VALUES ('kw','Kuwait');
INSERT INTO `countries` VALUES ('ky','Cayman Islands');
INSERT INTO `countries` VALUES ('kz','Kazakhstan');
INSERT INTO `countries` VALUES ('la','Lao People\'s Democratic Republic');
INSERT INTO `countries` VALUES ('lb','Lebanon');
INSERT INTO `countries` VALUES ('lc','Saint Lucia');
INSERT INTO `countries` VALUES ('li','Liechtenstein');
INSERT INTO `countries` VALUES ('lk','Sri Lanka');
INSERT INTO `countries` VALUES ('lr','Liberia');
INSERT INTO `countries` VALUES ('ls','Lesotho');
INSERT INTO `countries` VALUES ('lt','Lithuania');
INSERT INTO `countries` VALUES ('lu','Luxembourg');
INSERT INTO `countries` VALUES ('lv','Latvia');
INSERT INTO `countries` VALUES ('ly','Libyan Arab Jamahiriya');
INSERT INTO `countries` VALUES ('ma','Morocco');
INSERT INTO `countries` VALUES ('mc','Monaco');
INSERT INTO `countries` VALUES ('md','Moldova, Republic of');
INSERT INTO `countries` VALUES ('mg','Madagascar');
INSERT INTO `countries` VALUES ('mh','Marshall Islands');
INSERT INTO `countries` VALUES ('mk','Macedonia, The Former Yugoslav Republic of');
INSERT INTO `countries` VALUES ('ml','Mali');
INSERT INTO `countries` VALUES ('mm','Myanmar');
INSERT INTO `countries` VALUES ('mn','Mongolia');
INSERT INTO `countries` VALUES ('mo','Macau');
INSERT INTO `countries` VALUES ('mp','Northern Mariana Islands');
INSERT INTO `countries` VALUES ('mq','Martinique');
INSERT INTO `countries` VALUES ('mr','Mauritania');
INSERT INTO `countries` VALUES ('ms','Montserrat');
INSERT INTO `countries` VALUES ('mt','Malta');
INSERT INTO `countries` VALUES ('mu','Mauritius');
INSERT INTO `countries` VALUES ('mv','Maldives');
INSERT INTO `countries` VALUES ('mw','Malawi');
INSERT INTO `countries` VALUES ('mx','Mexico');
INSERT INTO `countries` VALUES ('my','Malaysia');
INSERT INTO `countries` VALUES ('mz','Mozambique');
INSERT INTO `countries` VALUES ('na','Namibia');
INSERT INTO `countries` VALUES ('nc','New Caledonia');
INSERT INTO `countries` VALUES ('ne','Niger');
INSERT INTO `countries` VALUES ('nf','Norfolk Island');
INSERT INTO `countries` VALUES ('ng','Nigeria');
INSERT INTO `countries` VALUES ('ni','Nicaragua');
INSERT INTO `countries` VALUES ('nl','Netherlands');
INSERT INTO `countries` VALUES ('no','Norway');
INSERT INTO `countries` VALUES ('np','Nepal');
INSERT INTO `countries` VALUES ('nr','Nauru');
INSERT INTO `countries` VALUES ('nu','Niue');
INSERT INTO `countries` VALUES ('nz','New Zealand');
INSERT INTO `countries` VALUES ('om','Oman');
INSERT INTO `countries` VALUES ('pa','Panama');
INSERT INTO `countries` VALUES ('pe','Peru');
INSERT INTO `countries` VALUES ('pf','French Polynesia');
INSERT INTO `countries` VALUES ('pg','Papua New Guinea');
INSERT INTO `countries` VALUES ('ph','Philippines');
INSERT INTO `countries` VALUES ('pk','Pakistan');
INSERT INTO `countries` VALUES ('pl','Poland');
INSERT INTO `countries` VALUES ('pm','Saint Pierre and Miquelon');
INSERT INTO `countries` VALUES ('pn','Pitcairn Island');
INSERT INTO `countries` VALUES ('pr','Puerto Rico');
INSERT INTO `countries` VALUES ('ps','Palestinian Territory, Occupied');
INSERT INTO `countries` VALUES ('pt','Portugal');
INSERT INTO `countries` VALUES ('pw','Palau');
INSERT INTO `countries` VALUES ('py','Paraguay');
INSERT INTO `countries` VALUES ('qa','Qatar');
INSERT INTO `countries` VALUES ('re','Reunion Island');
INSERT INTO `countries` VALUES ('ro','Romania');
INSERT INTO `countries` VALUES ('ru','Russian Federation');
INSERT INTO `countries` VALUES ('rw','Rwanda');
INSERT INTO `countries` VALUES ('sa','Saudi Arabia');
INSERT INTO `countries` VALUES ('sb','Solomon Islands');
INSERT INTO `countries` VALUES ('sc','Seychelles');
INSERT INTO `countries` VALUES ('sd','Sudan');
INSERT INTO `countries` VALUES ('se','Sweden');
INSERT INTO `countries` VALUES ('sg','Singapore');
INSERT INTO `countries` VALUES ('sh','Saint Helena');
INSERT INTO `countries` VALUES ('si','Slovenia');
INSERT INTO `countries` VALUES ('sj','Svalbard and Jan Mayen Islands');
INSERT INTO `countries` VALUES ('sk','Slovak Republic');
INSERT INTO `countries` VALUES ('sl','Sierra Leone');
INSERT INTO `countries` VALUES ('sm','San Marino');
INSERT INTO `countries` VALUES ('sn','Senegal');
INSERT INTO `countries` VALUES ('so','Somalia');
INSERT INTO `countries` VALUES ('sr','Suriname');
INSERT INTO `countries` VALUES ('st','Sao Tome and Principe');
INSERT INTO `countries` VALUES ('sv','El Salvador');
INSERT INTO `countries` VALUES ('sy','Syrian Arab Republic');
INSERT INTO `countries` VALUES ('sz','Swaziland');
INSERT INTO `countries` VALUES ('tc','Turks and Caicos Islands');
INSERT INTO `countries` VALUES ('td','Chad');
INSERT INTO `countries` VALUES ('tf','French Southern Territories');
INSERT INTO `countries` VALUES ('tg','Togo');
INSERT INTO `countries` VALUES ('th','Thailand');
INSERT INTO `countries` VALUES ('tj','Tajikistan');
INSERT INTO `countries` VALUES ('tk','Tokelau');
INSERT INTO `countries` VALUES ('tl','Timor-Leste');
INSERT INTO `countries` VALUES ('tm','Turkmenistan');
INSERT INTO `countries` VALUES ('tn','Tunisia');
INSERT INTO `countries` VALUES ('to','Tonga');
INSERT INTO `countries` VALUES ('tp','East Timor');
INSERT INTO `countries` VALUES ('tr','Turkey');
INSERT INTO `countries` VALUES ('tt','Trinidad and Tobago');
INSERT INTO `countries` VALUES ('tv','Tuvalu');
INSERT INTO `countries` VALUES ('tw','Taiwan');
INSERT INTO `countries` VALUES ('tz','Tanzania');
INSERT INTO `countries` VALUES ('ua','Ukraine');
INSERT INTO `countries` VALUES ('ug','Uganda');
INSERT INTO `countries` VALUES ('uk','United Kingdom');
INSERT INTO `countries` VALUES ('um','United States Minor Outlying Islands');
INSERT INTO `countries` VALUES ('us','United States');
INSERT INTO `countries` VALUES ('uy','Uruguay');
INSERT INTO `countries` VALUES ('uz','Uzbekistan');
INSERT INTO `countries` VALUES ('va','Holy See (Vatican City State)');
INSERT INTO `countries` VALUES ('vc','Saint Vincent and the Grenadines');
INSERT INTO `countries` VALUES ('ve','Venezuela');
INSERT INTO `countries` VALUES ('vg','Virgin Islands, British');
INSERT INTO `countries` VALUES ('vi','Virgin Islands, U.S.');
INSERT INTO `countries` VALUES ('vn','Vietnam');
INSERT INTO `countries` VALUES ('vu','Vanuatu');
INSERT INTO `countries` VALUES ('wf','Wallis and Futuna Islands');
INSERT INTO `countries` VALUES ('ws','Western Samoa');
INSERT INTO `countries` VALUES ('ye','Yemen');
INSERT INTO `countries` VALUES ('yt','Mayotte');
INSERT INTO `countries` VALUES ('yu','Yugoslavia');
INSERT INTO `countries` VALUES ('za','South Africa');
INSERT INTO `countries` VALUES ('zm','Zambia');
INSERT INTO `countries` VALUES ('zw','Zimbabwe');

--
-- Table structure for table `elo_game`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elo_game` (
  `id` int(11) NOT NULL,
  `player1` int(11) NOT NULL,
  `player2` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `player1result` enum('win','loss','draw') DEFAULT NULL,
  `player2result` enum('win','loss','draw') DEFAULT NULL,
  `player1change` int(11) NOT NULL DEFAULT '0',
  `player2change` int(11) NOT NULL DEFAULT '0',
  `player1score` int(11) NOT NULL DEFAULT '0',
  `player2score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `games`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `games` (
  `id` int(11) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `shortcut` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

INSERT INTO `games` VALUES (1,'Guild Wars','GW');
INSERT INTO `games` VALUES (2,'Left 4 Dead 2','L4D2');
INSERT INTO `games` VALUES (3,'Team Fortress 2','TF2');
INSERT INTO `games` VALUES (4,'StarCraft 2','SC2');
INSERT INTO `games` VALUES (5,'Neverwinter Nights','NWN');
INSERT INTO `games` VALUES (6,'Neverwinter Nights 2','NWN2');
INSERT INTO `games` VALUES (7,'Unreal Tournament 2004','UT2k4');
INSERT INTO `games` VALUES (8,'Unreal Tournament 3','UT3');
INSERT INTO `games` VALUES (9,'Age of Empires 2','AOE2');
INSERT INTO `games` VALUES (10,'Age of Empires 3','AOE3');
INSERT INTO `games` VALUES (11,'Borderlands','BL');
INSERT INTO `games` VALUES (12,'Guild Wars 2','GW2');
INSERT INTO `games` VALUES (13,'Labspace',NULL);
INSERT INTO `games` VALUES (14,'Counter-Strike','CS');
INSERT INTO `games` VALUES (15,'Counter-Strike: Source','CSS');
INSERT INTO `games` VALUES (16,'Diablo 3','D3');
INSERT INTO `games` VALUES (17,'Borderlands 2','BL2');
INSERT INTO `games` VALUES (18,'Battlefield 3','BF3');
INSERT INTO `games` VALUES (19,'Minecraft','MC');
INSERT INTO `games` VALUES (20,'EVE Online','EVE');
INSERT INTO `games` VALUES (21,'Alien Swarm','AS');
INSERT INTO `games` VALUES (22,'Natural Selection 2','NS2');
INSERT INTO `games` VALUES (23,'Natural Selection','NS');
INSERT INTO `games` VALUES (24,'League of Legends','LOL');
INSERT INTO `games` VALUES (25,'Team Foersvarsmakten',NULL);
INSERT INTO `games` VALUES (26,'Dayz',NULL);
INSERT INTO `games` VALUES (27,'End of Nations','EoN');
INSERT INTO `games` VALUES (28,'bindi',NULL);
INSERT INTO `games` VALUES (29,'Counter-Strike: Global Offensive','CSGO');
INSERT INTO `games` VALUES (30,'Entropia',NULL);
INSERT INTO `games` VALUES (31,'Smite',NULL);
INSERT INTO `games` VALUES (32,'Firefall',NULL);
INSERT INTO `games` VALUES (33,'PAYDAY: The Heist','PAYDAY');
INSERT INTO `games` VALUES (34,'Mumble',NULL);
INSERT INTO `games` VALUES (35,'PAYDAY 2','PAYDAY2');
INSERT INTO `games` VALUES (36,'Dota 2','DOTA2');

--
-- Table structure for table `levels`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `levels` (
  `level` int(11) NOT NULL DEFAULT '0',
  `text` varchar(50) NOT NULL DEFAULT '',
  UNIQUE KEY `level` (`level`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `levels`
--

INSERT INTO `levels` VALUES (2,'friend');
INSERT INTO `levels` VALUES (3,'channel helper');
INSERT INTO `levels` VALUES (4,'trial');
INSERT INTO `levels` VALUES (5,'channel operator');
INSERT INTO `levels` VALUES (6,'master');
INSERT INTO `levels` VALUES (7,'owner');
INSERT INTO `levels` VALUES (0,'peon');
INSERT INTO `levels` VALUES (1,'known user');

--
-- Table structure for table `notes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notes` (
  `id` int(11) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0',
  `from` varchar(15) NOT NULL DEFAULT '',
  `to` varchar(15) NOT NULL DEFAULT '',
  `text` varchar(255) NOT NULL DEFAULT '',
  `read` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quotes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotes` (
  `id` int(11) NOT NULL,
  `creator` varchar(30) NOT NULL DEFAULT '',
  `text` blob NOT NULL,
  KEY `id` (`id`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rating`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating` (
  `account` varchar(15) NOT NULL DEFAULT '',
  `monday` int(11) NOT NULL DEFAULT '0',
  `tuesday` int(11) NOT NULL DEFAULT '0',
  `wednesday` int(11) NOT NULL DEFAULT '0',
  `thursday` int(11) NOT NULL DEFAULT '0',
  `friday` int(11) NOT NULL DEFAULT '0',
  `saturday` int(11) NOT NULL DEFAULT '0',
  `sunday` int(11) NOT NULL DEFAULT '0',
  `lastact` int(11) NOT NULL DEFAULT '0',
  UNIQUE KEY `account` (`account`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `raws`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raws` (
  `numeric` varchar(15) NOT NULL DEFAULT '',
  `text` blob NOT NULL,
  UNIQUE KEY `numeric` (`numeric`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raws`
--


--
-- Table structure for table `rules`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rules` (
  `id` int(11) NOT NULL DEFAULT '0',
  `rule` varchar(15) NOT NULL DEFAULT '',
  `text` varchar(150) NOT NULL DEFAULT '',
  UNIQUE KEY `id` (`id`,`rule`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rules`
--

INSERT INTO `rules` VALUES (1,'idle','Any harassment, fighting or foul language in #sbfl is forbidden.');
INSERT INTO `rules` VALUES (2,'scripts','Using any disruptive script is forbidden. This includes, but is not limited to; away scripts, MP3 scripts, on join messages and triggers.');
INSERT INTO `rules` VALUES (3,'paste','Do not paste more than 3 lines. Use our nopaste site instead (http://script.quakenet.org/paste/).');
INSERT INTO `rules` VALUES (4,'adv','Do not spam, advertise or ask others to query you if you have a question.');
INSERT INTO `rules` VALUES (5,'warez','Distribution of, or asking for, warez and/or warez distribution sites is strictly forbidden.');

--
-- Table structure for table `topics`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `topics` (
  `channel` varchar(40) NOT NULL DEFAULT '',
  `topic` varchar(250) NOT NULL DEFAULT '',
  UNIQUE KEY `channel` (`channel`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `triggers`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `triggers` (
  `trigger` varchar(30) NOT NULL DEFAULT '',
  `hint` blob NOT NULL,
  PRIMARY KEY (`trigger`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `account` varchar(15) NOT NULL DEFAULT '',
  `level` int(11) NOT NULL DEFAULT '0',
  `created` int(11) NOT NULL DEFAULT '0',
  `modified` int(11) NOT NULL DEFAULT '0',
  `awaysince` int(11) NOT NULL DEFAULT '0',
  `awaytext` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  `passwordsha1` varchar(40) DEFAULT NULL,
  `elo_score` int(11) NOT NULL DEFAULT '1000',
  `inviter` varchar(15) DEFAULT NULL,
  `nickname` varchar(20) DEFAULT NULL,
  `birthday` int(11) DEFAULT NULL,
  UNIQUE KEY `account` (`account`),
  UNIQUE KEY `id_2` (`id`),
  KEY `id` (`id`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_games`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_games` (
  `account` varchar(15) DEFAULT NULL,
  `game` varchar(64) DEFAULT NULL
);
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
