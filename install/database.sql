
SET FOREIGN_KEY_CHECKS=0;

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
ENGINE = InnoDB DEFAULT CHARSET=latin1;

CREATE OR REPLACE VIEW vw_livegames AS
  ( SELECT PKID, MinUser, (select count(*) from tbl_users u where u.FKGameID=g.pkid and u.Deleted<>1)
   usercount FROM tbl_games g where g.CurrentUser IS NOT NULL ORDER BY usercount asc );

CREATE TABLE `tbl_answers` (
  `PKID` varchar(40) NOT NULL,
  `LangID` varchar(2) NOT NULL DEFAULT 'US',
  `str_answer` varchar(200) NOT NULL,
  PRIMARY KEY (`PKID`),
  UNIQUE KEY `PKID_UNIQUE` (`PKID`),
  UNIQUE KEY `str_answer_UNIQUE` (`str_answer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `tbl_questions` (
  `PKID` VARCHAR(40) NOT NULL,
  `LangID` varchar(2) NOT NULL DEFAULT 'US',
  `str_question` TEXT NOT NULL,
  PRIMARY KEY (`PKID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  DEFAULT CHARSET=latin1;

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
  ENGINE = InnoDB DEFAULT CHARSET=latin1;

SET FOREIGN_KEY_CHECKS=1;



