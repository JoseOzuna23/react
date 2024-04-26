/*/*
	PARAMETROS_GENERALES
*/

CREATE TABLE IF NOT EXISTS public.parametros_generales
(
    id character varying(100) NOT NULL,
    valor character varying(100) NOT NULL,
    observacion character varying(500),
    usuariosys character varying(50) NOT NULL,
    CONSTRAINT parametros_generales_pkey PRIMARY KEY (id),
    CONSTRAINT fk_usuarios FOREIGN KEY (usuariosys)
        REFERENCES public.usuarios (usuario) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.parametros_generales
    OWNER to postgres;

COMMENT ON TABLE public.parametros_generales
    IS 'Tabla que contiene datos de parámetros generales a ser utilizados en el sistema.';

COMMENT ON COLUMN public.parametros_generales.id
    IS 'ID identificador de la tupla';
COMMENT ON COLUMN public.parametros_generales.valor
    IS 'Valor correspondiente al parámetro';
COMMENT ON COLUMN public.parametros_generales.observacion
    IS 'Breve descripción o detalle del parámetro';
COMMENT ON COLUMN public.parametros_generales.usuariosys
    IS 'Usuario que realizó última actualización de datos del parámetro';
