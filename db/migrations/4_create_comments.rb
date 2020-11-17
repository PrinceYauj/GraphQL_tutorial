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
        EXECUTE PROCEDURE set_zero_karma();
    '
  end

  down do
    run '
      DROP TRIGGER comment_karma ON comments;
      DROP FUNCTION set_zero_karma();
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
