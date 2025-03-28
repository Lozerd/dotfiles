#/usr/bin/sh

# function print_error
# { cat <<"EOF"
#     ./upload_dump.sh <action>
#     ...valid actions are...
#         p  : print all screens
# EOF
# }

dumpname=$1
password=$2
username=$3

if [ -z "$password" ]; then
    echo "Please supply a password using 2 argument"
    exit 1
fi



if [[ "$dumpname" == *.dump ]] then
    database_name=$(basename -s .dump $dumpname)

    if [ -z "$username" ]; then
        username=$database_name
    fi

    base_command="psql -U $username -h 127.0.0.1 -W$2"
    inline_argument="-c"
    create_args="owner $username"
    database_flag="-d"
else
    database_name=$(basename -s .sql $dumpname)

    if [ -z "$username" ]; then
        username=$database_name
    fi

    base_command="mariadb -u $username -p$2"
    inline_argument="-e"
    database_flag="-D"
fi

echo "Replacing possibly unsupported encoding..."
sed -i 's/utf8mb4_0900_ai_ci/utf8mb4_unicode_ci/g' $dumpname

# TODO:
# select * from mysql.user where user like '$database_name' and host like 'localhost';
# select * from pg_roles where rolname like '$database_name';
# create if not exists user $database_name with password '$password';
# grant all privileges on $database_name.* to $database_name;
# flush privileges;

echo "Dropping existing database..."
$base_command $inline_argument "drop database if exists $database_name" > /dev/null
echo "Creating database..."
$base_command $inline_argument "create database $database_name $create_args" > /dev/null
echo "Uploading dump..."
$base_command $database_flag $database_name < $dumpname > /dev/null

echo "Done"
exit 0
