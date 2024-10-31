view: profiling {
  sql_table_name: public.profiling ;;
  drill_fields: [profiling_id]

  dimension: profiling_id {
    primary_key: yes
    type: number
    sql: ${TABLE}."profiling_id" ;;
  }
  dimension: citizen_id {
    type: string
    sql: ${TABLE}."citizen_id" ;;
  }
  dimension: question {
    type: string
    sql: ${TABLE}."question" ;;
  }
  measure: count {
    type: count
    drill_fields: [profiling_id, profiling_answers.count]
  }
}
