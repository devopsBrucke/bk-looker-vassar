
view: totalusers {
  derived_table: {
    sql: SELECT COUNT(*) AS TotalRegistros
      FROM users_vassar ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: totalregistros {
    type: number
    sql: ${TABLE}."totalregistros" ;;
  }

  set: detail {
    fields: [
        totalregistros
    ]
  }
}
