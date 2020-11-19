# frozen_string_literal: true

Sequel.migration do
  up do
    run '
      CREATE TABLE comments (
        id SERIAL PRIMARY KEY,
        post_id INTEGER REFERENCES posts ON UPDATE RESTRICT ON DELETE CASCADE,
        user_id INTEGER REFERENCES users ON UPDATE RESTRICT ON DELETE CASCADE,
        text TEXT,
        karma INTEGER DEFAULT 0
      );

      CREATE TRIGGER comment_karma
        BEFORE INSERT ON comments FOR EACH ROW
        EXECUTE FUNCTION set_zero_karma();

      CREATE TRIGGER comment_fk
        BEFORE UPDATE OF post_id, user_id ON comments
        EXECUTE FUNCTION forbid_fk_update()
    '
  end

  down do
    run '
      DROP TRIGGER comment_fk ON comments;
      DROP TRIGGER comment_karma ON comments;
      DROP TABLE comments;
    '
  end
end
