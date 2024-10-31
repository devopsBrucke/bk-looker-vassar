view: week2_completadas {
 derived_table: {
  sql: SELECT
          COUNT(*) AS CantidadUsuariosSemana2,
          ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users_vassar), 2) AS PorcentajeUsuariosSemana2
      FROM
          users_vassar
      WHERE
          weeks_completed @> '[{"week_number": 2, "completed": true}]'
          AND NOT weeks_completed @> '[{"week_number": 3, "completed": true}]'
          AND weeks_completed @> '[{"week_number": 1, "completed": true}]' ;;
}

measure: count {
  type: count
  drill_fields: [detail*]
}

dimension: cantidadusuariossemana2 {
  type: number
  sql: ${TABLE}."cantidadusuariossemana2" ;;
}

dimension: porcentajeusuariossemana2 {
  type: number
  sql: ${TABLE}."porcentajeusuariossemana2" ;;
}

set: detail {
  fields: [
    cantidadusuariossemana2,
    porcentajeusuariossemana2
  ]
}
}
