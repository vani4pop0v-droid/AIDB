ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

CREATE TABLE Messages (
	Message_ID NUMBER NOT NULL,
    Dialogue_ID NUMBER NOT NULL,
    Prompt VARCHAR(4095) NOT NULL,
    Answer VARCHAR(4096),
    PRIMARY KEY (Message_ID),
    FOREIGN KEY (Dialogue_ID) REFERENCES Dialogues(Dialogue_ID)
);

CREATE TABLE Dialogues (
    Dialogue_ID NUMBER NOT NULL,
    User_ID NUMBER NOT NULL,
    Model_name VARCHAR(100) NOT NULL,
    Dialog_Start_Date DATE NOT NULL
);

INSERT INTO Dialogues VALUES (1, 8800553535, 'GPT-4o', DATE '2026-01-10');
INSERT INTO Messages VALUES (1, 1, 'Запрос2', 'Ответ2');
