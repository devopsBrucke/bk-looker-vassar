view: users_vassar {
  sql_table_name: public.users_vassar ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."id" ;;
  }
  dimension: age {
    type: string
    sql: ${TABLE}."age" ;;
  }
  dimension: citizen_id {
    type: string
    sql: ${TABLE}."citizen_id" ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}."city" ;;
  }
  dimension: complete_conversation {
    type: yesno
    sql: ${TABLE}."complete_conversation" ;;
  }
  dimension: first_chat_response {
    type: string
    sql: ${TABLE}."first_chat_response" ;;
  }
  dimension: first_name {
    type: string
    sql: ${TABLE}."first_name" ;;
  }
  dimension: first_questions_asked {
    type: yesno
    sql: ${TABLE}."first_questions_asked" ;;
  }
  dimension: gender {
    type: string
    sql: ${TABLE}."gender" ;;
  }
  dimension: phone {
    type: string
    sql: ${TABLE}."phone" ;;
  }
  dimension: score {
    type: number
    sql: ${TABLE}."score" ;;
  }
  dimension: surname {
    type: string
    sql: ${TABLE}."surname" ;;
  }
  measure: count {
    type: count
    drill_fields: [id, surname, first_name]
  }
}
