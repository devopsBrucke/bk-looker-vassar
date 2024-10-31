view: ciudad_mas_repetida {
  derived_table: {
    sql: SELECT
          city AS Ciudad,
          COUNT(*) AS Cantidad
      FROM
          users_vassar
      GROUP BY
          city
      ORDER BY
          COUNT(*) DESC
      LIMIT 1 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: ciudad {
    type: string
    sql: ${TABLE}."ciudad" ;;
  }

  dimension: cantidad {
    type: number
    sql: ${TABLE}."cantidad" ;;
  }

  set: detail {
    fields: [
      ciudad,
      cantidad
    ]
  }
  }
