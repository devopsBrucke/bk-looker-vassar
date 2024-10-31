view: edad_mas_repetida {
  derived_table: {
    sql: SELECT
          age AS Edad,
          COUNT(*) AS Cantidad
      FROM
          users_vassar
      GROUP BY
          age
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
  }

  dimension: cantidad {
    type: number
    sql: ${TABLE}."cantidad" ;;
  }

  set: detail {
    fields: [
      edad,
      cantidad
    ]
  }
  }
