\t on
\c d3 d3$mgr
call mgr.set_role('qa');

delete from support.incidents;
delete from data.masters;
----------------------------------------------------------------------------------------------------
select rule_off('positive tests for qa''s client-side simulation', 'level_2');

select rule_off( $$insert('Fred', null)$$, 'level_3');
select qa_ui_simulation.ui_simulation_insert('Fred', null);

select rule_off( $$insert('Dick', array[]::text[])$$, 'level_3');
select qa_ui_simulation.ui_simulation_insert('Dick', array[]::text[]);

select rule_off( $$insert('Joan', array['saw'])$$, 'level_3');
select qa_ui_simulation.ui_simulation_insert('Joan', array['saw']);

select rule_off( $$insert('Joan', array['screwdriver'])$$, 'level_3');
select qa_ui_simulation.ui_simulation_insert('Joan', array['screwdriver']);

select rule_off( $$insert('John', array['kettle', 'pitcher', 'saucepan'])$$, 'level_3');
select qa_ui_simulation.ui_simulation_insert('John', array['kettle', 'pitcher', 'saucepan']);

select rule_off( $$insert('Mary', array['shampoo', 'soap', 'toothbrush', 'towel'])$$, 'level_3');
select qa_ui_simulation.ui_simulation_insert('Mary', array['shampoo', 'soap', 'toothbrush', 'towel']);

select rule_off($$report ('Fred')$$, 'level_3');
select qa_ui_simulation.ui_simulation_report('Fred');

select rule_off($$report ('Dick')$$, 'level_3');
select qa_ui_simulation.ui_simulation_report('Dick');

select rule_off($$report ('Joan')$$, 'level_3');
select qa_ui_simulation.ui_simulation_report('Joan');

select rule_off($$report ('John')$$, 'level_3');
select qa_ui_simulation.ui_simulation_report('John');

select rule_off($$report ('Mary')$$, 'level_3');
select qa_ui_simulation.ui_simulation_report('Mary');

----------------------------------------------------------------------------------------------------
select rule_off('"user error" tests for qa''s client-side simulation', 'level_2');

select rule_off( $$insert('Jo', array[]::text[])$$, 'level_3');
select qa_ui_simulation.ui_simulation_insert('Jo', array[]::text[]);

select rule_off( $$insert('Joan', array['hammer', 'file', 'saw'])$$, 'level_3');
select qa_ui_simulation.ui_simulation_insert('Joan', array['hammer', 'file', 'saw']);

select rule_off( $$insert('Arthur', array['kitchen scissors', 'saucer', 'spatula', 'spatula', 'kitchen scissors'])$$, 'level_3');
select qa_ui_simulation.ui_simulation_insert('Arthur', array['kitchen scissors', 'saucer', 'spatula', 'spatula', 'kitchen scissors']);

select rule_off($$report ('Bill'))$$, 'level_3');
select qa_ui_simulation.ui_simulation_report('Bill');

----------------------------------------------------------------------------------------------------
select rule_off('"client code error" tests for qa''s client-side simulation', 'level_2');
select rule_off( $$insert('Bert', array[null]::text[])$$, 'level_3');
select qa_ui_simulation.ui_simulation_insert('Bert', array[null]::text[]);

----------------------------------------------------------------------------------------------------
select rule_off('"unexpected error" tests for qa''s client-side simulation', 'level_2');

select rule_off( $$insert('Joan', array['drill', 'small portable workbench'])$$, 'level_3');
select qa_ui_simulation.ui_simulation_insert('Joan', array['drill', 'small portable workbench']);

\t off
