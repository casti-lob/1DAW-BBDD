
alter session set "_oracle_script"=true;  
create user banco identified by banco;
GRANT CONNECT, RESOURCE, DBA TO banco;

--1
SELECT ROUND( AVG(NVL(c.SALDO,0)),2) AS media, SUM(c.SALDO) AS total
FROM CUENTA c ;

--2
SELECT MIN(c.SALDO), MAX(c.SALDO), ROUND( AVG(nvl(c.SALDO,0)),2)  
FROM CUENTA c ;

--3
SELECT SUM(c.SALDO),AVG(nvl(c.SALDO,0))  
FROM CUENTA c 
GROUP BY c.COD_SUCURSAL ;

--4
SELECT c.COD_CLIENTE , SUM(c2.SALDO), COUNT(c2.COD_CUENTA)  
FROM CLIENTE c , CUENTA c2 
WHERE c.COD_CLIENTE = c2.COD_CLIENTE 
GROUP BY c.COD_CLIENTE ;

--5
SELECT c.NOMBRE ||' '||c.APELLIDOS AS nombre , SUM(c2.SALDO), COUNT(c2.COD_CUENTA)  
FROM CLIENTE c , CUENTA c2 
WHERE c.COD_CLIENTE = c2.COD_CLIENTE 
GROUP BY c.NOMBRE ,c.APELLIDOS  ;

--6
SELECT s.DIRECCION , COUNT(c.COD_CUENTA) ,SUM(c.SALDO)  
FROM CUENTA c , SUCURSAL s 
WHERE c.COD_SUCURSAL = s.COD_SUCURSAL 
GROUP BY s.DIRECCION ;

--7
SELECT AVG(nvl(c.SALDO,0)), AVG(nvl(c.INTERES,0))  
FROM CUENTA c 
WHERE c.INTERES >0.10
AND c.COD_SUCURSAL =1
OR  c.COD_SUCURSAL =2;

--8
SELECT tm.COD_TIPO_MOVIMIENTO , tm.DESCRIPCION , SUM(m.IMPORTE) 
FROM TIPO_MOVIMIENTO tm , MOVIMIENTO m 
WHERE tm.COD_TIPO_MOVIMIENTO = m.COD_TIPO_MOVIMIENTO 
GROUP BY tm.COD_TIPO_MOVIMIENTO ,tm.DESCRIPCION ;

--9
SELECT round(AVG(m.IMPORTE),2) 
FROM TIPO_MOVIMIENTO tm , MOVIMIENTO m 
WHERE tm.COD_TIPO_MOVIMIENTO = m.COD_TIPO_MOVIMIENTO 
AND LOWER(tm.COD_TIPO_MOVIMIENTO)='rc' ;

--10
SELECT SUM(m.IMPORTE) 
FROM TIPO_MOVIMIENTO tm ,MOVIMIENTO m 
WHERE tm.COD_TIPO_MOVIMIENTO =m.COD_TIPO_MOVIMIENTO 
AND tm.SALIDA = 'Si'
GROUP BY m.COD_TIPO_MOVIMIENTO ;

--11
SELECT SUM(m.IMPORTE) , tm.DESCRIPCION 
FROM TIPO_MOVIMIENTO tm ,MOVIMIENTO m 
WHERE tm.COD_TIPO_MOVIMIENTO =m.COD_TIPO_MOVIMIENTO 
AND tm.SALIDA = 'No'
GROUP BY tm.DESCRIPCION  ;

--12
SELECT sum(m.IMPORTE)
FROM SUCURSAL s , CUENTA c , MOVIMIENTO m ,TIPO_MOVIMIENTO tm 
WHERE s.COD_SUCURSAL = c.COD_SUCURSAL 
AND c.COD_CUENTA = m.COD_CUENTA 
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO 
AND upper(s.DIRECCION)LIKE '%PASEO CASTELLANA%'
AND tm.SALIDA ='Si';

