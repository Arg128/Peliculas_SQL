#!/usr/bin/perl
use strict;
use warnings;
use CGI qw(:standard);
use DBI;

# Configuración de conexión
my $database = "prueba";
my $hostname = "mariadb2";         # Nombre del contenedor MariaDB
my $port     = 3307;               # Puerto predeterminado de MariaDB
my $user     = "root";             # Usuario de MariaDB
my $password = "tu_contraseña_segura"; # Contraseña para el usuario root

# DSN de conexión
my $dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";

# Crear un nuevo objeto CGI
my $query = CGI->new();

# Conectar a la base de datos
my $dbh = DBI->connect($dsn, $user, $password, {
    RaiseError       => 1,
    PrintError       => 0,
    mysql_enable_utf8 => 1,
});

print $query->header(-type => 'text/html', -charset => 'utf-8');
print $query->start_html('Resultados');
print $query->h1('Películas con Puntaje Mayor a 7 y Más de 5000 Votos');

print $query->h2('A continuación se insertaran en un formato de tabla:');

if ($dbh) {
    # Consulta para obtener las películas con puntaje mayor a 7 y más de 5000 votos
    my $sql = "SELECT nombre, year, vote, score FROM peliculas WHERE score > 7 AND vote > 5000";
    ##Preparamos y...
    my $sth = $dbh->prepare($sql);
    ##Ejecutamos yeih
    $sth->execute();
    
    # Imprimime los resultado en tablas de HTML
    print "<table border='3'>";
    print "<tr><th>Nombre</th><th>Año</th><th>Votos</th><th>Puntaje</th></tr>";
    while (my @row = $sth->fetchrow_array) {
        print "<tr>";
        ##Si nos damos cuenta, cada numerito representa un campo de la tabla SQL
        print "<td>" . $row[0] . "</td>";
        print "<td>" . $row[1] . "</td>";
        print "<td>" . $row[2] . "</td>";
        print "<td>" . $row[3] . "</td>";
        print "</tr>";
    }
    print "</table>";
    
    $sth->finish();
    $dbh->disconnect();
} else {
    die "Error al conectar a la base de datos: $DBI::errstr\n";
}

print $query->end_html;
