view: usuarios_por_semana {
  derived_table: {
    sql:
      WITH total_usuarios AS (
        SELECT COUNT(*) AS total FROM users_vassar
      ),
      semanas AS (
        SELECT 1 AS semana UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
      ),
      usuarios_por_semana AS (
        SELECT
          s.semana,
          COUNT(DISTINCT u.citizen_id) AS cantidad_usuarios
        FROM
          semanas s
        LEFT JOIN users_vassar u ON 1=1
        LEFT JOIN weeks_completed wc1 ON u.citizen_id = wc1.citizen_id AND wc1.week_number = 1 AND wc1.completed = true
        LEFT JOIN weeks_completed wc2 ON u.citizen_id = wc2.citizen_id AND wc2.week_number = 2 AND wc2.completed = true
        LEFT JOIN weeks_completed wc3 ON u.citizen_id = wc3.citizen_id AND wc3.week_number = 3 AND wc3.completed = true
        LEFT JOIN weeks_completed wc4 ON u.citizen_id = wc4.citizen_id AND wc4.week_number = 4 AND wc4.completed = true
        LEFT JOIN weeks_completed wc5 ON u.citizen_id = wc5.citizen_id AND wc5.week_number = 5 AND wc5.completed = true
        WHERE
          (s.semana = 1 AND wc1.week_number = 1 AND (wc2.week_number IS NULL OR wc2.completed = false))
          OR
          (s.semana = 2 AND wc1.week_number = 1 AND wc2.week_number = 2 AND (wc3.week_number IS NULL OR wc3.completed = false))
          OR
          (s.semana = 3 AND wc1.week_number = 1 AND wc2.week_number = 2 AND wc3.week_number = 3 AND (wc4.week_number IS NULL OR wc4.completed = false))
          OR
          (s.semana = 4 AND wc1.week_number = 1 AND wc2.week_number = 2 AND wc3.week_number = 3 AND wc4.week_number = 4 AND (wc5.week_number IS NULL OR wc5.completed = false))
        GROUP BY
          s.semana
      )
      SELECT
        s.semana,
        COALESCE(up.cantidad_usuarios, 0) AS cantidad_usuarios,
        ROUND(COALESCE(up.cantidad_usuarios, 0) * 100.0 / t.total, 2) AS porcentaje_usuarios
      FROM
        semanas s
      LEFT JOIN
        usuarios_por_semana up ON s.semana = up.semana
      CROSS JOIN
        total_usuarios t
      ORDER BY
        s.semana ;;
  }

  dimension: semana {
    type: number
    sql: ${TABLE}.semana ;;
    description: "Semana en la que los usuarios se quedaron"
  }

  dimension: cantidad_usuarios {
    type: number
    sql: ${TABLE}.cantidad_usuarios ;;
    description: "Cantidad de usuarios que se quedaron en la semana"
  }

  dimension: porcentaje_usuarios {
    type: number
    sql: ${TABLE}.porcentaje_usuarios ;;
    value_format: "0.00\%"
    description: "Porcentaje de usuarios que se quedaron en la semana"
  }
}
