# frozen_string_literal: true

Sequel.migration do
  up do
    run '
      CREATE TABLE blogs (
        id SERIAL PRIMARY KEY,
        user_id INTEGER REFERENCES users ON UPDATE RESTRICT ON DELETE CASCADE,
        name TEXT
      );

      CREATE FUNCTION forbid_fk_update()
        RETURNS TRIGGER LANGUAGE PLPGSQL AS $$
      BEGIN
        RAISE EXCEPTION \'attempt to update FK on table: (%)\', TG_TABLE_NAME;
      END;
      $$;

      CREATE TRIGGER blog_fk
        BEFORE UPDATE OF user_id ON blogs
        EXECUTE FUNCTION forbid_fk_update()
    '
  end

  down do
    run '
      DROP TRIGGER blog_fk ON blogs;
      DROP FUNCTION forbid_fk_update();
      DROP TABLE blogs;
    '
  end
end
