view: week1_completadas {
    derived_table: {
      sql: SELECT
          COUNT(*) AS CantidadUsuariosSemana1,
          ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM users_vassar), 2) AS PorcentajeUsuariosSemana1
      FROM
          users_vassar
      WHERE
          weeks_completed @> '[{"week_number": 1, "completed": true}]'
          AND NOT weeks_completed @> '[{"week_number": 2, "completed": true}]' ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: cantidadusuariossemana1 {
      type: number
      sql: ${TABLE}."cantidadusuariossemana1" ;;
    }

    dimension: porcentajeusuariossemana1 {
      type: number
      sql: ${TABLE}."porcentajeusuariossemana1" ;;
    }

    set: detail {
      fields: [
        cantidadusuariossemana1,
        porcentajeusuariossemana1
      ]
    }
}
