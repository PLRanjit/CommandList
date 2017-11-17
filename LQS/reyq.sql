-----------------------------Enable disable constraint---------------
SELECT * FROM user_constraints WHERE table_name = 'BP_DEALER';
alter table BP_DEALER ENABLE constraint SYS_C0038848;
alter table BP_DEALER DISABLE constraint SYS_C0038848;

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
