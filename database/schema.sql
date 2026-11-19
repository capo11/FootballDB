PRAGMA foreign_keys = ON;

create table if not exists countries (
    id_country integer not null primary key,
    name nvarchar(100) not null,
    unique(name)
);
create table if not exists competitions (
    id_competition integer not null primary key,
    name nvarchar(50) not null,
    season nvarchar(10) not null,
    id_country integer not null,
    foreign key (id_country) references countries(id_country),
    unique(name, season, id_country)
);
create table if not exists teams (
    id_team integer not null primary key,
    name nvarchar(100) not null,
    id_country integer not null,
    foreign key (id_country) references countries(id_country)
    unique(name, id_country)
);
create table if not exists matches (
    id_match integer not null primary key,
    id_competition integer not null,
    id_home_team integer not null,
    id_away_team integer not null,
    home_score integer,
    away_score integer,
    match_date date,
    foreign key (id_competition) references competitions(id_competition),
    foreign key (id_home_team) references teams(id_team),
    foreign key (id_away_team) references teams(id_team),
    unique(id_home_team, id_away_team, match_date)
);
create table if not exists players (
    id_player integer not null primary key,
    name nvarchar(20) not null,
    surname nvarchar(50) not null,
    full_name nvarchar(100) not null,
    id_country integer not null,
    foreign key (id_country) references countries(id_country)
);
create table if not exists shots (
    id_shot integer not null primary key,
    id_match integer not null,
    id_player integer not null,
    id_team integer not null,
    minute integer not null,
    goal varchar,
    foreign key (id_match) references matches(id_match),
    foreign key (id_player) references players(id_player),
    foreign key (id_team) references teams(id_team)
);