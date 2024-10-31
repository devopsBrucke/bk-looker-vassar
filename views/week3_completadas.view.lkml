view: week3_completadas {
   derived_table: {
    sql: SELECT
          COUNT(*) AS CantidadUsuariosSemana3,
          ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users_vassar), 2) AS PorcentajeUsuariosSemana3
      FROM
          users_vassar
      WHERE
          weeks_completed @> '[{"week_number": 3, "completed": true}]'
          AND NOT weeks_completed @> '[{"week_number": 4, "completed": true}]'
          AND weeks_completed @> '[{"week_number": 1, "completed": true}]'
          AND weeks_completed @> '[{"week_number": 2, "completed": true}]' ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: cantidadusuariossemana3 {
    type: number
    sql: ${TABLE}."cantidadusuariossemana3" ;;
  }

  dimension: porcentajeusuariossemana3 {
    type: number
    sql: ${TABLE}."porcentajeusuariossemana3" ;;
  }

  set: detail {
    fields: [
      cantidadusuariossemana3,
      porcentajeusuariossemana3
    ]
  }
}
