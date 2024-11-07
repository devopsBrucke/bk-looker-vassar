connection: "vassar-asistente"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: vassarasistente_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: vassarasistente_default_datagroup

explore: option_vassar {}

explore: coupons_vassar {}

explore: profiling {}

explore: profiling_answers {}

explore: questions_vassar {}

explore: questionsets_vassar {}

explore: session_vassar {}

explore: users_vassar {}


explore: total_registros {}
explore: conversaciones_iniciadas_porcentaje {}
explore: interaccion_porcentaje {}

explore: week1_completadas {}
explore: week2_completadas {}
explore: week3_completadas {}
explore: week4_completadas {}
explore: week5_completadas {}

explore: edad_mas_repetida {}
explore: genero_mas_repetido {}
explore: ciudad_mas_repetida {}
explore: preguntas_equity {}

explore: weeks_completed {}

explore: usuarios_por_semana {}
