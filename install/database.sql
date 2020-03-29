
DROP TABLE IF EXISTS tbl_questions;
CREATE TABLE tbl_questions (
  str_pkid VARCHAR(40) NOT NULL,
  str_question TEXT NOT NULL,
  PRIMARY KEY (str_pkid)
);