GRANT EXECUTE ON FUNCTION md5(text) TO message_store;
GRANT EXECUTE ON FUNCTION message_store.gen_random_uuid() TO message_store;
GRANT EXECUTE ON FUNCTION message_store.hash_64(varchar) TO message_store;
GRANT EXECUTE ON FUNCTION message_store.category(varchar) TO message_store;
GRANT EXECUTE ON FUNCTION message_store.stream_version(varchar) TO message_store;
GRANT EXECUTE ON FUNCTION message_store.write_message(varchar, varchar, varchar, jsonb, jsonb, bigint) TO message_store;
GRANT EXECUTE ON FUNCTION message_store.get_stream_messages(varchar, bigint, bigint, varchar) TO message_store;
GRANT EXECUTE ON FUNCTION message_store.get_category_messages(varchar, bigint, bigint, varchar, bigint, bigint, varchar) TO message_store;
GRANT EXECUTE ON FUNCTION message_store.get_last_stream_message(varchar) TO message_store;
