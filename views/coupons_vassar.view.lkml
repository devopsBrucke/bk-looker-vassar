view: coupons_vassar {
  sql_table_name: public.coupons_vassar ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }
  dimension: code {
    type: string
    sql: ${TABLE}."code" ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
