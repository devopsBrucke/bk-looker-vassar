view: week4_completadas {
 derived_table: {
  sql: SELECT
          COUNT(*) AS CantidadUsuariosSemana4,
          ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users_vassar), 2) AS PorcentajeUsuariosSemana4
      FROM
          users_vassar
      WHERE
          weeks_completed @> '[{"week_number": 4, "completed": true}]'
          AND NOT weeks_completed @> '[{"week_number": 5, "completed": true}]'
          AND weeks_completed @> '[{"week_number": 1, "completed": true}]'
          AND weeks_completed @> '[{"week_number": 2, "completed": true}]'
          AND weeks_completed @> '[{"week_number": 3, "completed": true}]' ;;
}

measure: count {
  type: count
  drill_fields: [detail*]
}

dimension: cantidadusuariossemana4 {
  type: number
  sql: ${TABLE}."cantidadusuariossemana4" ;;
}

dimension: porcentajeusuariossemana4 {
  type: number
  sql: ${TABLE}."porcentajeusuariossemana4" ;;
}

set: detail {
  fields: [
    cantidadusuariossemana4,
    porcentajeusuariossemana4
  ]
}
}
