# frozen_string_literal: true

Sequel.migration do
  up do
    run '
      CREATE PROCEDURE comment_karma_recount()
        LANGUAGE PLPGSQL AS $$
      BEGIN
        UPDATE comments
        SET karma = (
          SELECT SUM (value)
          FROM reactions
          WHERE comment_id = comments.id
        );
      END;
      $$;

      CREATE PROCEDURE user_karma_recount()
        LANGUAGE PLPGSQL AS $$
      BEGIN
        CALL comment_karma_recount();
        WITH sums AS (
          SELECT user_id, SUM(karma)
          FROM comments
          GROUP BY user_id
        )
        UPDATE users
        SET karma = sum
        FROM sums
        WHERE id = user_id;
      END;
      $$;
    '
  end

  down do
    run '
      DROP PROCEDURE user_karma_recount();
      DROP PROCEDURE comment_karma_recount();
    '
  end
end
