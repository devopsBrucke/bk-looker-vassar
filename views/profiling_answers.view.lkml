view: profiling_answers {
  sql_table_name: public.profiling_answers ;;

  dimension: answer {
    type: string
    sql: ${TABLE}."answer" ;;
  }
  dimension: answer_id {
    type: number
    sql: ${TABLE}."answer_id" ;;
  }
  dimension: profiling_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."profiling_id" ;;
  }
  measure: count {
    type: count
    drill_fields: [profiling.profiling_id]
  }
}
