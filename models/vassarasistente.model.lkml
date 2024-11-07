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

explore: weeks_completed {}

explore: usuarios_por_semana {}

explore: percepciones_sobre_club_colombia {}
