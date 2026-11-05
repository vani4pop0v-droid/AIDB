ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

CREATE TABLE LLM_Service (
    User_ID NUMBER,
    Dialogue_ID NUMBER,
    Dialog_Start_Date DATE,
    Model_name VARCHAR(100),
    Prompt_Order NUMBER,
    Prompt VARCHAR(4096),
    Answer VARCHAR(4096) 
)

INSERT INTO LLM_Service VALUES (1, 101, DATE '2026-01-10', 'GPT-4o', 1, 'Запрос1', 'Ответ1');
INSERT INTO LLM_Service VALUES (1, 101, DATE '2026-01-10', 'GPT-4o', 2, 'Запрос2', 'Ответ2');
INSERT INTO LLM_Service VALUES (2, 102, DATE '2026-01-11', 'Claude-3', 1, 'Хз, запрос в другом чате', 'Ответ в другом чате');