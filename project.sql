CREATE DATABASE IF NOT EXISTS SurgeTechConference_DB;

USE SurgeTechConference_DB;

CREATE TABLE IF NOT EXISTS Attendee (
    idAttendee INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(30) NOT NULL,
    lastName VARCHAR(30) NOT NULL,
    phone INT,
    email VARCHAR(30),
    vip BOOLEAN DEFAULT(0)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS Company (
    idCompany INT AUTO_INCREMENT PRIMARY KEY,
    idPrimaryContactAttendee INT NOT NULL,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(60) NOT NULL,
    FOREIGN KEY (idPrimaryContactAttendee) REFERENCES Attendee(idAttendee)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS Presentation (
    idPresentation INT AUTO_INCREMENT PRIMARY KEY,
    idBookedCompany INT NOT NULL,
    idBookedRoom INT NOT NULL,
    startTime TIME,
    endTime TIME,
    FOREIGN KEY (idBookedCompany) REFERENCES Company(idCompany),
    FOREIGN KEY (idBookedRoom) REFERENCES Room(idBookedRoom)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS Room (
    idRoom INT AUTO_INCREMENT PRIMARY KEY,
    floorNumber INT NOT NULL,
    seatCapacity INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS PresentationAttendance (
    idTicket INT AUTO_INCREMENT PRIMARY KEY,
    idPresentation INT,
    idAttendee INT,
    FOREIGN KEY (idPresentation) REFERENCES Presentation(idPresentation),
    FOREIGN KEY (idAttendee) REFERENCES Attendee(idAttendee)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE VIEW Presentation_VW AS
    SELECT Company.name AS BookedCompany,
           Room.idRoom AS RoomNumber,
           Room.floorNumber AS Floor,
           Room.seatCapacity AS Seats,
           startTime,
           endTime
    FROM Presentation
         INNER JOIN Company ON Presentation.idBookedCompany = Company.idCompany
         INNER JOIN Room ON Presentation.idBookedRoom = Room.idRoom;

SELECT * FROM Presentation_VW WHERE seatCapacity >= 30;

INSERT INTO Attendee (firstName, lastName) VALUES ('Thais', 'Tavares');

SELECT * FROM Attendee;