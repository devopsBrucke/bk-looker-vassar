view: users_vassar {
  sql_table_name: public.users_vassar ;;
  drill_fields: [id]

  # Dimensiones básicas
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

  # Medida de conteo total
  measure: total_conversaciones {
    type: count
    description: "Total de conversaciones registradas"
  }
  measure: total_registros{
    type: count
  }
  # Medida para porcentaje de conversaciones iniciadas
  measure: porcentaje_conversaciones_iniciadas {
    type: number
    sql: ROUND(
      (COUNT(CASE WHEN ${first_chat_response} = 'inicia asistente' THEN 1 END) * 100.0) / COUNT(*),
      2
    ) ;;
    value_format: "0.00\%"
    description: "Porcentaje de conversaciones iniciadas por el asistente"
  }

  # Medida para porcentaje de conversaciones no iniciadas
  measure: porcentaje_conversaciones_no_iniciadas {
    type: number
    sql: ROUND(
      (COUNT(CASE WHEN ${first_chat_response} != 'inicia asistente' OR ${first_chat_response} IS NULL THEN 1 END) * 100.0) / COUNT(*),
      2
    ) ;;
    value_format: "0.00\%"
    description: "Porcentaje de conversaciones no iniciadas por el asistente"
  }
 measure: count {
   type: count
 }
}
