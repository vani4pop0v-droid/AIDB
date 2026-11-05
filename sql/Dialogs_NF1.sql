ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

CREATE TABLE Messages (
    Dialogue_ID NUMBER NOT NULL,
    Prompt_Order NUMBER NOT NULL,
    User_ID NUMBER NOT NULL,
    Dialog_Start_Date DATE NOT NULL,
    Model_id NUMBER NOT NULL,
    Prompt VARCHAR(4096) NOT NULL,
    Answer VARCHAR(4096) NOT NULL,
    PRIMARY KEY (Dialogue_ID, Prompt_Order)
    );
    
INSERT INTO Messages VALUES (1, 101, 8800553535, DATE '2026-01-10', 'GPT-4o', 1, 'Запрос1', 'Ответ1');
INSERT INTO Messages VALUES (1, 101, 8800553535, DATE '2026-01-10', 'GPT-4o', 2, 'Запрос2', 'Ответ2');
INSERT INTO Messages VALUES (2, 102, 2932029358. DATE '2026-01-11', 'Claude-3', 1, 'Хз, запрос в другом чате', 'Ответ в другом чате');