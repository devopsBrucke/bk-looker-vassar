view: edad_mas_repetida {
  derived_table: {
    sql: SELECT
          CASE
            WHEN age = 'null' OR age IS NULL THEN 'No definida'
            ELSE age
          END AS Edad,
          COUNT(*) AS Cantidad
      FROM
          users_vassar
      GROUP BY
          CASE
            WHEN age = 'null' OR age IS NULL THEN 'No definida'
            ELSE age
          END
      ORDER BY
          COUNT(*) DESC
      LIMIT 1 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: edad {
    type: string
    sql: ${TABLE}."edad" ;;
    description: "Edad más repetida o 'No definida' si es NULL o 'null'"
  }

  dimension: cantidad {
    type: number
    sql: ${TABLE}."cantidad" ;;
    description: "Cantidad de usuarios con la edad más repetida"
  }

  set: detail {
    fields: [
      edad,
      cantidad
    ]
  }
}
