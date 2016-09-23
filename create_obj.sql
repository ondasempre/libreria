create table utente(
nome varchar2(30) not null,
cognome varchar2(30) not null,
indirizzo varchar2(30) not null,
cap char(5) not null,
nascita date not null,
username varchar2(10),
password varchar2(10) not null,
email varchar2(50) not null,
constraint p_user primary key(username));

create sequence ordine_seq;

create table ordine(
id_ordine int,
totale number(5,2),
data date not null,
username varchar2(10),
constraint p_idordine primary key(id_ordine),
constraint f_username foreign key(username)
references utente(username));

create table articolo(
id_articolo int,
titolo varchar2(30) not null,
autore varchar2(30) not null,
prezzo number(5,2) not null,
constraint p_idarticolo primary key(id_articolo));

create table ordine_articolo(
id_ordine int,
id_articolo int,
quantita int default 1,
constraint f_idordine foreign key(id_ordine) references ordine(id_ordine),
constraint f_idarticolo foreign key(id_articolo) references articolo(id_articolo),
constraint p_oa primary key(id_ordine, id_articolo));

create view report as
select
utente.username, email, ordine.id_ordine, totale, sum(quantita) as quantita
from
utente, ordine, articolo, ordine_articolo
where 
ordine_articolo.id_ordine = ordine.id_ordine
and
ordine_articolo.id_articolo = articolo.id_articolo
and
utente.username = ordine.username
group by utente.username, email, ordine.id_ordine, totale
order by ordine.id_ordine, utente.username;