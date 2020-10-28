# frozen_string_literal: true

Sequel.migration do

  up do
    run '
      CREATE TABLE posts (
        id SERIAL PRIMARY KEY,
        blog_id INTEGER REFERENCES blogs ON UPDATE RESTRICT ON DELETE CASCADE,
        text TEXT
      );
    '
  end

  down do
    run 'DROP TABLE posts;'
  end

end


=begin

Sequel.migration do
  change do
    create_table(:posts) do
      primary_key :id
      foreign_key :blog_id, :blogs, on_update: :restrict, on_delete: :cascade
      String :text
    end
  end
end

=end