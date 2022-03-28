
/*
 * Nombre, apellido y teléfono de todos 
 * los afiliados que sean hombres y que 
 * hayan nacido antes del 1 de enero de 
 * 1070
 */
SELECT a.NOMBRE , a.APELLIDOS , a.TELF 
FROM AFILIADOS a 
WHERE a.NACIMIENTO  < to_date('01-01-1070','DD-MM-YYYY');

/*
 * Peso, talla  y nombre de todos los 
 * peces que se han pescado por con talla 
 * inferior o igual a 45. Los datos deben 
 * salir ordenados por el nombre del pez, 
 * y para el mismo pez por el peso 
 * (primero los más grandes) y para el 
 * mismo peso por la talla (primero los 
 * más grandes).
 */





















