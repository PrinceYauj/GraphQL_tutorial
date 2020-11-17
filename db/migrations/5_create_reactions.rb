# frozen_string_literal: true

Sequel.migration do

  up do 
    run '
      CREATE TABLE reactions (
        id SERIAL PRIMARY KEY,
        comment_id INTEGER REFERENCES comments
          ON UPDATE RESTRICT ON DELETE CASCADE,
        user_id INTEGER REFERENCES users ON UPDATE RESTRICT ON DELETE CASCADE,
        CONSTRAINT unique_comment_user UNIQUE (comment_id, user_id),
        value SMALLINT CHECK (value = -1 OR value = 0 OR value = 1) NOT NULL
      );

      CREATE TRIGGER reaction_fk
        BEFORE UPDATE OF comment_id, user_id ON reactions
        EXECUTE FUNCTION forbid_fk_update()
    '
  end

  down do
    run '
      DROP TRIGGER reaction_fk ON reactions;
      DROP TABLE reactions;
    '
  end
end
