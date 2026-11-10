ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

CREATE SEQUENCE seq_users_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ai_models_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_prompt_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_answer_id START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PACKAGE pkg_llm_service AS

    FUNCTION get_new_dialogue_id RETURN NUMBER;

    PROCEDURE add_user(
        p_login    IN VARCHAR2,
        p_password IN VARCHAR2,
        p_email    IN VARCHAR2,
        p_tokens   IN VARCHAR2
    );

    PROCEDURE add_ai_model(
        p_cost    IN NUMBER,
        p_name    IN VARCHAR2,
        p_address IN VARCHAR2
    );

    PROCEDURE add_prompt(
        p_prompt_order IN NUMBER,
        p_dialogue_id  IN NUMBER,
        p_message_text IN VARCHAR2,
        p_creation     IN DATE
    );

    PROCEDURE add_answer(
        p_answer_text  IN VARCHAR2,
        p_creation     IN DATE,
        p_answer_order IN NUMBER,
        p_prompt_id    IN NUMBER
    );

    PROCEDURE add_dialogue(
        p_name       IN VARCHAR2,
        p_user_id    IN NUMBER,
        p_model_id   IN NUMBER,
        p_start_date IN DATE
    );

END pkg_llm_service;
/

CREATE OR REPLACE PACKAGE BODY pkg_llm_service AS

    FUNCTION get_new_dialogue_id RETURN NUMBER IS
        v_max_id NUMBER;
    BEGIN
        SELECT NVL(MAX(Dialogue_ID), 0) INTO v_max_id
          FROM Dialogue;
        RETURN v_max_id + 1;
    END get_new_dialogue_id;

    PROCEDURE add_user(
        p_login    IN VARCHAR2,
        p_password IN VARCHAR2,
        p_email    IN VARCHAR2,
        p_tokens   IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Users (User_ID, User_login, User_password, User_email, Number_of_tokens)
        VALUES (seq_users_id.NEXTVAL, p_login, p_password, p_email, p_tokens);
        COMMIT;
    END add_user;

    PROCEDURE add_ai_model(
        p_cost    IN NUMBER,
        p_name    IN VARCHAR2,
        p_address IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO AI_models (Model_ID, Model_cost, Model_name, Model_adress)
        VALUES (seq_ai_models_id.NEXTVAL, p_cost, p_name, p_address);
        COMMIT;
    END add_ai_model;

    PROCEDURE add_prompt(
        p_prompt_order IN NUMBER,
        p_dialogue_id  IN NUMBER,
        p_message_text IN VARCHAR2,
        p_creation     IN DATE
    ) IS
    BEGIN
        INSERT INTO Prompt (Prompt_ID, Prompt_Order, Dialogue_ID, Message_text, Creation_date)
        VALUES (seq_prompt_id.NEXTVAL, p_prompt_order, p_dialogue_id, p_message_text, p_creation);
        COMMIT;
    END add_prompt;

    PROCEDURE add_answer(
        p_answer_text  IN VARCHAR2,
        p_creation     IN DATE,
        p_answer_order IN NUMBER,
        p_prompt_id    IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Answer (Answer_ID, Answer_text, Creation_date, Answer_order, Prompt_ID)
        VALUES (seq_answer_id.NEXTVAL, p_answer_text, p_creation, p_answer_order, p_prompt_id);
        COMMIT;
    END add_answer;

    PROCEDURE add_dialogue(
        p_name       IN VARCHAR2,
        p_user_id    IN NUMBER,
        p_model_id   IN NUMBER,
        p_start_date IN DATE
    ) IS
    BEGIN
        INSERT INTO Dialogue (Dialogue_ID, Dialogue_name, User_ID, Model_ID, Dialog_Start_Date)
        VALUES (get_new_dialogue_id, p_name, p_user_id, p_model_id, p_start_date);
        COMMIT;
    END add_dialogue;

END pkg_llm_service;
/

CREATE OR REPLACE VIEW v_dialogue_info AS
SELECT
    d.Dialogue_ID,
    d.Dialogue_name,
    d.Dialog_Start_Date,
    u.User_ID,
    u.User_login,
    u.User_email,
    m.Model_ID,
    m.Model_name,
    m.Model_cost,
    (SELECT COUNT(*) FROM Prompt p WHERE p.Dialogue_ID = d.Dialogue_ID) AS Prompts_Count
FROM
    Dialogue d
JOIN
    Users     u ON u.User_ID  = d.User_ID
JOIN
    AI_models m ON m.Model_ID = d.Model_ID;

BEGIN
    pkg_llm_service.add_user('Яхзчелкакойто', 'МегаУльтраПароль12345', 'toober2007@gmail.ru', '100000');
    pkg_llm_service.add_ai_model(0.5, 'GPT-4o', 'https://api.openai.com/v1');
    pkg_llm_service.add_dialogue('', 1, 1, DATE '2026-01-10');
    pkg_llm_service.add_prompt(1, 1, 'Запрос1', DATE '2026-01-10');
    pkg_llm_service.add_answer('Ответ1', DATE '2026-01-10', 1, 1);
END;