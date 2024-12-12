view: usuarios_por_semana {
  derived_table: {
    sql:
      SELECT
        phone,
        week_number,
        completed
      FROM
        weeks_completed
      WHERE
        week_number IN (1, 2)
    ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: week_number {
    type: number
    sql: ${TABLE}.week_number ;;
  }

  dimension: completed {
    type: yesno
    sql: ${TABLE}.completed ;;
  }

  measure: cantidad_usuarios_semana_1 {
    type: count
    filters: { field: week_number value: "1" }
  }

  measure: usuarios_completaron_semana_1 {
    type: count
    filters: [
      week_number: "1",
      completed: "true"
    ]
  }

  measure: usuarios_no_completaron_semana_1 {
    type: count
    filters: [
      week_number: "1",
      completed: "false"
    ]
  }


  measure: cantidad_usuarios_semana_2 {
    type: count
    filters: { field: week_number value: "2" }
  }

  measure: usuarios_completaron_semana_2 {
    type: count
    filters: [
      week_number: "1",
      completed: "true"
    ]
  }

  measure: usuarios_no_completaron_semana_2 {
    type: count
    filters: [
      week_number: "1",
      completed: "false"
    ]
  }

}
