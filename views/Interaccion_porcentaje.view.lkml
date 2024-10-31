view: interaccion_porcentaje {
  derived_table: {
    sql: SELECT
          CASE
            WHEN phone IN (
                SELECT phone
                FROM users_vassar,
                jsonb_array_elements(weeks_completed) AS week
                WHERE week->>'completed' = 'true'
                GROUP BY phone
                HAVING COUNT(*) = 5
            ) THEN 'Completaron 5 Semanas'
            ELSE 'No Completaron 5 Semanas'
          END AS dimension,
          COUNT(DISTINCT phone) AS total
      FROM
          users_vassar
      GROUP BY
          dimension ;;
  }

  dimension: dimension {
    type: string
    sql: ${TABLE}.dimension ;;
  }

  measure: total {
    type: sum
    sql: ${TABLE}.total ;;
  }
}
