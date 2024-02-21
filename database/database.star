postgres = import_module("github.com/kurtosis-tech/postgres-package/main.star")


def run(
    plan, postgres_user, postgress_password, postgres_db_name, postgres_service_name
):
    # run the application's db
    postgres_db = postgres.run(
        plan,
        service_name=postgres_service_name,
        user=postgres_user,
        password=postgress_password,
        database=postgres_db_name,
    )

    return postgres_db
