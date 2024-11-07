
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
              users_vassar u ON u.citizen_id = p.citizen_id
          WHERE
              p.question IN (
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
      opcion_mas_votada AS (
          SELECT
              pregunta,
              respuesta,
              cantidad,
              ROW_NUMBER() OVER (PARTITION BY pregunta ORDER BY cantidad DESC) AS rn
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

  set: detail {
    fields: [
        pregunta,
  respuesta,
  cantidad,
  total_respuestas
    ]
  }
}
