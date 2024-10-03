view: session_vassar {
  sql_table_name: public.session_vassar ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }
  dimension: sender {
    type: string
    sql: ${TABLE}."sender" ;;
  }
  dimension: session_id {
    type: string
    sql: ${TABLE}."session_id" ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
