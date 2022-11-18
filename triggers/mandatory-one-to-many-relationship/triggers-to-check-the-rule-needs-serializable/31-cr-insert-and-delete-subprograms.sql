create type code.m_and_ds  as (m  text, ds text[]);
create type code.mk_and_ds as (mk uuid, ds text[]);
--------------------------------------------------------------------------------

create procedure code.insert_master_and_details(
  m_and_ds in code.m_and_ds)
  security definer
  set search_path = pg_catalog, pg_temp
  /*
    This attempt causes the compilation error:
    "SET TRANSACTION ISOLATION LEVEL must be called before any query"

    set transaction_isolation = serializable
  */
  language plpgsql
as $body$
declare
  new_mk uuid not null := extensions.gen_random_uuid();
begin
  with c(v) as (
    select (new_mk, m_and_ds.ds)::code.mk_and_ds)
  insert into data.details(mk, v)
  select (c.v).mk, arr.d
  from c cross join lateral unnest((c.v).ds) as arr(d);

  insert into data.masters(mk, v) values(new_mk, m_and_ds.m);
end;
$body$;
call mgr.revoke_all_from_public('procedure', 'code.insert_master_and_details(code.m_and_ds)');
call mgr.grant_priv( 'execute', 'procedure', 'code.insert_master_and_details(code.m_and_ds)', 'client');
--------------------------------------------------------------------------------

create procedure code.cascade_delete_specified_masters(mvs variadic text[] = null)
  security definer
  set search_path = pg_catalog, pg_temp
  language plpgsql
as $body$
begin
  case
    when mvs is null then
      delete from data.masters;
    else
      delete from data.masters where v = any(mvs);
  end case;
end;
$body$;
call mgr.revoke_all_from_public('procedure', 'code.cascade_delete_specified_masters(text[])');
call mgr.grant_priv( 'execute', 'procedure', 'code.cascade_delete_specified_masters(text[])', 'client');
--------------------------------------------------------------------------------

create procedure code.delete_specified_details(dvs variadic text[] = null)
  security definer
  set search_path = pg_catalog, pg_temp
  language plpgsql
as $body$
begin
  case
    when dvs is null then
      null;
    else
      delete from data.details where v = any(dvs);
  end case;
end;
$body$;
call mgr.revoke_all_from_public('procedure', 'code.delete_specified_details(text[])');
call mgr.grant_priv( 'execute', 'procedure', 'code.delete_specified_details(text[])', 'client');
--------------------------------------------------------------------------------

create procedure code.delete_all_details_for_a_master(mv_in text)
  security definer
  set search_path = pg_catalog, pg_temp
  language plpgsql
as $body$
declare
  mv text not null := mv_in;
begin
  delete from data.details d where d.mk =
    (select mk from data.masters m where v = mv);
end;
$body$;
call mgr.revoke_all_from_public('procedure', 'code.delete_all_details_for_a_master(text)');
call mgr.grant_priv( 'execute', 'procedure', 'code.delete_all_details_for_a_master(text)', 'client');

