CREATE OR REPLACE FUNCTION write_message(
  id varchar,
  stream_name varchar,
  "type" varchar,
  data jsonb,
  metadata jsonb DEFAULT NULL,
  expected_version bigint DEFAULT NULL
)
RETURNS bigint
AS $$
DECLARE
  _message_id uuid;
  _stream_version bigint;
  _next_position bigint;
  _category varchar;
  _category_name_hash bigint;
BEGIN
  _message_id = uuid(write_message.id);

  _category := category(write_message.stream_name);
  _category_name_hash := hash_64(_category);
  PERFORM pg_advisory_xact_lock(_category_name_hash);

  _stream_version := stream_version(write_message.stream_name);

  if _stream_version is null then
    _stream_version := -1;
  end if;

  if write_message.expected_version is not null then
    if write_message.expected_version != _stream_version then
      RAISE EXCEPTION
        'Wrong expected version: % (Stream: %, Stream Version: %)',
        write_message.expected_version,
        write_message.stream_name,
        _stream_version;
    end if;
  end if;

  _next_position := _stream_version + 1;

  INSERT INTO messages
    (
      id,
      stream_name,
      position,
      type,
      data,
      metadata
    )
  VALUES
    (
      _message_id,
      write_message.stream_name,
      _next_position,
      write_message.type,
      write_message.data,
      write_message.metadata
    )
  ;

  if current_setting('message_store.debug_write', true) = 'on' OR current_setting('message_store.debug', true) = 'on' then
    RAISE NOTICE '* write_message';
    RAISE NOTICE 'id ($1): %', write_message.id;
    RAISE NOTICE 'stream_name ($2): %', write_message.stream_name;
    RAISE NOTICE 'type ($3): %', write_message.type;
    RAISE NOTICE 'data ($4): %', write_message.data;
    RAISE NOTICE 'metadata ($5): %', write_message.metadata;
    RAISE NOTICE 'expected_version ($6): %', write_message.expected_version;
    RAISE NOTICE '_category: %', _category;
    RAISE NOTICE '_category_name_hash: %', _category_name_hash;
    RAISE NOTICE '_stream_version: %', _stream_version;
    RAISE NOTICE '_next_position: %', _next_position;
  end if;

  return _next_position;
END;
$$ LANGUAGE plpgsql
VOLATILE;
