REATE OR REPLACE PROCEDURE generate_data IS

    v_worker_count  CONSTANT NUMBER := 20;
    v_client_count  CONSTANT NUMBER := 200;
    v_dialogue_count CONSTANT NUMBER := 1000;

    v_user_id      NUMBER;
    v_model_id     NUMBER;
    v_dialogue_id  NUMBER;
    v_prompt_id    NUMBER;

    v_users_needed NUMBER;

BEGIN

    pkg_llm_service.add_ai_model(0.5,  'GPT-4o',     'https://api.openai.com/v1');
    pkg_llm_service.add_ai_model(0.3,  'Claude-3',   'https://api.anthropic.com/v1');
    pkg_llm_service.add_ai_model(0.2,  'LLaMA-3',    'https://api.meta.com/v1');
    pkg_llm_service.add_ai_model(0.4,  'Gemini-Pro', 'https://api.google.com/v1');
    pkg_llm_service.add_ai_model(0.1,  'Mistral-7B', 'https://api.mistral.ai/v1');

    FOR i IN 1 .. v_worker_count LOOP
        pkg_llm_service.add_user(
            p_login    => 'worker_' || i,
            p_password => 'wpass_' || i,
            p_email    => 'worker_' || i || '@company.ru',
            p_tokens   => TO_CHAR(10000 * i)
        );
    END LOOP;

    FOR i IN 1 .. v_client_count LOOP
        pkg_llm_service.add_user(
            p_login    => 'client_' || i,
            p_password => 'cpass_' || i,
            p_email    => 'client_' || i || '@mail.ru',
            p_tokens   => TO_CHAR(1000 * i)
        );
    END LOOP;

    FOR i IN 1 .. v_dialogue_count LOOP

        SELECT User_ID
          INTO v_user_id
          FROM (
              SELECT User_ID
                FROM Users
               WHERE User_login LIKE 'client_%'
               ORDER BY DBMS_RANDOM.VALUE
          )
         WHERE ROWNUM = 1;

        SELECT Model_ID
          INTO v_model_id
          FROM (
              SELECT Model_ID
                FROM AI_models
               ORDER BY DBMS_RANDOM.VALUE
          )
         WHERE ROWNUM = 1;

        pkg_llm_service.add_dialogue(
            p_name       => 'Диалог:' || i || '_' || TO_CHAR(SYSDATE, 'HH24MISS'),
            p_user_id    => v_user_id,
            p_model_id   => v_model_id,
            p_start_date => DATE '2026-01-01' + MOD(i, 365)
        );

        SELECT MAX(Dialogue_ID) INTO v_dialogue_id FROM Dialogue;

        pkg_llm_service.add_prompt(
            p_prompt_order => 1,
            p_dialogue_id  => v_dialogue_id,
            p_message_text => 'Промпт:' || i || ' (уникальный)',
            p_creation     => DATE '2026-01-01' + MOD(i, 365)
        );

        SELECT MAX(Prompt_ID) INTO v_prompt_id FROM Prompt;

        pkg_llm_service.add_answer(
            p_answer_text  => 'Ответ нейросети:' || i || ' (уникальный)',
            p_creation     => DATE '2026-01-01' + MOD(i, 365),
            p_answer_order => 1,
            p_prompt_id    => v_prompt_id
        );

    END LOOP;

    COMMIT;

END generate_data;
/

BEGIN
    generate_data;
END;
/

SELECT COUNT(*) AS workers  FROM Users WHERE User_login LIKE 'worker_%';
SELECT COUNT(*) AS clients  FROM Users WHERE User_login LIKE 'client_%';
SELECT COUNT(*) AS dialogues FROM Dialogue;
SELECT COUNT(*) AS prompts  FROM Prompt;
SELECT COUNT(*) AS answers  FROM Answer;