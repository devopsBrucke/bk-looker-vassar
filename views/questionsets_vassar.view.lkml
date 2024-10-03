view: questionsets_vassar {
  sql_table_name: public.questionsets_vassar ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }
  dimension: questions {
    type: string
    sql: ${TABLE}."questions" ;;
  }
  dimension: week {
    type: number
    sql: ${TABLE}."week" ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
