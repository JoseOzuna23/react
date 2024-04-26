/*
	ESTADOS_USUARIOS
*/

CREATE TABLE IF NOT EXISTS public.estados_usuarios
(
    id SERIAL NOT NULL,
    descrpcion character varying(100) NOT NULL,
    usuariosys character varying(50) NOT NULL,
    CONSTRAINT pk_estados_usuarios PRIMARY KEY (id),
    CONSTRAINT uk_estados_usuarios_descripcion UNIQUE (descrpcion)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.estados_usuarios
    OWNER to postgres;

COMMENT ON TABLE public.estados_usuarios
    IS 'Tabla que contiene datos de estados a ser aplicados a los usuarios';    
COMMENT ON COLUMN public.estados_usuarios.id
    IS 'ID identificador de la tupla';
COMMENT ON COLUMN public.estados_usuarios.descrpcion
    IS 'Descripción del estado. Este dato no puede repetirse';
COMMENT ON COLUMN public.estados_usuarios.usuariosys
    IS 'Usuario que realiza la última acción';
    
    
/*
	USUARIOS
*/


CREATE TABLE IF NOT EXISTS public.usuarios
(
    usuario character varying(50) NOT NULL,
    nro_doc character varying(15) NOT NULL,
    nombres_apellidos character varying(200) NOT NULL,
    password character varying(100),
    fecha_caduca_password timestamp without time zone,
    id_estado integer NOT NULL,
    fecha_mod_estado timestamp without time zone,
    acceso_privilegiado boolean NOT NULL DEFAULT false,
    tiempo_inactividad integer DEFAULT 15,
    fecha_ultimo_acceso timestamp without time zone,   
    ip_ultimo_acceso character varying(15) ,
    extras_ultimo_acceso character varying(500),
    sesion character varying(100) COLLATE pg_catalog."default",
    sesion_exp timestamp without time zone,
    fecha_registro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    usuariosys character varying(50) NOT NULL,
    CONSTRAINT pk_usuarios PRIMARY KEY (usuario),
    CONSTRAINT uk_usuarios_nro_doc UNIQUE (nro_doc),  
    CONSTRAINT fk_usuarios_estados FOREIGN KEY (id_estado)
        REFERENCES public.estados_usuarios (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.usuarios
    OWNER to postgres;
COMMENT ON TABLE public.usuarios
  IS 'Tabla que contiene datos de los usuarios';
COMMENT ON COLUMN public.usuarios.usuario
  IS 'Usuario. ID identificador de la tupla';
COMMENT ON COLUMN public.usuarios.nro_doc
  IS 'Número de documento del usuario. Este dato no puede repetirse';
COMMENT ON COLUMN public.usuarios.nombres_apellidos
    IS 'Nombres y apellidos del usuario';
COMMENT ON COLUMN public.usuarios.password
    IS 'Contraseña del usuario';
COMMENT ON COLUMN public.usuarios.fecha_caduca_password
    IS 'Fecha en la que el usuario debe cambiar la contraseña';
COMMENT ON COLUMN public.usuarios.id_estado
    IS 'Estado del usuario. Llave foránea de la tabla estados_usuarios';
COMMENT ON COLUMN public.usuarios.fecha_mod_estado
    IS 'Fecha de modificación del estado del usuario';
COMMENT ON COLUMN public.usuarios.acceso_privilegiado
    IS 'Indica si el usuario puede acceder fuera del horario establecido';
COMMENT ON COLUMN public.usuarios.tiempo_inactividad
    IS 'Tiempo máximo de inactividad, pasado el tiempo la sesión expira';
COMMENT ON COLUMN public.usuarios.fecha_ultimo_acceso
    IS 'Fecha en la que el usuario accedió por última vez';
COMMENT ON COLUMN public.usuarios.ip_ultimo_acceso
    IS 'Dirección ip del último acceso';
COMMENT ON COLUMN public.usuarios.extras_ultimo_acceso
    IS 'Datos extras que se pueda obtener del último acceso';
COMMENT ON COLUMN public.usuarios.fecha_registro
    IS 'Fecha en la que se dió de alta al usuario';
COMMENT ON COLUMN public.usuarios.usuariosys
    IS 'Usuario que realizó última actualización de datos del usuario';
COMMENT ON COLUMN public.usuarios.sesion
    IS 'Refresh Token';
COMMENT ON COLUMN public.usuarios.sesion_exp
    IS 'Tiempo de expiración del Refresh Token';




/*
	ROLES
*/

CREATE TABLE IF NOT EXISTS public.roles
(
    id SERIAL NOT NULL,
    descrpcion character varying(100) NOT NULL,
    observacion character varying(500) NOT NULL,
    usuariosys character varying(50) NOT NULL,
    CONSTRAINT pk_roles PRIMARY KEY (id),
    CONSTRAINT uk_roles_descripcion UNIQUE (descrpcion)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.roles
    OWNER to postgres;
COMMENT ON TABLE public.roles
  IS 'Tabla que contiene datos de roles';
COMMENT ON COLUMN public.roles.id
    IS 'ID identificador de la tupla';
COMMENT ON COLUMN public.roles.descrpcion
    IS 'Descripción del rol. Este dato no puede repetirse';
COMMENT ON COLUMN public.roles.usuariosys
    IS 'Usuario que realizó última actualización de datos del rol';


