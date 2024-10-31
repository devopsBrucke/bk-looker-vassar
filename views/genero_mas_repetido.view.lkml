view: genero_mas_repetido {
  derived_table: {
    sql: SELECT
          gender AS Genero,
          COUNT(*) AS Cantidad
      FROM
          users_vassar
      GROUP BY
          gender
      ORDER BY
          COUNT(*) DESC
      LIMIT 1 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: genero {
    type: string
    sql: ${TABLE}."genero" ;;
  }

  dimension: cantidad {
    type: number
    sql: ${TABLE}."cantidad" ;;
  }

  set: detail {
    fields: [
      genero,
      cantidad
    ]
  }
  }
