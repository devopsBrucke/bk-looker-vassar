view: percepciones_sobre_club_colombia {
  derived_table: {
    sql: WITH preguntas_respuestas AS (
          SELECT
              p.question AS pregunta,
              pa.answer AS respuesta
          FROM
              profiling p
          JOIN
              profiling_answers pa ON p.profiling_id = pa.profiling_id
          JOIN
              users_vassar u ON u.phone = p.phone
          WHERE p.question LIKE '%Club Colombia convierte tus momentos en ocasiones especiales%'
             OR p.question LIKE '%Club Colombia es una cerveza de alta calidad%'
             OR p.question LIKE '%Club Colombia es una cerveza que te gusta que te vean consumir%'
             OR p.question LIKE '%¿Qué tan frecuente tomas Club Colombia?%'
             OR p.question LIKE '%¿En qué ocación consumes Club Colombia?%'
             OR p.question LIKE '%Club Colombia es un excelente acompañante para tus comidas%'
             OR p.question LIKE '%Cuéntame, si tuvieras que describir en una palabra cómo mejoró Club Colombia tu experiencia en la feria Vassar, ¿cuál sería?%'
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
      opcion_mas_votada AS (
          SELECT
              pregunta,
              respuesta,
              cantidad,
              RANK() OVER (PARTITION BY pregunta ORDER BY cantidad DESC) AS rn
          FROM
              votaciones
      ),
      totales AS (
          SELECT
              pregunta,
              COUNT(*) AS total_respuestas
          FROM
              preguntas_respuestas
          GROUP BY
              pregunta
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
      WHERE
          omv.rn = 1 ;;
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

  dimension: porcentaje_respuesta {
    type: number
    value_format: "0.00%"  # Opcional, para mostrar el valor en porcentaje
    sql: ${TABLE}."cantidad" * 1.0 / ${TABLE}."total_respuestas" ;;
  }

  set: detail {
    fields: [
      pregunta,
      respuesta,
      cantidad,
      total_respuestas,
      porcentaje_respuesta
    ]
  }
}
