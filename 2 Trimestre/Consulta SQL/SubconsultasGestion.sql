/*
 * 1 Número de clientes que tienen alguna factura con IVA 16%.
*/

SELECT COUNT(c.CODCLI) 
FROM CLIENTES c 
WHERE c.CODCLI in
				( 
				SELECT f.CODCLI 
				FROM FACTURAS f 
				WHERE f.IVA =16
				);

/*
 * 2 Número de clientes que no tienen ninguna factura 
 * con un 16% de IVA.
 */

SELECT COUNT(c.CODCLI) 
FROM CLIENTES c 
WHERE c.CODCLI  = all
				(
				SELECT f.CODCLI 
				FROM FACTURAS f 
				WHERE f.IVA !=16
				);

/*
 * 3 Número de clientes que en todas sus facturas tienen un 
 * 16% de IVA (los clientes deben tener al menos una factura).
 */
SELECT COUNT(c.CODCLI) 
FROM CLIENTES c 
WHERE c.CODCLI = all
				( 
				SELECT f.CODCLI 
				FROM FACTURAS f 
				WHERE f.IVA =16
				);

/*
 * 4 Fecha de la factura con mayor importe (sin tener en 
 * cuenta descuentos ni impuestos).
 */
SELECT f.FECHA 
FROM FACTURAS f , LINEAS_FAC lf
WHERE f.CODFAC = lf.CODFAC 
AND lf.PRECIO = 
				(
				SELECT MAX(lf.PRECIO) 
				FROM LINEAS_FAC lf
				);
/*
 * 5 Número de pueblos en los que no tenemos clientes.
 */
SELECT COUNT(p.CODPUE) 
FROM PUEBLOS p 
WHERE p.CODPUE NOT IN
					(
					SELECT c.CODPUE 
					FROM CLIENTES c 
					);
/*
 * 6 Número de artículos cuyo stock supera las 20 unidades, 
 * con precio superior a 15 euros y de los que no hay ninguna 
 * factura en el último trimestre del año pasado.
 */
SELECT COUNT(a.CODART) 
FROM ARTICULOS a ,LINEAS_FAC lf 
WHERE a.CODART = lf.CODART 
AND a.PRECIO >15
AND a.STOCK >20
AND lf.CODFAC NOT IN 
					(
					SELECT f.CODFAC 
					FROM FACTURAS f 
					WHERE EXTRACT(YEAR FROM f.FECHA)= EXTRACT(YEAR FROM sysdate)-1
					AND EXTRACT(MONTH FROM f.FECHA)>6
					AND EXTRACT(MONTH FROM f.FECHA)<10
					);
/*
 * 7 Obtener el número de clientes que en todas las facturas del 
 * año pasado han pagado IVA (no se ha pagado IVA si es cero o 
 * nulo).
 */
SELECT COUNT(c.CODCLI) 
FROM CLIENTES c 
WHERE c.CODCLI in
				(
				SELECT f.CODCLI 
				FROM FACTURAS f 
				WHERE nvl(f.IVA,0) =0
				);

/*
 * 8 Clientes (código y nombre) que fueron preferentes durante 
 * el mes de noviembre del año pasado y que en diciembre de 
 * ese mismo año no tienen ninguna factura. Son clientes 
 * preferentes de un mes aquellos que han solicitado más de 
 * 60,50 euros en facturas durante ese mes, sin tener en cuenta 
 * descuentos ni impuestos.
 */
SELECT c.CODCLI , c.NOMBRE 
FROM  CLIENTES c 
WHERE c.CODCLI = 
				(
				SELECT f.CODCLI 
				FROM FACTURAS f 
				WHERE EXTRACT (MONTH FROM f.FECHA)<11
				AND EXTRACT(YEAR FROM f.FECHA)= EXTRACT(YEAR FROM sysdate)-1
				AND f.CODFAC in
								(SELECT lf.CODFAC 
								FROM LINEAS_FAC lf
								WHERE lf.PRECIO >60.50)
				)
