BACKEND_SERVICE_HTTP_PORT = 8000

def run(plan, postgres_db, postgress_password):
    postgres_port = "{}".format(postgres_db.service.ports["postgresql"].number)

    container_cmd = "./db-script.sh && python3 manage.py runserver 0.0.0.0:{}".format(
        BACKEND_SERVICE_HTTP_PORT
    )

    service_config_build = ServiceConfig(
        image=ImageBuildSpec(
            image_name="kurtosistech/django-package",
            build_context_dir="/app/files/mysite",
        ),
        env_vars={
            "POSTGRES_DATABASE": postgres_db.database,
            "POSTGRES_ROOT_USER": postgres_db.user,
            "POSTGRES_ROOT_PASSWORD": postgress_password,
            "POSTGRES_HOST": postgres_db.service.hostname,
            "POSTGRES_PORT": postgres_port,
        },
        ports={
            "http": PortSpec(
                number=BACKEND_SERVICE_HTTP_PORT,
                transport_protocol="TCP",
                application_protocol="http",
            ),
        },
        entrypoint=["sh", "-c"],
        cmd=[container_cmd],
    )

    backend_service = plan.add_service(
        name="django-app",
        config=service_config_build,
    )

    return backend_service
