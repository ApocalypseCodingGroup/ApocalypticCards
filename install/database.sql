
DROP TABLE IF EXISTS `tbl_users`;
DROP TABLE IF EXISTS `tbl_answers`;
DROP TABLE IF EXISTS `tbl_questions`;
DROP TABLE IF EXISTS `tbl_gamequestions`;
DROP TABLE IF EXISTS `tbl_gameanswers`;
DROP TABLE IF EXISTS `tbl_games`;

CREATE TABLE  `tbl_games` (
  `PKID` VARCHAR(40) NOT NULL,
  `GameState` INTEGER NOT NULL DEFAULT 0,
  `SessionName` varchar(45) NOT NULL,
  `SessionPW` varchar(45) NOT NULL DEFAULT '',
  `LangID` varchar(2) NOT NULL DEFAULT 'US',
  `MinUser` int(10) unsigned NOT NULL DEFAULT 3,
  `MaxUser` int(10) unsigned NOT NULL DEFAULT 8,
  `CurrentUser` VARCHAR(40),
  `CurrentQuestion` VARCHAR(40),
  `LastUpdate` TIMESTAMP,
  PRIMARY KEY (`PKID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tbl_users` (
  `PKID` VARCHAR(40) NOT NULL,
  `FKGameID` VARCHAR(40) NOT NULL,
  `Name` VARCHAR(255) NULL,
  `LastUpdate` TIMESTAMP,
  `Deleted` TINYINT(1),
  `Score` INTEGER DEFAULT 0,
  `PlayerState` INTEGER,
  PRIMARY KEY (`PKID`),
  CONSTRAINT `keyUsersGames`
    FOREIGN KEY (`FKGameID`)
    REFERENCES `tbl_games` (`PKID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE OR REPLACE VIEW vw_livegames AS
  ( SELECT PKID, MinUser, (select count(*) from tbl_users u where u.FKGameID=g.pkid and u.Deleted<>1) usercount FROM tbl_games g where g.CurrentUser IS NOT NULL ORDER BY usercount asc );

CREATE TABLE `tbl_answers` (
  `PKID` varchar(40) NOT NULL,
  `str_type` varchar(12) NOT NULL,
  `str_answer` varchar(200) NOT NULL,
  PRIMARY KEY (`PKID`),
  UNIQUE KEY `PKID_UNIQUE` (`PKID`),
  UNIQUE KEY `str_answer_UNIQUE` (`str_answer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tbl_questions` (
  PKID VARCHAR(40) NOT NULL,
  str_question TEXT NOT NULL,
  PRIMARY KEY (PKID)
);

CREATE TABLE `tbl_gamequestions` (
  `PKID` VARCHAR(40) NOT NULL,
  `FKGameID` VARCHAR(40) NOT NULL,
  `FKQuestionID` VARCHAR(40) NULL,
  `Discarded` TINYINT(1) DEFAULT 0,
  PRIMARY KEY (`PKID`),
  CONSTRAINT `keyQuestionGames`
    FOREIGN KEY (`FKGameID`)
    REFERENCES `tbl_games` (`PKID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;

CREATE TABLE `tbl_gameanswers` (
  `PKID` VARCHAR(40) NOT NULL,
  `FKGameID` VARCHAR(40) NOT NULL,
  `FKPlayerID` VARCHAR(40) DEFAULT NULL,
  `FKAnswerID` VARCHAR(40) NOT NULL,
  `State` INTEGER DEFAULT 0,
  PRIMARY KEY (`PKID`),
  CONSTRAINT `keyAnswerGames`
    FOREIGN KEY (`FKGameID`)
    REFERENCES `tbl_games` (`PKID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;


/*
API/Run?SessionID="hGASjsd6"
// Question and Answer DESK is created with SessionID shuffled
// Session set to Running
// Assign 10 Cards to All Users
// Result should be the First Quetion for Display. (Acc_QDeckID)
*/

/*
//DROP TABLE IF EXISTS `developer`.`questionbase`;
//CREATE TABLE  `developer`.`questionbase` (
//  `PKID` VARCHAR(40) NOT NULL,
//  `URL` tinyint(1) NOT NULL,
//  `Question` varchar(250) NOT NULL,
//  `LangID` varchar(2) NOT NULL,
//  `MinAnswerCards` int(10) unsigned NOT NULL,
//  PRIMARY KEY (`PKID`) USING BTREE
//) ENGINE=InnoDB DEFAULT CHARSET=latin1;
*/

/*
//DROP TABLE IF EXISTS `developer`.`answerbase`;
//CREATE TABLE  `developer`.`answerbase` (
//  `PKID` VARCHAR(40) NOT NULL,
//  `URL` tinyint(1) NOT NULL,
//  `Answer` varchar(250) NOT NULL,
//  `LangID` varchar(2) NOT NULL,
//  PRIMARY KEY (`PKID`) USING BTREE
//) ENGINE=InnoDB DEFAULT CHARSET=latin1;
*/

/*
//DROP TABLE IF EXISTS `developer`.`deckQbase`;
//CREATE TABLE  `developer`.`deckbase` (
//  `PKID` VARCHAR(40) NOT NULL,
//  `SessionID` varchar(8) NOT NULL,
//  `Quertion` int(10) unsigned NOT NULL,  // Pointer to QuetionBaseID
//  PRIMARY KEY (`PKID`) USING BTREE
//) ENGINE=InnoDB DEFAULT CHARSET=latin1;
*/

/*
//DROP TABLE IF EXISTS `developer`.`deckAbase`;
//CREATE TABLE  `developer`.`deckbase` (
//  `PKID` VARCHAR(40) NOT NULL,
//  `SessionID` varchar(8) NOT NULL,
//  `Answer` int(10) unsigned NOT NULL,  // Pointer to AnswerBaseID
//  PRIMARY KEY (`PKID`) USING BTREE
//) ENGINE=InnoDB DEFAULT CHARSET=latin1;
*/


/*
API/JoinGame?SessionID="hGASjsd6"&SessionName="Glenn"&SessionPW=""
// Result UserToken
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=2
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=4
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=2
API/ClickCard?SessionID="hGASjsd6"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&CardNr=6
// Result Selected_1=2
// Result Selected_2=4                            {EAC84404-8A36-4839-ADE0-BE9B14278315}
// Result Selected_1=-1
// Result Selected_1=6

API/Pullanswers?SessionID="hGASjsd6"&MasterToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"
// Result Not Ready | Selection Result from all Users
API/FinalPull?SessionID="hGASjsd6"&MasterToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"
// Selection Result from all Users that have done the selection in time

// Show results to Master

API/SelectResult?SessionID="hGASjsd6"&MasterToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"&UserToken="{EAC84404-8A36-4839-ADE0-BE9B14278315}"
// Collect Points
// Redraw from deck
// Select next Master
*/

/*
//DROP TABLE IF EXISTS `developer`.`userbase`;
//CREATE TABLE  `developer`.`userbase` (
//  `PKID` VARCHAR(40) NOT NULL,
//  `SessionID` varchar(8) NOT NULL,
//  `UserToken` varchar(42) DEFAULT NULL,
//  `Name` varchar(64) DEFAULT NULL,
//  `Points` int(10) unsigned NOT NULL,
//  `Card_0` int(10) unsigned NOT NULL,
//  `Card_1` int(10) unsigned NOT NULL,
//  `Card_2` int(10) unsigned NOT NULL,
//  `Card_3` int(10) unsigned NOT NULL,
//  `Card_4` int(10) unsigned NOT NULL,
//  `Card_5` int(10) unsigned NOT NULL,
//  `Card_6` int(10) unsigned NOT NULL,
//  `Card_7` int(10) unsigned NOT NULL,
//  `Selected_1` int(10) unsigned NOT NULL,
//  `Selected_2` int(10) unsigned NOT NULL,
//  PRIMARY KEY (`PKID`) USING BTREE
//) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
*/