--13
SELECT c.APELLIDOS ,c.NOMBRE ,c2.COD_CUENTA ,tm.DESCRIPCION ,sum(m.IMPORTE)
FROM CLIENTE c ,CUENTA c2 , MOVIMIENTO m , TIPO_MOVIMIENTO tm 
WHERE c.COD_CLIENTE = c2.COD_CLIENTE 
AND c2.COD_CUENTA = m.COD_CUENTA 
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO 
GROUP BY c.APELLIDOS ,c.NOMBRE ,c2.COD_CUENTA ,tm.DESCRIPCION;

--14 mal
SELECT COUNT(c.COD_CUENTA) 
FROM CUENTA c ,MOVIMIENTO m 
WHERE c.COD_CUENTA = m.COD_CUENTA(+)
AND m.COD_CUENTA IS NULL 
;
SELECT count(DISTINCT c.COD_CUENTA)
FROM CUENTA c ,MOVIMIENTO m 
WHERE c.COD_CUENTA NOT in
					(SELECT m.COD_CUENTA 
					FROM MOVIMIENTO m
					
					);
--15
SELECT c.COD_CLIENTE ,COUNT(c.COD_CUENTA) 
FROM CUENTA c ,MOVIMIENTO m  
WHERE c.COD_CUENTA  = m.COD_CUENTA  (+)
AND c.COD_CUENTA is null
GROUP BY c.COD_CLIENTE  ;


--16
SELECT c.COD_CLIENTE , SUM(c2.SALDO) ,COUNT(c2.COD_CUENTA)  
FROM CLIENTE c ,CUENTA c2 
WHERE c.COD_CLIENTE = c2.COD_CLIENTE 
GROUP BY c.COD_CLIENTE 
HAVING SUM(c2.SALDO)>35000;

--17
SELECT c.APELLIDOS , c.NOMBRE, COUNT(c2.COD_CUENTA)  
FROM CLIENTE c , CUENTA c2 
WHERE c.COD_CLIENTE = c2.COD_CLIENTE 
GROUP BY c.APELLIDOS ,c.NOMBRE 
HAVING  COUNT(c2.COD_CUENTA) >2;

--18
SELECT s.COD_SUCURSAL , s.DIRECCION ,s.CAPITAL_ANIO_ANTERIOR ,SUM(c.SALDO) 
FROM SUCURSAL s , CUENTA c 
WHERE s.COD_SUCURSAL = c.COD_SUCURSAL 
GROUP BY s.COD_SUCURSAL,s.DIRECCION ,s.CAPITAL_ANIO_ANTERIOR 
HAVING SUM(c.SALDO) > s.CAPITAL_ANIO_ANTERIOR 
ORDER BY s.COD_SUCURSAL ;

--19
SELECT c.COD_CUENTA , c.SALDO ,tm.DESCRIPCION ,SUM(m.IMPORTE) 
FROM CUENTA c,MOVIMIENTO m , TIPO_MOVIMIENTO tm 
WHERE c.COD_CUENTA = m.COD_CUENTA 
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO 
GROUP BY c.COD_CUENTA , c.SALDO ,tm.DESCRIPCION 
HAVING SUM(m.IMPORTE)> c.SALDO*0.2; 

--20
SELECT c.COD_CUENTA , c.SALDO ,tm.DESCRIPCION ,SUM(m.IMPORTE) 
FROM CUENTA c,MOVIMIENTO m , TIPO_MOVIMIENTO tm 
WHERE c.COD_CUENTA = m.COD_CUENTA 
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO 
AND c.COD_SUCURSAL !=4
GROUP BY c.COD_CUENTA , c.SALDO ,tm.DESCRIPCION 
HAVING SUM(m.IMPORTE)> c.SALDO*0.1; 

--21
SELECT c.*
FROM CLIENTE c ,CUENTA c2 ,SUCURSAL s
WHERE c.COD_CLIENTE = c2.COD_CLIENTE 
AND c2.COD_SUCURSAL = s.COD_SUCURSAL 
GROUP BY c.COD_CLIENTE ,c.APELLIDOS ,c.NOMBRE ,c.DIRECCION 
HAVING sum(c2.SALDO)>= s.CAPITAL_ANIO_ANTERIOR *0.2; 


















