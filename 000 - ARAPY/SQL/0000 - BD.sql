/*
	BASE_DE_DATOS ARAPY
*/


CREATE DATABASE arapy
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'es_ES.UTF-8'
    LC_CTYPE = 'es_ES.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE arapy
    IS 'Base de datos del Sistema Integral de Gestión de la Cooperativa 8 de Marzo Ltda. "Arapy"
@author: jose.acosta
@since: 26.01.2022
@mail: acrajovi@gmail.com';


