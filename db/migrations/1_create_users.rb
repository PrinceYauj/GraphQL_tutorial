# frozen_string_literal: true

Sequel.migration do

  up do 
    run '
      CREATE TABLE users (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100),
        email VARCHAR(100),
        karma INTEGER DEFAULT 0
      );
      CREATE UNIQUE INDEX name_idx ON users (LOWER(name));
      CREATE UNIQUE INDEX email_idx ON users (LOWER(email));

      CREATE OR REPLACE FUNCTION set_zero_karma() 
        RETURNS TRIGGER LANGUAGE PLPGSQL AS $$
      BEGIN
        RAISE NOTICE \'input row: (%)\', NEW;
        NEW.karma = 0;
        RAISE NOTICE \'final row: (%)\', NEW;
        RETURN NEW;
      END;
      $$;

      CREATE TRIGGER user_karma
        BEFORE INSERT ON users FOR EACH ROW
        EXECUTE FUNCTION set_zero_karma();
    '
  end

  down do
    run '
      DROP TRIGGER user_karma ON users;
      DROP FUNCTION set_zero_karma();
      DROP TABLE users;
    '
  end
end
