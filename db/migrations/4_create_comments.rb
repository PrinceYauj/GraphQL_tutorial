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

      CREATE OR REPLACE FUNCTION set_zero_comment_karma() 
        RETURNS TRIGGER LANGUAGE plpgsql AS $$ 
      BEGIN
        UPDATE comments SET karma = 0 
          WHERE id = (SELECT id FROM users ORDER BY id DESC LIMIT 1);
        RETURN NEW;
      END;
      $$; 

      CREATE TRIGGER comment_karma 
        AFTER INSERT ON comments FOR EACH ROW
        EXECUTE PROCEDURE set_zero_comment_karma();
    '
  end

  down do
    run '
      DROP TRIGGER comment_karma ON comments;
      DROP FUNCTION set_zero_comment_karma();
      DROP TABLE comments;
    '
  end

end

=begin

Sequel.migration do
  change do
    create_table(:comments) do
      primary_key :id
      foreign_key :post_id, :posts, on_update: :restrict, on_delete: :cascade
      foreign_key :user_id, :users, on_update: :restrict, on_delete: :cascade
      String :text
      Integer :karma
    end
  end
end

=end
