# frozen_string_literal: true

Sequel.migration do

  up do
    run '
      CREATE TABLE posts (
        id SERIAL PRIMARY KEY,
        blog_id INTEGER REFERENCES blogs ON UPDATE RESTRICT ON DELETE CASCADE,
        text TEXT
      );

      CREATE TRIGGER post_fk
        BEFORE UPDATE OF blog_id ON posts
        EXECUTE FUNCTION forbid_fk_update()
    '
  end

  down do
    run '
      DROP TRIGGER post_fk ON posts;
      DROP TABLE posts;
    '
  end
end
