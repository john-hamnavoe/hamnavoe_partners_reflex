class CreateUserGridViewColumns < ActiveRecord::Migration[6.1]
  def change
    create_view :user_grid_view_columns
  end
end
