view: weeks_completed {
  sql_table_name: public.weeks_completed ;;

  dimension: citizen_id {
    type: string
    sql: ${TABLE}."citizen_id" ;;
  }
  dimension: completed {
    type: yesno
    sql: ${TABLE}."completed" ;;
  }
  dimension: week_id {
    type: number
    sql: ${TABLE}."week_id" ;;
  }
  dimension: week_number {
    type: number
    sql: ${TABLE}."week_number" ;;
  }
  measure: count {
    type: count
  }
}
