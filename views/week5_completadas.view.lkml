view: week5_completadas {
  derived_table: {
    sql: SELECT
          COUNT(*) AS CantidadUsuariosSemana5,
          ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users_vassar), 2) AS PorcentajeUsuariosSemana5
      FROM
          users_vassar
      WHERE
          weeks_completed @> '[{"week_number": 5, "completed": true}]'
          AND weeks_completed @> '[{"week_number": 1, "completed": true}]'
          AND weeks_completed @> '[{"week_number": 2, "completed": true}]'
          AND weeks_completed @> '[{"week_number": 3, "completed": true}]'
          AND weeks_completed @> '[{"week_number": 4, "completed": true}]' ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: cantidadusuariossemana5 {
    type: number
    sql: ${TABLE}."cantidadusuariossemana5" ;;
  }

  dimension: porcentajeusuariossemana5 {
    type: number
    sql: ${TABLE}."porcentajeusuariossemana5" ;;
  }

  set: detail {
    fields: [
      cantidadusuariossemana5,
      porcentajeusuariossemana5
    ]
  }
}
