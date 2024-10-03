view: questions_vassar {
  sql_table_name: public.questions_vassar ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }
  dimension: allow_multiple_selections {
    type: yesno
    sql: ${TABLE}."allowMultipleSelections" ;;
  }
  dimension: correct_answers {
    type: string
    sql: ${TABLE}."correct_answers" ;;
  }
  dimension: is_profiling {
    type: yesno
    sql: ${TABLE}."isProfiling" ;;
  }
  dimension: options {
    type: string
    sql: ${TABLE}."options" ;;
  }
  dimension: question {
    type: string
    sql: ${TABLE}."question" ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
