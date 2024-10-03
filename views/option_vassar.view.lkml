view: option_vassar {
  sql_table_name: public.Option_vassar ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }
  dimension: letter {
    type: string
    sql: ${TABLE}."letter" ;;
  }
  dimension: text {
    type: string
    sql: ${TABLE}."text" ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
