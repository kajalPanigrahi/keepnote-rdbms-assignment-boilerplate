
CREATE TABLE `note` (
  `note_id` int(11) NOT NULL,
  `note_title` varchar(45) DEFAULT NULL,
  `note_content` varchar(45) DEFAULT NULL,
  `note_status` varchar(45) DEFAULT NULL,
  `note_creation_date` date DEFAULT NULL,
  PRIMARY KEY (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(45) DEFAULT NULL,
  `category_descr` varchar(45) DEFAULT NULL,
  `category_creation_date` date DEFAULT NULL,
  `category_creator` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `reminder` (
  `reminder_id` int(11) NOT NULL,
  `reminder_name` varchar(45) DEFAULT NULL,
  `reminder_descr` varchar(45) DEFAULT NULL,
  `reminder_type` varchar(45) DEFAULT NULL,
  `reminder_creation_date` date DEFAULT NULL,
  `reminder_creator` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`reminder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(45) DEFAULT NULL,
  `user_added_date` date DEFAULT NULL,
  `user_password` varchar(45) DEFAULT NULL,
  `user_mobile` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `usernote` (
  `usernote_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `note_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`usernote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `notereminder` (
  `notereminder_id` int(11) NOT NULL,
  `note_id` int(11) DEFAULT NULL,
  `reminder_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`notereminder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `notecategory` (
  `notecategory_id` int(11) NOT NULL,
  `note_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`notecategory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `test`.`category` (`category_id`, `category_name`, `category_descr`, `category_creation_date`, `category_creator`) VALUES (1,'Pen','pen-descr','2019-07-18','kajal');
INSERT INTO `test`.`note` (`note_id`, `note_title`, `note_content`, `note_status`, `note_creation_date`) VALUES (1,'note-first','note-content','status','2019-07-18');	
INSERT INTO `test`.`notecategory` (`notecategory_id`, `note_id`, `category_id`) VALUES (1,1,1);	
INSERT INTO `test`.`notereminder` (`notereminder_id`, `note_id`, `reminder_id`) VALUES (1,1,1);
INSERT INTO `test`.`reminder` (`reminder_id`, `reminder_name`, `reminder_descr`, `reminder_type`, `reminder_creation_date`, `reminder_creator`) VALUES (1,'reminder-name','desc','type','2019-07-19','kajal');	
INSERT INTO `test`.`user` (`user_id`, `user_name`, `user_added_date`, `user_password`, `user_mobile`) VALUES (1,'kajal','2019-07-19','kajal',1234567890);	
INSERT INTO `test`.`usernote` (`usernote_id`, `user_id`, `note_id`) VALUES (1,1,1);	


select * from test.user where user_id=1 and user_password='kajal';

select * from test.note where note_creation_date='2019-07-18';

select * from test.category where category_creation_date='2019-07-19' ;

select * from test.usernote where user_id=1;

update test.note set note_title='modify-title' where note_id=1;

select note.* from test.note,test.usernote where usernote.usernote_id=1 
and usernote.usernote_id=note.note_id;

select note.* from test.note,test.notecategory where notecategory.notecategory_id=1 and note.note_id=notecategory.notecategory_id;


select reminder.* from test.reminder,test.notereminder where notereminder.note_id=1 
and notereminder.reminder_id=reminder.reminder_id;


select * from test.reminder where reminder_id=1;

INSERT INTO `test`.`note` (`note_id`, `note_title`, `note_content`, `note_status`, `note_creation_date`) 
usernoteVALUES (7,'note-seven','note-content','status','2019-07-18');

INSERT INTO `test`.`usernote` (`usernote_id`, `user_id`, `note_id`) 
VALUES (8,(select user_id from test.user where user_id=1),8);

INSERT INTO `test`.`notecategory` (`notecategory_id`, `note_id`, `category_id`) 
VALUES (8,(select note_id from test.note where note_id=1),(select category_id from test.category where category_id=1));


INSERT INTO `test`.`notereminder` VALUES (10,(select note_id from test.note where note_id=1),(select reminder_id from test.reminder where reminder_id=1));

delete from test.note where note_id in 
(select usernote.note_id from test.usernote where  usernote.user_id=1);

delete from test.note where note_id in 
(select notecategory.note_id from test.notecategory where category_id=1);

CREATE TRIGGER test.first_trigger
BEFORE DELETE ON `test`.`note`
FOR EACH ROW
BEGIN 
delete from `test`.`notereminder` where note_id=(select note_id from `test`.`usernote` where note_id=(select note_id from `test`.`notereminder` where note_id=1));

END $$
DELIMITER ;


