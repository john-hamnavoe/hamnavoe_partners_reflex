SELECT grid_view_columns.id,
       grid_views.grid_id,
       grid_views.user_id,
       grid_view_columns.column_id,
       grid_view_columns.position,
       columns.sortable,
       columns.name,
       columns.label,
       columns.field, 
       columns.object_1,
       columns.object_2
  FROM grid_view_columns
       INNER JOIN grid_views
                  ON grid_view_columns.grid_view_id = grid_views.id
       INNER JOIN columns
                  ON grid_view_columns.column_id = columns.id   