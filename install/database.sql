
DROP TABLE IF EXISTS tbl_questions;
CREATE TABLE tbl_questions (
  str_pkid VARCHAR(40) NOT NULL,
  str_question TEXT NOT NULL,
  PRIMARY KEY (str_pkid)
);

DROP TABLE IF EXISTS `tbl_gamebase`;
CREATE TABLE  `tbl_gamebase` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Running` tinyint(1) NOT NULL,
  `SessionID` varchar(8) NOT NULL,
  `SessionName` varchar(45) NOT NULL,
  `SessionPW` varchar(45) NOT NULL,
  `LangID` varchar(2) NOT NULL,
  `MinUser` int(10) unsigned NOT NULL,
  `MaxUser` int(10) unsigned NOT NULL,
  `Position_In_QDeck` int(10) unsigned NOT NULL,
  `Position_In_ADeck` int(10) unsigned NOT NULL,
  `Act_Master` varchar(45) NOT NULL,
  `Acc_QDeckID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
