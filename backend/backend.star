constants = import_module("/constants/constants.star")


def run(plan, postgres_db, postgress_password):
    postgres_port = "{}".format(postgres_db.service.ports["postgresql"].number)

    service_config_build = ServiceConfig(
        image=ImageBuildSpec(
            image_name=constants.BACKEND_SERVICE_IMAGE_NAME,
            build_context_dir=constants.BACKEND_SERVICE_IMAGE_CONTEXT,
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
                number=constants.BACKEND_SERVICE_HTTP_PORT,
                transport_protocol="TCP",
                application_protocol="http",
            ),
        },
    )

    backend_service = plan.add_service(
        name=constants.BACKEND_SERVICE_NAME,
        config=service_config_build,
    )

    return backend_service
