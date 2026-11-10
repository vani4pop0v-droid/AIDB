CREATE TABLE Users (
    User_ID	NUMBER,
    User_login VARCHAR(100),
    User_password VARCHAR(100),
    User_email VARCHAR(100),
    Number_of_tokens VARCHAR(4096),
    PRIMARY KEY (User_ID)
);

CREATE TABLE AI_models (
	Model_ID NUMBER,
	Model_cost NUMBER,
	Model_name VARCHAR(100),
	Model_adress VARCHAR(255),
	PRIMARY KEY (Model_ID)
);

CREATE TABLE Dialogue (
	Dialogue_ID	NUMBER,
	Dialogue_name VARCHAR(4096),
	User_ID NUMBER,
	Model_ID NUMBER,
	Dialog_Start_Date DATE,
	PRIMARY KEY (Dialogue_ID),
	FOREIGN KEY (User_ID) REFERENCES Users(User_ID), 
	FOREIGN KEY (Model_ID) REFERENCES AI_models(Model_ID)
);

CREATE TABLE Prompt (
	Prompt_ID NUMBER,
	Prompt_Order NUMBER,
	Dialogue_ID NUMBER,
	Message_text VARCHAR(4096),
	Creation_date DATE,
	PRIMARY KEY (Prompt_ID),
	FOREIGN KEY (Dialogue_ID) REFERENCES Dialogue(Dialogue_ID)
);

CREATE TABLE Answer (
	Answer_ID NUMBER,
	Answer_text VARCHAR(4096),
	Creation_date DATE,
	Abswer_order NUMBER,
	Prompt_ID NUMBER,
	PRIMARY KEY (Answer_ID),
	FOREIGN KEY (Prompt_ID) REFERENCES Prompt(Prompt_ID)
);

INSERT INTO Users VALUES (1);
INSERT INTO AI_models VALUES (1);
INSERT INTO Dialogue VALUES(1, 1, 1, '2026-01-10');
INSERT INTO Prompt VALUES (1);
INSERT INTO Prompt VALUES (1, 1, 1, "Типо промпт 1");
INSERT INTO Answer VALUES (1, "Типо ответ от нейронки");
