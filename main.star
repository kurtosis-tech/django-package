constants = import_module("/constants/constants.star")
database = import_module("/database/database.star")
django_app = import_module("/app/app.star")


def run(
    plan,
    postgres_user=constants.DEFAULT_POSTGRES_USER,
    postgres_password=constants.DEFAULT_POSTGRES_PASSWORD,
    postgres_db_name=constants.DEFAULT_POSTGRES_DB_NAME,
    postgres_service_name=constants.DEFAULT_POSTGRES_SERVICE_NAME,
):
    """
    Starts this Django example application.

    Args:
        postgres_user (string): the Postgres's user name (default: postgres)
        postgres_password (string): the Postgres's password (default: secretdatabasepassword)
        postgres_db_name (string): the Postgres's db name (default: django-db)
        postgres_service_name: the Postgres's service name (default: postgres)
    """

    # run the application's database
    postgres_db = database.run(
        plan, postgres_user, postgres_password, postgres_db_name, postgres_service_name
    )

    # run the application's backend service
    django_app.run(plan, postgres_db, postgres_password)
