postgres = import_module("github.com/kurtosis-tech/postgres-package/main.star")
django_app = import_module("/app/app.star")

# Postgres defaults
DEFAULT_POSTGRES_USER = "postgres"
DEFAULT_POSTGRES_PASSWORD = "secretdatabasepassword"
DEFAULT_POSTGRES_DB_NAME = "django-db"
DEFAULT_POSTGRES_SERVICE_NAME = "postgres"

def run(
    plan,
    postgres_user=DEFAULT_POSTGRES_USER,
    postgres_password=DEFAULT_POSTGRES_PASSWORD,
    postgres_db_name=DEFAULT_POSTGRES_DB_NAME,
    postgres_service_name=DEFAULT_POSTGRES_SERVICE_NAME,
):
    """
    Starts this Django example application.

    Args:
        postgres_user (string): the Postgres's user name (default: postgres)
        postgres_password (string): the Postgres's password (default: secretdatabasepassword)
        postgres_db_name (string): the Postgres's db name (default: django-db)
        postgres_service_name (string): the Postgres's service name (default: postgres)
    """

    # run the application's db
    postgres_db = postgres.run(
        plan,
        service_name=postgres_service_name,
        user=postgres_user,
        password=postgres_password,
        database=postgres_db_name,
    )

    # run the application's backend service
    django_app.run(plan, postgres_db, postgres_password)
