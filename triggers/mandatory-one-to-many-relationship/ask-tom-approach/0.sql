\c d4 d4$mgr
call mgr.drop_all_regular_local_roles();
call mgr.comment_on_current_db(
  '"Enforcing the mandatory 1:M rule with a mutual FK between '||e'\n'||
  'the "masters" and "details" tables. ');

call mgr.cr_role('data', with_temp_on_db=>true, comment=>'Owns all the tables and associated objects that implement this case study');
call mgr.cr_role('code', comment=>'Owns all the code that accesses the tables that "data" owns');

call mgr.set_role_search_path('client', 'code, client_safe, pg_catalog, pg_temp');

\ir 10-cr-tables.sql
\ir 20-cr-triggers.sql
\ir 30-cr-insert-and-delete-subprograms.sql
\ir 31-cr-reporting-subprograms.sql
\ir 40-populate-test-data.sql
/*
  OR...
  \ir 41-do-manual-single-session-test-for-set-constraints-all-immediate.sql
*/;
\ir 50-do-single-session-tests.sql

/*
  THIS TEST MUST BE DONE MANUALLY TO CO-ORDINATE INTERLEAVING STEPS
  IN TWO CONURRENT SESSIONS

  60-do-two-session-tests.sql
*/;