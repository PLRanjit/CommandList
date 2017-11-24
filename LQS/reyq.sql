-----------------------------Enable disable constraint---------------
SELECT * FROM user_constraints WHERE table_name = :TableName;
alter table TableName ENABLE constraint constraintName;
alter table TableName DISABLE constraint constraintName;

----------------------Find column in entire databse--------------
desc all_tab_cols;
SELECT table_name,column_name FROM all_tab_cols where column_name = 'EFFECTIVE_DATE';

------------------------foreign key , primanay key table with constraint-------------------
SELECT a.table_name, a.column_name, a.constraint_name, c.owner, 
       -- referenced pk
       c.r_owner, c_pk.table_name r_table_name, c_pk.constraint_name r_pk
  FROM all_cons_columns a
  JOIN all_constraints c ON a.owner = c.owner
                        AND a.constraint_name = c.constraint_name
  JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
                           AND c.r_constraint_name = c_pk.constraint_name
 WHERE c.constraint_type = 'R'
   AND a.table_name = :TableName;
   
---------------------------------------SESSION OBJECT LOCKED-------------------------
SELECT O.OBJECT_NAME, S.SID, S.SERIAL#, P.SPID, S.PROGRAM,SQ.SQL_FULLTEXT, S.LOGON_TIME
FROM V$LOCKED_OBJECT L, DBA_OBJECTS O, V$SESSION S, V$PROCESS P, V$SQL SQ WHERE L.OBJECT_ID = O.OBJECT_ID AND L.SESSION_ID = S.SID AND S.PADDR = P.ADDR AND S.SQL_ADDRESS = SQ.ADDRESS;

SELECT O.OBJECT_NAME, S.SID, S.SERIAL#, P.SPID, S.PROGRAM,S.USERNAME,S.MACHINE,S.PORT ,S.LOGON_TIME,SQ.SQL_FULLTEXT 
FROM V$LOCKED_OBJECT L, DBA_OBJECTS O, V$SESSION S, V$PROCESS P, V$SQL SQ WHERE L.OBJECT_ID = O.OBJECT_ID AND L.SESSION_ID = S.SID AND S.PADDR = P.ADDR AND S.SQL_ADDRESS = SQ.ADDRESS;

SELECT O.OBJECT_NAME, S.SID, S.SERIAL#, P.SPID, S.PROGRAM,S.USERNAME,S.MACHINE,S.PORT ,S.LOGON_TIME,SQ.SQL_FULLTEXT 
FROM V$LOCKED_OBJECT L, DBA_OBJECTS O, V$SESSION S, V$PROCESS P, V$SQL SQ WHERE L.OBJECT_ID = O.OBJECT_ID AND L.SESSION_ID = S.SID AND S.PADDR = P.ADDR AND S.SQL_ADDRESS = SQ.ADDRESS; 

-------------------------------------------RECOVER DROPPED TABLE--------------------------
select object_name, original_name, type from recyclebin;

flashback table TableName to before drop;

-----------------------------------------------------------CONSTRAINSS--------------------

alter table TableName
drop constraint foreignKeyName;

alter table TableName
add constraint foreignKeyName
foreign key (ColumnName)
references Ref_TableName (Ref_ColumnName)
on delete cascade;

--------------------------------------------
