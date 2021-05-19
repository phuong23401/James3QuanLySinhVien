CREATE TABLE `class`(
`classID` INT AUTO_INCREMENT PRIMARY KEY,
`className` VARCHAR(60) NOT NULL,
`startDate` DATETIME,
`status` BIT
);

CREATE TABLE `student`(
`studentID` INT AUTO_INCREMENT PRIMARY KEY,
`studentName` VARCHAR(30) NOT NULL,
`address` VARCHAR(50),
`phone` VARCHAR(20),
`status` BIT,
`classID` INT NOT NULL,
FOREIGN KEY (`classID`) REFERENCES `class`(`classID`)
);

CREATE TABLE `subject`(
`subID` INT AUTO_INCREMENT PRIMARY KEY,
`subName` VARCHAR(30) NOT NULL,
`credit` TINYINT NOT NULL DEFAULT(1) CHECK(`credit` >= 1),
`status` BIT DEFAULT(1)
);

CREATE TABLE `mark`(
`markID` INT AUTO_INCREMENT PRIMARY KEY,
`subID` INT NOT NULL UNIQUE,
`studentID` INT NOT NULL UNIQUE,
`mark` FLOAT DEFAULT(0) CHECK(0 <= `mark` <= 10),
`examTimes` TINYINT DEFAULT(1),
FOREIGN KEY (`subID`) REFERENCES `subject`(`subID`),
FOREIGN KEY (`studentID`) REFERENCES `student`(`studentID`)
);

INSERT INTO `class`VALUES 
(1, 'A1', '2008-12-20', 1),
(2, 'A2', '2008-12-22', 1),
(3, 'B3', CURRENT_DATE, 0);

INSERT INTO `student`(`studentName`, `address`, `phone`, `status`, `classID`) VALUES 
('Hung', 'Ha Noi', '0912113113', 1, 1),
('Manh', 'HCM', '0123123123', 0, 2);
INSERT INTO `student`(`studentName`, `address`, `status`, `classID`) VALUES 
('Hoa', 'Hai phong', 1, 1);

INSERT INTO `subject` VALUES 
(1, 'CF', 5, 1),
(2, 'C', 6, 1),
(3, 'HDJ', 5, 1),
(4, 'RDBMS', 10, 1);

INSERT INTO `mark` (`subID`, `studentID`, `mark`, `examTimes`) VALUES 
(1, 1, 8, 1),
(3, 2, 10, 2),
(2, 3, 12, 1);

-- Hiển thị danh sách tất cả các học viên
SELECT * FROM `student`;

-- Hiển thị danh sách các học viên đang theo học
SELECT * FROM `student`
WHERE `status` = true;

-- Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ
SELECT * FROM `subject`
WHERE `credit` < 10;

-- Hiển thị danh sách học viên lớp A1
SELECT S.`studentID`, S.`studentName`, C.`className` FROM `student` S 
JOIN `class` C ON S.`classID` = C.`classID`
WHERE C.`className` = 'A1';

-- Hiển thị điểm môn CF của các học viên
SELECT S.`studentID`, S.`studentName`, Sub.`subName`, M.`mark` FROM `student` S 
JOIN `mark` M ON S.`studentID` = M.`studentID` 
JOIN `subject` Sub ON M.`subID` = Sub.`subID`
WHERE Sub.`subName` = 'CF';

-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
SELECT `studentName` FROM `student`
WHERE `studentName` = 'H %';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12
SELECT S.`studentID`, S.`studentName` FROM `student` S
JOIN `class` C ON S.`classID` = C.`classID`
WHERE MONTH(C.`startDate`) = 12;

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5
SELECT `subName` FROM `subject`
WHERE 3 <= `credit` <= 5; 

-- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2
UPDATE `student` SET `classID` = 2
WHERE `studentName` = 'Hung';

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần, nếu trùng sắp theo tên tăng dần
SELECT S.`studentName`, SJ.`subName`, M.`mark` FROM `mark` M
JOIN `student` S ON M.`studentID` = S.`studentID`
JOIN `subject` SJ ON M.`subID` = SJ.`subID`
ORDER BY M.`mark` DESC;


