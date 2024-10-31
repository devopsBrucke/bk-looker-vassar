view: preguntas_equity {
  derived_table: {
    sql: WITH preguntas_respuestas AS (
          SELECT
              u.first_name,
              u.phone,
              profiling_item->>'question' AS pregunta,
              profiling_item->>'answer' AS respuesta
          FROM
              users_vassar u,
              jsonb_array_elements(u.profiling) AS profiling_item
          WHERE
              profiling_item->>'question' IN (
                  'Club Colombia es una cerveza de alta calidad.',
                  'Club Colombia convierte tus momentos en ocasiones especiales.',
                  'Club Colombia usa los mejores ingredientes en sus cervezas.',
                  'Club Colombia es un excelente acompañante para las comidas.',
                  'Club Colombia mejoró tu experiencia en la Feria Vassar.'
              )
      ),
      votaciones AS (
          SELECT
              pregunta,
              respuesta,
              COUNT(*) AS cantidad
          FROM
              preguntas_respuestas
          GROUP BY
              pregunta, respuesta
      ),
      totales AS (
          SELECT
              pregunta,
              COUNT(*) AS total_respuestas
          FROM
              preguntas_respuestas
          GROUP BY
              pregunta
      ),
      opcion_mas_votada AS (
          SELECT
              v.pregunta,
              v.respuesta,
              v.cantidad
          FROM
              votaciones v
          WHERE
              (v.pregunta, v.cantidad) IN (
                  SELECT
                      pregunta, MAX(cantidad)
                  FROM
                      votaciones
                  GROUP BY
                      pregunta
              )
      )
      SELECT
          omv.pregunta,
          omv.respuesta,
          omv.cantidad,
          t.total_respuestas
      FROM
          opcion_mas_votada omv
      JOIN
          totales t ON omv.pregunta = t.pregunta
      ORDER BY
          omv.pregunta ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: pregunta {
    type: string
    sql: ${TABLE}."pregunta" ;;
  }

  dimension: respuesta {
    type: string
    sql: ${TABLE}."respuesta" ;;
  }

  dimension: cantidad {
    type: number
    sql: ${TABLE}."cantidad" ;;
  }

  dimension: total_respuestas {
    type: number
    sql: ${TABLE}."total_respuestas" ;;
  }

  set: detail {
    fields: [
      pregunta,
      respuesta,
      cantidad,
      total_respuestas
    ]
  }
  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: preguntas_equity {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
