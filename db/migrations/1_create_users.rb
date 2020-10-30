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

      CREATE OR REPLACE FUNCTION set_zero_user_karma() 
        RETURNS TRIGGER LANGUAGE PLPGSQL AS $$
      BEGIN
        UPDATE users SET karma = 0 
          WHERE id = (SELECT id FROM users ORDER BY id DESC LIMIT 1);
        RETURN NEW;
      END;
      $$;

      CREATE TRIGGER user_karma
        AFTER INSERT ON users FOR EACH ROW
        EXECUTE PROCEDURE set_zero_user_karma();
    '
  end

  down do
    run '
      DROP TRIGGER user_karma ON users;
      DROP FUNCTION set_zero_user_karma();
      DROP TABLE users;
    '
  end

end

=begin
Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :name
      index :name, unique: true
      String :email
      index :email, unique: true
      Integer :karma, default: 0
    end
  end
end
=end