AND  c.CODCLI =	(
				SELECT f.CODCLI 
				FROM FACTURAS f 
				WHERE EXTRACT (MONTH FROM f.FECHA)=12
				AND EXTRACT(YEAR FROM f.FECHA)= EXTRACT(YEAR FROM sysdate)-1
				AND f.CODFAC NOT in	
								(SELECT lf.CODFAC 
								FROM LINEAS_FAC lf
								)
				);
/*
 * 9 Código, descripción y precio de los diez artículos más caros.
 */
SELECT a.CODART , a.DESCRIP , a.PRECIO 
FROM ARTICULOS a 
WHERE a.PRECIO = all
				(
				SELECT MAX(a.PRECIO) 
				FROM ARTICULOS a

				)
AND rownum<=10;

/*
 * 10 Nombre de la provincia con mayor número de clientes.
 * Mal
 */
SELECT p.NOMBRE 
FROM PROVINCIAS p,PUEBLOS p2, CLIENTES c 
WHERE p.CODPRO =p2.CODPRO 
AND p2.CODPUE = c.CODPUE 
GROUP BY p.NOMBRE 
HAVING COUNT(c.CODCLI)= (
                        SELECT MAX(COUNT(c.CODCLI))
                        FROM PROVINCIAS p,PUEBLOS p2, CLIENTES c 
                        WHERE p.CODPRO =p2.CODPRO 
                        AND p2.CODPUE = c.CODPUE 
                        GROUP BY p.CODPRO
                        );
	
/*
 * 11 Código y descripción de los artículos cuyo precio es 
 * mayor de 90,15 euros y se han vendido menos de 10 unidades 
 * (o ninguna) durante el año pasado.
 */		
SELECT a.CODART , a.DESCRIP 
FROM ARTICULOS a , LINEAS_FAC lf 
WHERE a.CODART = lf.CODART 
AND a.PRECIO >90.15
AND a.CODART IN(
                SELECT lf.CODART
                FROM FACTURAS f , LINEAS_FAC lf 
                WHERE lf.CODFAC = f.CODFAC
                AND EXTRACT(YEAR FROM f.FECHA)= EXTRACT(YEAR FROM SYSDATE)-1
                GROUP BY lf.CODART
                HAVING SUM(lf.cant)<10
                )
			
/*
 * 12 Código y descripción de los artículos cuyo precio es más 
 * de tres mil veces mayor que el precio mínimo de cualquier 
 * artículo.
 */
SELECT DISTINCT  a.CODART , a.DESCRIP 
FROM ARTICULOS a 
WHERE a.PRECIO >
				(
				SELECT MIN(a.PRECIO)*3 
				FROM ARTICULOS a
				);
/*
 * 13 Nombre del cliente con mayor facturación.
 */
SELECT DISTINCT  c.NOMBRE 
FROM CLIENTES c , FACTURAS f, LINEAS_FAC lf 
WHERE c.CODCLI =f.CODCLI 
AND f.CODFAC = lf.CODFAC 
AND lf.PRECIO =
				(
				SELECT MAX(lf.PRECIO)
				FROM LINEAS_FAC lf2 
				);
/*
 * 14 Código y descripción de aquellos artículos con un precio 
 * superior a la media y que hayan sido comprados por más 
 * de 5 clientes.
 */
SELECT a.CODART , a.DESCRIP 
FROM ARTICULOS a 
WHERE a.PRECIO >
				(
				SELECT AVG(NVL(a.PRECIO,0)) 
				FROM ARTICULOS a, LINEAS_FAC lf , FACTURAS f  
				WHERE a.CODART = lf.CODART 
				AND lf.CODFAC = f.CODFAC 
				GROUP BY lf.CODART 
				HAVING COUNT(f.CODCLI) >5
				);
	
			
