
select * from valores where nome = 'Y11';
select * from nomes_valores where nome = 'Y11';
select distinct nome from valores;
select * from movimentacoes where nome like '%Y11%';
select year(data), SUM(valor) from movimentacoes where nome like '%Y11%' group by year(data);
select sum(quantidade*preco)/100 from valores;
truncate valores;



select sum(valor)/100 from movimentacoes m
where nome like '%x%';
select sum(valor)/100 from movimentacoes m
where nome not like '%x%';
select nome, sum(valor)/100 from movimentacoes m
where nome like '%x%' group by nome;
select nome, sum(valor)/100 from movimentacoes m
where nome like '%cred%';

select * from movimentacoes m
join valores v on m.nome like concat('%',v.nome,'%'); -- group by v.nome, year(m.data);

select now();
select nome, mes, dividendos/investido from dy where mes=date_format(now(), '%Y-%m');

select * from carteira;
drop view carteira;
create view carteira as
select o.nome, o.investido, o.quantidade, o.investido/o.quantidade as preco_medio,
 max(o.mes) as ultimo_mes, 
 o.dividendos as ultimo_dividendos, 
 o.dividendos/o.investido as ultimo_dy,
 m.dividendos as dividendos_ultimo_mes,
 m.dividendos/m.investido as dy_ultimo_mes,
 a.dividendos as dividendos_ultimo_ano,
 a.dy as dy_ultimo_ano,
 t.dividendos as dividendos_total,
 t.dy as dy_total,
 t.mes as primeiro_mes
 -- (select sum(dividendos)/investido from dy i where ano=year(date_sub(now(), interval 1 year)) and i.nome=o.nome) as dy_ultimo_ano 
from dy o 
left join (select * from dy where mes=date_format(date_sub(now(), interval 1 month), '%Y-%m')) as m on m.nome=o.nome
left join (select nome, sum(dividendos) as dividendos, sum(dividendos)/max(investido) as dy from dy i where ano=year(date_sub(now(), interval 1 year)) group by nome) as a on a.nome=o.nome
left join (select nome, sum(dividendos) as dividendos, sum(dividendos)/max(investido) as dy, min(mes) as mes from dy i group by nome) as t on t.nome=o.nome
join (select max(mes) as mes, nome from dy group by nome) i on o.mes=i.mes and i.nome=o.nome
group by nome;
select max(i.mes) as mes, nome, investido from dy i group by nome;


select nome, investido, sum(dividendos) as dividendos, sum(dividendos)/investido as dy from dy i group by nome;
select nome, max(investido), sum(dividendos) from dy group by nome;
select *, max(mes) from dy group by nome;
select * from dy;
drop view dy;
create view dy as
select ano, mes, i.nome, sum(preco*quantidade)/100 as investido, sum(quantidade) as quantidade, dividendos from valores i join dividendos_mes d
on i.nome = d.nome and date_format(i.data, '%Y-%m') <= d.mes group by nome, mes;

-- investido por ação
select nome, sum(preco*quantidade)/100 as investido from valores group by nome;


select year(m.data) as ano, DATE_FORMAT(m.data,'%Y-%m') as mes, v.nome, sum(m.valor)/100 as dividendos from movimentacoes m
join nomes_valores v on m.nome like concat('%',v.nome,'%'), (select sum(quantidade*preco) from valores where DATE_FORMAT(data,'%Y-%m') <= DATE_FORMAT(m.data,'%Y-%m')) as investido group by v.nome, mes;


select * from dividendos_mes;
drop view dividendos_mes;
create view dividendos_mes as
select year(m.data) as ano, DATE_FORMAT(m.data,'%Y-%m') as mes, v.nome, sum(m.valor)/100 as dividendos from movimentacoes m
join nomes_valores v on m.nome like concat('%',v.nome,'%') group by v.nome, mes;


select year(m.data), (select distinct v.nome from valores v), m.* from movimentacoes m
join valores v on m.nome like concat('%',v.nome,'%');

create view nomes_valores as
select distinct v.nome from valores v;