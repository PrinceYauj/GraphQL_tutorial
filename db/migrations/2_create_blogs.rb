# frozen_string_literal: true

Sequel.migration do

  up do
    run '
      CREATE TABLE blogs (
        id SERIAL PRIMARY KEY,
        user_id INTEGER REFERENCES users ON UPDATE RESTRICT ON DELETE CASCADE,
        name TEXT
      );
    '
  end

  down do
    run 'DROP TABLE blogs;'
  end

end

=begin

Sequel.migration do
  change do
    create_table(:blogs) do
      primary_key :id
      foreign_key :user_id, :users, on_update: :restrict, on_delete: :cascade
      String :name
    end
  end
end

=end
